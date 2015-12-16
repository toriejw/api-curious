class AddMoreColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :followers_count, :integer
    add_column :users, :following_count, :integer
    add_column :users, :tweets_count, :integer
    add_column :users, :profile_image_url, :string
  end
end
