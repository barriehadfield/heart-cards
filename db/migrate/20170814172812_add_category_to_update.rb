class AddCategoryToUpdate < ActiveRecord::Migration[5.1]
  def change
    add_column :reports, :category, :string
  end
end
