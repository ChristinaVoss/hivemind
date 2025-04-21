class CreateFlowerPatch < ActiveRecord::Migration[8.0]
  def change
    create_table :flower_patches do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.st_polygon :area, geographic: true

      t.timestamps
    end
  end
end
