class SetBetterForAll < ActiveRecord::Migration
  def up
    Agent.update_all(plan: 'better')
  end

  def down
    say 'Nothing to do!'
  end

end
