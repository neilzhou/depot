class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :number
      t.decimal :balance, precision: 10, scale: 2, default: 0

      t.timestamps
    end
  end
end
