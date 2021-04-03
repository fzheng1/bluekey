class CreateListings < ActiveRecord::Migration[6.1]
  def up
    create_table :listings do |t|
      t.references :landlord, references: :users, foreign_key: { to_table: :users }, null: false, index: true
      t.string :name
      t.float :price
      t.string :description
      t.string :street_address
      t.string :city
      t.string :postal_code
      t.float :lat
      t.float :lon
      t.datetime :start_time
      t.datetime :end_time
      t.string :contact_email
      t.string :contact_phone
      t.integer :size
      t.integer :num_bed
      t.integer :num_bath
      t.integer :bike_time
      t.integer :walk_time
      t.integer :drive_time
      t.float :distance_to_campus
      t.string :housing_type
      t.boolean :featured, default: false
      t.boolean :available, default: true
      t.boolean :ac, default: false
      t.boolean :furnished, default: false
      t.boolean :gym, default: false
      t.boolean :laundry, default: false
      t.boolean :non_smoking, default: false
      t.boolean :parking, default: false
      t.boolean :pet_friendly, default: false
      t.boolean :study_room, default: false
      t.boolean :wifi, default: false
      t.string :image_path
      t.timestamps
    end
  end

  def down
    drop_table :listings
  end
end
