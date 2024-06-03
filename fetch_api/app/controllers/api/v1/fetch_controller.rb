class Api::V1::FetchController < ApplicationController
  def index
    if params[:country].present?
      @countries = Country.find_by(iso3: params[:country])
      if params[:state].present?
        @states = @countries.states.find_by(state_code: params[:state])
        if params[:city].present?
          @city = @states.cities.find_by(city_name: params[:city])
          if @city
            render json: @city, status: :ok
          else
            render json: { error: 'City not found' }, status: :not_found
          end
        else
          @cities = @states.cities
          @cities = @cities.paginate(page: params[:page], per_page: params[:page_count])
          if @cities
            render json: @cities, status: :ok
          else
            render json: { error: 'state not found' }, status: :not_found
          end
        end
      else
        @states = @countries.states
        @states = @states.paginate(page: params[:page], per_page: params[:page_count])
        if @states
          render json: @states, status: :ok
        else
          render json: { error: 'Country not found' }, status: :not_found
        end
      end
    else
      @countries = Country.all
      @countries = @countries.paginate(page: params[:page], per_page: params[:page_count])
      render json: @countries, status: :ok
    end

    nil unless params[:location]
  end

  def time
    render json: { time: Time.zone.now }
  end
end
