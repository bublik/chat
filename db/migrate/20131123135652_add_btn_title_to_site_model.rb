class AddBtnTitleToSiteModel < ActiveRecord::Migration
  def up
    add_column :sites, :btn_title, :string, default: 'Online Help'
  end

  def down
    remove_column :sites, :btn_title
  end

end
