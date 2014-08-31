class AddSalesIntervalDayToSite < ActiveRecord::Migration
  def up
    add_column :sites, :sales_interval_day, :integer, default: 1, null: false
  end

  def down
    remove_column :sites, :sales_interval_day
  end
end
