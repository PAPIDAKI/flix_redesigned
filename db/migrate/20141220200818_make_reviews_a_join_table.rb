class MakeReviewsAJoinTable < ActiveRecord::Migration
  def up
    remove_column :reviews,:name
    add_column :reviews,:user_id,:integer

  end
end
