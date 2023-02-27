class AddMemberRefToPost < ActiveRecord::Migration[7.0]
  def change
    add_reference :posts, :member, null: false, foreign_key: true
  end
end
