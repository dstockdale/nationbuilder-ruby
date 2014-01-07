module Nationbuilder

  class Client

    def initialize(consumer_key, consumer_secret, access_token, nation_url)
      @oauth_client = OauthClient.new(consumer_key, consumer_secret, access_token, nation_url)
    end

    def people
      @people_endpoint ||= Nationbuilder::PeopleController.new(oauth_client)
    end

    def sites
      @sites_endpoint ||= Nationbuilder::SitesController.new(oauth_client)
    end

    def user_agent
      @user_agent ||= "Nationbuilder Ruby Gem #{Nationbuilder::VERSION}"
    end

    private

    def oauth_client
      @oauth_client
    end

  end

end
