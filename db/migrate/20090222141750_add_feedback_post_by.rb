class AddFeedbackPostBy < ActiveRecord::Migration
  def self.up
    add_column :feedbacks, :post_by, :integer 
  end

  def self.down
    remove_column :feedbacks, :post_by   
  end
end
