require 'nation_builder/model/address'
module NationBuilder::Model
  class Venue < Base
    attribute :name, String,
      sample: "Venue",
      description: "Name for the venue"

    attribute :address, Address,
      description: "The address at which the event will take place"
  end
end