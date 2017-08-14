class AddUpdateTable < ActiveRecord::Migration[5.1]
  def change
    create_table :updates do |t|
      t.text :body
      t.integer :heart_id
      t.integer :member_id
      t.timestamps
    end
  end
end
