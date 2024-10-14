class FetchGroupDebtService
    def initialize(group)
        @group = group
    end
    
    def call
        fetch_debts
    end
    
    private
    
    attr_reader :group
    
    def fetch_debts
        if @group.IsSimplifyDebtEnabled
            fetch_simplify_debts_of_group
        else
            fetch_all_debts_of_group
        end
    end

    #Fetch all the debts of the group
    def fetch_all_debts_of_group
        owed_amount = []
        grouped_transactions = fetch_expense_transactions.group_by(&:payer_id)
        grouped_transactions.flat_map do |payer_id, transactions|
            transactions.group_by(&:payee_id).map do |payee_id, payee_transactions|
                total_amount = payee_transactions.sum(&:amount_paid)
                owed_amount << { payee_id: payee_id, payer_id: payer_id,
                        amount_to_be_paid: total_amount,
                        display_message: "User #{payee_id} owe #{total_amount} User #{payer_id}"
                    }
            end
        end
        owed_amount
    end

    #Simplifies the selement of debts among the users of the group
    def fetch_simplify_debts_of_group
        owed_amount = []
        total_amount = data_prep
        debt_users = total_amount.select{ |user, amount| amount > 0 }
        credit_users = total_amount.select{ |user, amount| amount < 0 }
        credit_users.each do |credit_user, credit_amount|
            credit_amount = -(credit_amount)
            debt_users.each do |debt_user, debt_amount|
                next if debt_amount == 0
                if (credit_amount > debt_amount )
                    credit_users[credit_user] = credit_amount - debt_amount
                    owed_amount << { payee_id: credit_user, payer_id: debt_user,
                        amount_to_be_paid: debt_users[debt_user],
                         display_message:  "User#{credit_user} owe #{debt_user} User #{debt_users[debt_user]}"
                    } 
                    debt_users[debt_user] = 0
                    credit_amount = credit_users[credit_user] 
                    
                else
                    owed_amount << { payee_id: credit_user, payer_id: debt_user,
                        amount_to_be_paid: credit_amount,
                        display_message: "User #{credit_user} owe #{credit_amount} User #{debt_user}"
                    } 
                    debt_users[debt_user] = debt_amount - credit_amount
                    credit_users[credit_user] = 0  
                end
            end
        end
        owed_amount
    end
    
    #Fetch all the expense_transactions of the group
    def fetch_expense_transactions
        @fetch_expense_transactions ||= ExpenseTransaction.includes(:expense).
            where(expenses: { group_id: @group.id}).where('amount_paid > ?', 0).
            where.not('payer_id = payee_id')
    end

    #List of the user with credit 
    def fetch_all_user_credit(grouped_transactions)
        grouped_transactions.each_with_object({}) do |(payee_id, transactions), result|
            total_amount = transactions.sum(&:amount_paid).to_f
            result[payee_id] = -total_amount # Store the negative sum for each payee_id
        end
    end

    #List of the user with debt 
    def fetch_all_user_debit(grouped_transactions)
        grouped_transactions.each_with_object({}) do |(payer_id, transactions), result|
            transactions.group_by(&:payer_id).map do |payee_id, payee_transactions|
                result[payer_id] =+ payee_transactions.sum(&:amount_paid).to_f
            end
        end
    end

    # Prepare a hash to hold results for all users in the group
    def data_prep
        transactions = fetch_expense_transactions
        users_credits = fetch_all_user_credit(transactions.group_by(&:payee_id))
        users_debits = fetch_all_user_debit(transactions.group_by(&:payer_id))

        # Merge hashes and sum values(amount) with the same keys(users)
        users_debits = fetch_all_user_debit(transactions.group_by(&:payer_id))
        total_amount = users_debits.merge(users_credits) do |key, old_value, new_value|
            old_value + new_value
        end
        total_amount
    end

end

