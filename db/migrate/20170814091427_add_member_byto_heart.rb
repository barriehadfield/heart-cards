class AddMemberBytoHeart < ActiveRecord::Migration[5.1]
  def change
    add_column :hearts, :created_by_id, :integer
    add_column :hearts, :updated_by_id, :integer
  end
end
