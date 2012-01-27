class AddFeedbackPostBy < ActiveRecord::Migration
  def up
    add_column :feedbacks, :post_by, :integer 
  end

  def down
    remove_column :feedbacks, :post_by   
  end
end
