class CreateSites < ActiveRecord::Migration
  def up
    create_table :sites do |t|
      t.string :name, :null => false
      t.string :domain, :null => false
      t.references :site_category, index: true
      t.references :user, index: true
      t.string :color, :null => false
      t.string :side, :null => false
      t.string :position, :null => false
      t.string :title_online
      t.string :title_offline
      t.boolean :collect_stats, :default => false
      t.boolean :show_online, :default => true
      t.boolean :show_offline, :default => false
      t.boolean :auto_open, :default => false
      t.boolean :disabled, :default => true

      t.timestamps
    end
  end

  def down
     drop_table :sites
  end
end
