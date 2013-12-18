require 'nation_builder/controller'
require 'nation_builder/model/site'

module NationBuilder
  class SitesController < Controller
    def initialize(oauth_client)
      super(oauth_client, "sites", NationBuilder::Model::Site)
    end

    def singular
      "site"
    end

    def plural
      "sites"
    end

    class SitesRouter
      def initialize(oauth_client, site_slug)
        @site_slug = site_slug
        @oauth_client = oauth_client
      end

      def events
        @events_endpoint ||= NationBuilder::EventsController.new(@oauth_client, @site_slug)
      end
    end

    def [](site_slug)
      SitesRouter.new(oauth_client, site_slug)
    end
  end
end