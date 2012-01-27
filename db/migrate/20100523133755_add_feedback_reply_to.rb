class AddFeedbackReplyTo < ActiveRecord::Migration
  def up
    add_column :feedbacks, :reply_to, :integer
  end

  def down
    remove_column :feedbacks, :reply_to
  end
end
