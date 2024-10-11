class CreateGroups < ActiveRecord::Migration[7.1]
  def change
    create_table :groups do |t|
      t.string :group_name
      t.text :description
      t.string :group_type
      t.string :currency
      t.boolean :IsSimplifyDebtEnabled, default: false

      t.timestamps
    end
  end
end
