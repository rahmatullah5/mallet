class RemoveTargetableConstrainFromTransaction < ActiveRecord::Migration[6.0]
  def change
    change_column :transactions, :targetable_type, :string, :null => true
    change_column :transactions, :targetable_id, :integer, :null => true
  end
end
