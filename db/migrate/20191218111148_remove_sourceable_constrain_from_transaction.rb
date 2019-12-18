class RemoveSourceableConstrainFromTransaction < ActiveRecord::Migration[6.0]
  def change
    change_column :transactions, :sourceable_type, :string, :null => true
    change_column :transactions, :sourceable_id, :integer, :null => true
  end
end
