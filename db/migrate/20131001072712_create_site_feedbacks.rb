class CreateSiteFeedbacks < ActiveRecord::Migration
  def change
    create_table :site_feedbacks do |t|
      t.string :username
      t.string :email
      t.string :phone
      t.text :message
      t.string :referer
      t.string :remote_ip
      t.string :user_agent
      t.integer :site_id

      t.timestamps
    end
  end
end
