require 'nation_builder/controller'
require 'nation_builder/model/person'

module NationBuilder
  class PeopleController < Controller
    def initialize(oauth_client)
      super(oauth_client, NationBuilder::Model::Person)
    end

    def singular
      "person"
    end

    def plural
      "people"
    end
  end
end