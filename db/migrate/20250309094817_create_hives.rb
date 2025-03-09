class CreateHives < ActiveRecord::Migration[8.0]
  def change
    create_table :hives do |t|
      t.references :user, null: false, foreign_key: true
      t.st_point :location, geographic: true
      t.timestamps
    end
    add_index :hives, :location, using: :gist
  end
end
