module CurrencyCalculator
  def self.calculate_conversion(currency_api, currency_code, amount)
    country_base_amount = currency_api[currency_code]
    raise 'Invalid currency code' if country_base_amount.nil?

    country_base_amount = 1 / country_base_amount
    amount.to_i * country_base_amount
  end
end

class Api::V1::CurrencyController < ApplicationController
  def index
    require_params(:country, :state, :city)
    @country = Country.find_by(country_name: params[:country])
    raise ActiveRecord::RecordNotFound.new('Country not found') if @country.nil?

    @state = @country.states.find_by(state_name: params[:state])
    raise ActiveRecord::RecordNotFound.new('State not found') if @state.nil?

    @city = @state.cities.find_by(city_name: params[:city])
    raise ActiveRecord::RecordNotFound.new('City not found') if @city.nil?

    latitude = @city['latitude'].to_i
    longitude = @city['longitude'].to_i

    tf = TimezoneFinder.create
    timezone = tf.certain_timezone_at(lng: longitude, lat: latitude)

    currency_api = Net::HTTP.get(URI('https://api.exchangerate-api.com/v4/latest/INR'))
    currency_api = JSON.parse(currency_api)
    currency_api = currency_api['rates']

    @current_time = nil
    @current_time = Time.now.in_time_zone(timezone) if timezone.present?

    # Calculate currency conversion if both currency and amount parameters are present
    unless params[:currency].present? && params[:amount].present?
      raise ActionController::ParameterMissing.new('currency and amount parameters are required')
    end

    converted_amount = CurrencyCalculator.calculate_conversion(currency_api, params[:currency], params[:amount])

    @converted = {
      currency: params[:currency],
      amount_converted_to_IND: converted_amount,
      current_time_of_req: @current_time
    }

    render json: @converted, status: :ok
  rescue ActionController::ParameterMissing => e
    render json: { error: e.message }, status: :bad_request
  rescue ActiveRecord::RecordNotFound, StandardError => e
    render json: { error: e.message }, status: :not_found
  end
end
