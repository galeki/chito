class AddFeedbackReplyTo < ActiveRecord::Migration
  def self.up
    add_column :feedbacks, :reply_to, :integer
  end

  def self.down
    remove_column :feedbacks, :reply_to
  end
end
