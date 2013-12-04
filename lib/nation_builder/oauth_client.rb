require 'oauth2'
require 'json'

# handles low-level communication with REST endpoints (think: "GET", "POST", etc)
# is opinionated to match NB REST assumptions: JSON, certain kinds of error handling, etc.
module NationBuilder
  class OauthClient
    class ValidationError < Exception
      attr_accessor :errors
      def initialize(errors)
        super("Validation error")
        @errors = errors
      end
    end

    class UnknownError < Exception
      attr_accessor :errors
      def initialize(errors)
        if errors.is_a?(Hash)
          super(error['message'])
          @errors = error
        else
          super(error)
        end
      end
    end

    def initialize(consumer_key, consumer_secret, access_token, nation_url)
      client = OAuth2::Client.new(consumer_key, consumer_secret, :site => nation_url)
      @token = OAuth2::AccessToken.new(client, access_token)
    end

    def get(endpoint, opts={})
      with_rescue do
        response = token.get("/api/v1/#{endpoint}", :headers => { "Accept" => "application/json", "Content-Type" => "application/json" }, :params => opts)
        JSON.parse(response.body)
      end
    end

    def put(endpoint, opts={})
      with_rescue do
        response = token.put("/api/v1/#{endpoint}", :headers => { "Accept" => "application/json", "Content-Type" => "application/json" }, :body => opts.to_json)
        JSON.parse(response.body)
      end
    end

    def post(endpoint, opts={})
      with_rescue do
        response = token.post("/api/v1/#{endpoint}", :headers => { "Accept" => "application/json", "Content-Type" => "application/json" }, :body => opts.to_json)
        JSON.parse(response.body)
     end
    end


    private
    def with_rescue
      begin
        yield
      rescue OAuth2::Error => e
        if e.response.parsed
          case e.response.parsed['code']
          when "validation_failed"
            raise ValidationError.new(e.response.parsed['validation_errors'])
          else
            raise UnknownError.new(e.response.parsed)
          end
        else
          #binding.pry
          puts "Caught #{e.message}: #{e.response.inspect}"
          #raise e
          return {}
        end
      end
    end
    def token; @token; end
  end
end