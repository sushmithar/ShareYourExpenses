class CreateExpenseTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :expense_transactions do |t|
      t.references :expense, null: false, foreign_key: true
      t.references :payer, null: false, foreign_key: { to_table: :users }
      t.references :payee, null: false, foreign_key: { to_table: :users }
      t.decimal :amount_paid, precision: 10, scale: 2, null: false
      t.datetime :transaction_date, null: false

      t.timestamps
    end
  end
end
