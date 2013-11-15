require 'oauth2'

# handles low-level communication with REST endpoints
# is opinionated to match NB REST assumptions: JSON, certain kinds of error handling, etc.
module NationBuilder
  class OauthClient
    def initialize(consumer_key, consumer_secret, access_token, nation_url)
      client = OAuth2::Client.new(consumer_key, consumer_secret, :site => nation_url)
      @token = OAuth2::AccessToken.new(client, access_token)
    end

    def get(endpoint, opts={})
      response = @token.get("/api/v1/#{endpoint}", :headers => { "Accept" => "application/json", "Content-Type" => "application/json" }, :params => opts)
      JSON.parse(response.body)
    end
  end
end