class CreateStates < ActiveRecord::Migration[7.1]
  def change
    create_table :states , id: false do |t|
      t.integer :state_id , primary_key: true
      t.string :state_name
      t.string :state_code
      t.string :latitude
      t.string :longitude
      t.integer :country_id


      t.timestamps
    end
  end
end