require "nation_builder/version"
require 'oauth2'
require 'nation_builder/person'
module NationBuilder
  class Client
    def initialize(consumer_key, consumer_secret, access_token, nation_url)
      @client = OAuth2::Client.new(consumer_key, consumer_secret, :site => nation_url)
      @token = OAuth2::AccessToken.new(@client, access_token)
    end

    def people(opts={})
      get('people', opts)["results"].map { |person_data| Person.from_hash(person_data) }
    end

    private
    def client; @client; end
    def token; @token; end

    def get(endpoint, opts={})
      response = token.get("/api/v1/#{endpoint}", :headers => headers, :params => opts)
      JSON.parse(response.body)
    end

    def headers
      { "Accept" => "application/json", "Content-Type" => "application/json" }
    end
  end
end
