class AddDomainToLocation < ActiveRecord::Migration
  def up
    add_column :locations, :request_domain, :string, default: ''
  end

  def down
    remove_column :locations, :request_domain
  end
end
