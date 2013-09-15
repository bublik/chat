class ChangeColumnUuidToString < ActiveRecord::Migration
  def up
    change_column :sites, :uuid, :string
  end

  def down
    change_column :sites, :uuid, :binary
  end
end
