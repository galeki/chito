class AddTwitterInUserAndComment < ActiveRecord::Migration
  def self.up
      add_column :users, :twitter, :string
      add_column :feedbacks, :twitter, :string
  end

  def self.down
     remove_column :users, :twitter
     remove_column :feedbacks, :twitter
  end
end
