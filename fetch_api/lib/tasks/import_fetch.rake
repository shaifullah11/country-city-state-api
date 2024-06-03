require 'net/http'
require 'json'

namespace :import do
  desc 'Import countries from JSON API'
  task countries: :environment do
    country_file = Net::HTTP.get(URI('https://raw.githubusercontent.com/dr5hn/countries-states-cities-database/master/countries.json'))
    countries_data = JSON.parse(country_file)

    countries_data.each do |country_data|
      country_timezone = country_data['timezones']
      if !country_timezone.nil?
        country_timezone = country_timezone[0]
        country_timezone = country_timezone['zoneName']
      else
        country_timezone = nil
      end
      country_params = {
        country_id: country_data['id'],
        country_name: country_data['name'],
        iso3: country_data['iso3'],
        iso2: country_data['iso2'],
        numeric_code: country_data['numeric_code'],
        phone_code: country_data['phone_code'],
        capital: country_data['capital'],
        currency: country_data['currency'],
        currency_name: country_data['currency_name'],
        currency_symbol: country_data['currency_symbol'],
        tld: country_data['tld'],
        native: country_data['native'],
        region: country_data['region'],
        region_id: country_data['region_id'],
        subregion: country_data['subregion'],
        subregion_id: country_data['subregion_id'],
        nationality: country_data['nationality'],
        timezones: country_timezone,
        latitude: country_data['latitude'],
        longitude: country_data['longitude'],
        emoji: country_data['emoji'],
        emojiU: country_data['emojiU']
      }
      country = Country.new(country_params)
      if country.save
        puts "Country #{country.country_name} imported successfully!"
      else
        puts "Failed to import country #{country.name}:"
        puts country.errors.full_messages
      end
    end
  end

  desc 'Import states and cities from JSON API'
  task states_cities: :environment do
    state_file = Net::HTTP.get(URI('https://raw.githubusercontent.com/dr5hn/countries-states-cities-database/master/states%2Bcities.json'))
    states_data = JSON.parse(state_file)

    states_data.each do |state_data|
      state_params = {
        state_id: state_data['id'],
        state_name: state_data['name'],
        state_code: state_data['state_code'],
        latitude: state_data['latitude'],
        longitude: state_data['longitude'],
        country_id: state_data['country_id']
      }
      state = State.new(state_params)
      if state.save
        puts "State #{state.state_name} imported successfully!"

        cities_data = state_data['cities']
        cities_data.each do |city_data|
          city_params = {
            city_id: city_data['id'],
            city_name: city_data['name'],
            latitude: city_data['latitude'],
            longitude: city_data['longitude'],
            state_id: state_params[:state_id],
            country_id: state_data['country_id'] # Use string key to access country_id
          }

          city = City.new(city_params)
          if city.save
            puts "City #{city.city_name} imported successfully!"
          else
            puts "Failed to import city #{city.city_name}:"
            puts city.errors.full_messages
          end
        end
      else
        puts "Failed to import state #{state.state_name}:"
        puts state.errors.full_messages
      end
    end
  end
end
