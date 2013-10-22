class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :name
      t.integer :price
      t.integer :operators

      t.timestamps
    end
  end
end
