module Nationbuilder

  class SitesController < Controller

    def initialize(oauth_client)
      super(oauth_client, "sites", Nationbuilder::Model::Site)
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
        @events_endpoint ||= Nationbuilder::EventsController.new(@oauth_client, @site_slug)
      end
    end

    def [](site_slug)
      SitesRouter.new(oauth_client, site_slug)
    end

  end

end
