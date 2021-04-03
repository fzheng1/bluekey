class Api::V1::ListingsController < ApplicationController
  LISTING_PARAMS = [:landlord_id, :name, :price, :description, :street_address, :city, :postal_code,
    :lat, :lon, :start_time, :end_time, :contact_email, :contact_phone, :size, :num_bed, :num_bath,
    :bike_time, :walk_time, :drive_time, :distance_to_campus, :housing_type, :featured, :available,:ac,
    :furnished, :gym, :laundry, :non_smoking, :parking, :pet_friendly, :study_room, :wifi, :image_path]

  def index
    listings = Listing.available
                      .with_landlord_id(params[:landlord_id])
                      .with_city(params[:city])
                      .with_ac(params[:ac])
                      .with_furnished(params[:furnished])
                      .with_gym(params[:gym])
                      .with_laundry(params[:laundry])
                      .with_non_smoking(params[:non_smoking])
                      .with_parking(params[:parking])
                      .with_pet_friendly(params[:pet_friendly])
                      .with_study_room(params[:study_room])
                      .with_wifi(params[:wifi])
                      .with_housing_type(params[:housing_type])
                      .with_price({ min: params[:min_price], max: params[:max_price] })
                      .with_size({ min: params[:size] })
                      .with_num_bed({ min: params[:num_bed] })
                      .with_num_bath({ min: params[:num_bath] })
                      .with_walk_time({ max: params[:walk_time] })
                      .with_drive_time({ max: params[:drive_time] })
                      .with_bike_time({ max: params[:bike_time] })
                      .with_distance_to_campus({ max: params[:distance_to_campus] })
                      .with_start_time(params[:city])
                      .start_on_or_after(params[:start_time])
                      .end_on_or_before(params[:end_time])
                      .order_by_start_recent
    render json: listings, status: 200
  end

  def show
    listing = Listing.find_by_id(params[:id])
    if listing
      render json: listing, status: 200
    else
      render json: { error: "listing not found" }, status: 404
    end
  end

  def create
    listing = Listing.build(params.slice(*LISTING_PARAMS))
    if listing.save
      render json: listing, status: 201
    else
      render json: { error: "listing could not be created" }. status: 400
    end
  end

  def update
    listing = Listing.find_by_id(params[:id])
    render json: { error: "listing not found" }, status: 404 unless listing
    if listing.update_attributes(params.slice(*LISTING_PARAMS))
      render json: listing, status: 200
    else
      render json: { error: "listing could not be updated" }, status: 400
    end
  end
end
