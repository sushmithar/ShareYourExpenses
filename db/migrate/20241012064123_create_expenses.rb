class CreateExpenses < ActiveRecord::Migration[7.1]
  def change
    create_table :expenses do |t|
      t.references :group, null: false, foreign_key: true
      t.string :name
      t.decimal :total_amount
      t.string :category
      t.boolean :split_equaly
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
