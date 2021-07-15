class AddPostIdToMaps < ActiveRecord::Migration[5.2]
  def change
    add_reference :maps, :post, foreign_key: true
  end
end
