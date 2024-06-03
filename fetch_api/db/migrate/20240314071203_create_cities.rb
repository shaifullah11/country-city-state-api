class CreateCities < ActiveRecord::Migration[7.1]
  def change
    create_table :cities ,id: false  do |t|
      t.integer :city_id , primary_key: true
      t.string :city_name
      t.string :latitude
      t.string :longitude
      t.integer :state_id
      t.integer :country_id

      t.timestamps
    end
  end
end