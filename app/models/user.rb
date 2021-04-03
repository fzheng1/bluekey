class User < ApplicationRecord

    validates :email, presence: true

    has_many :listings, inverse_of: :landlord, dependent: :delete_all, foreign_key: 'landlord_id'
end
