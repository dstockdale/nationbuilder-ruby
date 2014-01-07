module Nationbuilder

  class PeopleController < Controller

    def initialize(oauth_client)
      super(oauth_client, "people", Nationbuilder::Model::Person)
    end

    def singular
      "person"
    end

    def plural
      "people"
    end

  end

end
