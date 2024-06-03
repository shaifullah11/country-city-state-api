class CreateCountries < ActiveRecord::Migration[7.1]
  def change
    create_table :countries , id: false do |t|
      t.integer :country_id , primary_key: true
      t.string :country_name
      t.string :iso3
      t.string :iso2
      t.string :numeric_code
      t.string :phone_code
      t.string :capital
      t.string :currency
      t.string :currency_name
      t.string :currency_symbol
      t.string :tld
      t.string :native
      t.string :region
      t.string :region_id
      t.string :subregion
      t.string :subregion_id
      t.string :nationality
      t.string :timezones
      t.string :latitude
      t.string :longitude
      t.string :emoji
      t.string :emojiU
      t.timestamps
    end
  end
end
