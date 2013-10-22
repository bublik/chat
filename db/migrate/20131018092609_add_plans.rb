class AddPlans < ActiveRecord::Migration
  def up
    [
        {name: 'Simple', price: 0, operators: 1},
        {name: 'Good', price: 15, operators: 2},
        {name: 'Better', price: 28, operators: 5}
    ].each do |price_options|
      Plan.create!(price_options)
    end

    remove_column :agents, :plan
    add_column :agents, :plan_id, :integer, :default => Plan.simple.id
  end

  def down
    remove_column :agents, :plan_id
    add_column :agents, :plan, :string
  end
end
