class BusinessesController < ApplicationController
  def index
    @businesses = current_user.businesses
  end

  def create
    redirect_to '/', notice: "Empty place_id and id" and return  if (params[:id].empty? && params[:place_id].empty?)

    if params[:id].empty?
      Business.create_business(google_autocomplete.spot(params[:place_id], details: true), session[:user_id])
    else
      Business.claim_business(params[:id], session[:user_id])
    end

    redirect_to '/'
  end

  def autocomplete
    render json: send(params[:type])
  end

  private

  def google_autocomplete
    GooglePlaces::Client.new(ENV['GOOGLE_API_KEY'])
  end

  def all_data
    database_data + google_data
  end

  def type_establishment
    google_autocomplete.predictions_by_input(params[:q], types: 'establishment')
  end

  def google_data
    type_establishment.reduce([]) do |arr, i| p = Business.place(i.place_id); arr <<
        Business.place_json(i.description, 'fa fa-google', p.try(:id), i.place_id, p.try(:user_id))
    end
  end

  def database_data
    Business.business_search(params[:q]).reduce([]) do |arr, i| arr <<
        Business.place_json(i.main_address, 'fa fa-building', i.id, nil, i.user_id)
    end
  end
end
