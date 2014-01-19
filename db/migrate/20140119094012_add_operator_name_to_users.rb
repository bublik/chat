class AddOperatorNameToUsers < ActiveRecord::Migration
  def up
    add_column :users, :operator_name, :string
  end

  def down
    remove_column :users, :operator_name
  end
end
