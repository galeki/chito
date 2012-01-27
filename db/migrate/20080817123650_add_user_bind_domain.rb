class AddUserBindDomain < ActiveRecord::Migration
  def up
    add_column :users, :bind_domain, :string  
  end

  def down
    remove_column :users, :bind_domain    
  end
end
