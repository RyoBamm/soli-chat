class ChangeColumnToPost2 < ActiveRecord::Migration[5.1]
  def change
    def up
      change_column :posts, :likes_count, :integer, null: false, default: 0
    end

    # 変更前の状態
    def down
      change_column :posts, :likes_count, :integer
    end
  end
end
