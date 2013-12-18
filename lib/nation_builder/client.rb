require "nation_builder/version"
require 'nation_builder/oauth_client'
require 'nation_builder/people_controller'
require 'nation_builder/events_controller'
require 'nation_builder/sites_controller'

module NationBuilder
  class Client

    def initialize(consumer_key, consumer_secret, access_token, nation_url)
      @oauth_client = OauthClient.new(consumer_key, consumer_secret, access_token, nation_url)
    end

    def people
      @people_endpoint ||= NationBuilder::PeopleController.new(oauth_client)
    end

    def sites
      @sites_endpoint ||= NationBuilder::SitesController.new(oauth_client)
    end

    def user_agent
      @user_agent ||= "NationBuilder Ruby Gem #{NationBuilder::VERSION}"
    end

    private
    def oauth_client; @oauth_client; end
  end
end
