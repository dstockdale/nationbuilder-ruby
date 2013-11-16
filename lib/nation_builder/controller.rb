# base class for getters/setters for a particular class, e.g. person
module NationBuilder
  class Controller
    def initialize(oauth_client, model_class)
      @oauth_client = oauth_client
      @clazz = model_class
    end

    def list(opts={})
      oauth_client.get(plural, opts)["results"].map { |data| @clazz.new(data) }
    end

    def find(id)
      @clazz.new(oauth_client.get("#{plural}/#{id}")[singular])
    end

    private
    def oauth_client; @oauth_client; end
  end
end