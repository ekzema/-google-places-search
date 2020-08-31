class Business < ActiveRecord::Base
  belongs_to :user

  validates_uniqueness_of :place_id, allow_blank: true

  scope :business_search, ->(q) { order(:address).where("address ILIKE ?", "%#{q}%").limit(20) }

  class << self
    def create_business(place, user_id)
      create(
          business_name: place.name,
          address: place.formatted_address,
          city: place.city,
          state: place.region,
          zip: place.postal_code,
          place_id: place.place_id,
          user_id: user_id,
      )
    end

    def place(place_id)
      where(place_id: place_id).first
    end

    def claim_business(id, user_id)
      update(id, {user_id: user_id})
    end

    def place_json(desc, logo, id, place_id, disabled)
      {
          label: desc,
          logo: logo,
          id: id,
          place_id: place_id,
          disabled: disabled
      }
    end
  end

  def main_address
    [address, city, state, zip].compact.join(', ')
  end
end
