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
          oauth_client.put("#{@endpoint_name}/#{object.id}", singular => object.to_hash)
        else
          oauth_client.post(@endpoint_name, singular => object.to_hash.reject{|k,v| k == :id})
        end
      if response && response[singular]
        object.attributes = response[singular]
        object.errors.clear
        return true
      else
        object.errors.add(:global, "Empty response")
        return false
      end
    rescue NationBuilder::OauthClient::ValidationError => e
      # set error properties on model
      e.errors.each do |field, errors|
        errors.each do |error|
          object.errors.add(field, "'#{object[field]}' is #{error["type"]}")
        end
      end
      false
    end

    private
    def oauth_client; @oauth_client; end
  end
end