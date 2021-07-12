class ChangeMapsToSpots < ActiveRecord::Migration[5.2]
  def change
    rename_table :maps, :spots
  end
end
