class AddCommentAuditBy < ActiveRecord::Migration
  def self.up
    add_column :comments, :audit_by, :string  
  end

  def self.down
    remove_column :comments, :audit_by
  end
end
