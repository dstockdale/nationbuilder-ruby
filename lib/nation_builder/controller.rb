# base class for getters/setters for a particular class, e.g. person
module NationBuilder
  class Controller
    def initialize(oauth_client, endpoint_name, model_class)
      @oauth_client = oauth_client
      @endpoint_name = endpoint_name
      @clazz = model_class
    end

    def list(opts={})
      oauth_client.get(@endpoint_name, opts)["results"].map { |data| @clazz.new(data) }
    end

    def find(id)
      @clazz.new(oauth_client.get("#{@endpoint_name}/#{id}")[singular])
    end

    def save(object)
      response = if object.id.present?
          oauth_client.put(@endpoint_name, object.to_hash)
        else
          oauth_client.post(@endpoint_name, object.to_hash.reject{|k,v| k == :id})
        end
      object.attributes = response["person"]
    end

    private
    def oauth_client; @oauth_client; end
  end
end