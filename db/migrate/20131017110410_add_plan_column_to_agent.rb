class AddPlanColumnToAgent < ActiveRecord::Migration
  def up
    add_column :agents, :plan, :string, default: 'simple', :null => false
  end

  def down
    remove_column :agents, :plan
  end
end
