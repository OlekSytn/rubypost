class AddDetailsToMember < ActiveRecord::Migration[7.0]
  def change
    add_column :members, :photo, :string
    add_column :members, :post_counter, :integer
  end
end
