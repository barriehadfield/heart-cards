class AddComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :body
      t.integer :created_by_id
      t.integer :report_id
      t.timestamps
    end
  end
end
