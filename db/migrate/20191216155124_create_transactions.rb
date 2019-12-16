class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.references :sourceable, polymorphic: true, null: false
      t.references :targetable, polymorphic: true, null: false
      t.float :amount

      t.timestamps
    end
  end
end
