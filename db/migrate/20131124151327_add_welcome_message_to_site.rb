class AddWelcomeMessageToSite < ActiveRecord::Migration
  def up
    add_column :sites, :sales_welcome_message, :string
  end

  def down
    remove_column :sites, :sales_welcome_message
  end
end
