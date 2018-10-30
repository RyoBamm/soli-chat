class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :title, null: false, default: ""
      t.string :video
      t.string :youtube
      t.string :description
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
