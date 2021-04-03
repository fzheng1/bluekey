class Listing < ApplicationRecord
    include CommonScopes

    validates :landlord_id, presence: true

    belongs_to :landlord, class_name: 'User', inverse_of: :listings, foreign_key: 'user_id'

    standard_scopes :landlord_id, :city, :ac, :furnished, :gym, :laundry, :non_smoking, :parking
    standard_scopes :pet_friendly, :study_room, :wifi, :housing_type
    range_scopes :price, :num_bed, :num_bath, :bike_time, :walk_time, :drive_time, :distance_to_campus, :size
    time_scopes :start_time, prefix: :end
    time_scopes :end_time, prefix: :start

    scope :available, lambda { where(available: true) }
end
