require 'nation_builder/controller'
require 'nation_builder/model/event'

module NationBuilder
  class EventsController < Controller
    attr_accessor :site_slug
    def initialize(oauth_client, site_slug)
      super(oauth_client, "sites/#{site_slug}/pages/events", NationBuilder::Model::Event)
      @site_slug = site_slug
    end

    def singular
      "event"
    end

    def plural
      "events"
    end
  end
end