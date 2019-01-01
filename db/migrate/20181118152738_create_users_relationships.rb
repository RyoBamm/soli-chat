class CreateUsersRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :users_relationships do |t|
      t.integer :follower_id
      t.integer :followee_id
      t.timestamps
    end
    add_index :users_relationships, :follower_id
    add_index :users_relationships, :followee_id
    add_index :users_relationships, [:follower_id, :followee_id], unique: true
  end
end
