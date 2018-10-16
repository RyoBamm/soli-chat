class AddNicknameToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :nickname, :string
    add_column :users, :age,:integer
    add_column :users, :avatar, :string
  end
end
