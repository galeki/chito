class AddCommentAuditBy < ActiveRecord::Migration
  def up
    add_column :comments, :audit_by, :string  
  end

  def down
    remove_column :comments, :audit_by
  end
end
