class AddMemberRefToLike < ActiveRecord::Migration[7.0]
  def change
    add_reference :likes, :member, null: false, foreign_key: true
  end
end
