class RenameColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column :comments, :member_id, :author_id
    rename_column :likes, :member_id, :author_id
    rename_column :posts, :member_id, :author_id
  end
end
