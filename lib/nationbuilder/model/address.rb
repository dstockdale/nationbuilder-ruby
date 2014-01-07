module Nationbuilder::Model

  class Address < Base

    attribute :address1, String,
      sample: "123 Fake St."

    attribute :address2, String,
      sample: "Unit 456"

    attribute :city, String,
      sample: "Los Angeles"

    attribute :state, String,
      sample: "CA"

    attribute :country_code, String,
      sample: "US",
      description: "ISO Country code"

    attribute :zip, String,
      sample: "90021"

    attribute :lat, Decimal,
      sample: 34.05

    attribute :lng, Decimal,
      sample: -118.25

  end

end
