class AddPostToSpots < ActiveRecord::Migration[5.2]
  def change
    add_reference :spots, :post, foreign_key: true
  end
end
