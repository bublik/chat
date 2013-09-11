class CreateSiteCategories < ActiveRecord::Migration
  def up
    create_table :site_categories do |t|
      t.string :name, :null => false

      t.timestamps
    end
  end

  def down
    drop_table :site_categories
  end
end
