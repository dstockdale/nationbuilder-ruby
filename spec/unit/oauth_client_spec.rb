require_relative '../spec_helper.rb'

describe NationBuilder::OauthClient do
  let(:oauth_client) { NationBuilder::OauthClient.new("key", "secret", "token", "http://abeforprez.nbuild.dev") }
  let(:token) { double }

  before do
    oauth_client.stub(:token => token)
  end

  describe "#get" do

    let(:response) { double(:body => {field: 'value'}.to_json) }

    it "gets the data using V1 API, and returns parsed JSON response" do
      token.should_receive(:get).
        with("/api/v1/potatoes", :headers => { "Accept" => "application/json", "Content-Type" => "application/json" }, :params => {:spuds => true}).
        and_return(response)

      response = oauth_client.get("potatoes", :spuds => true)

      response["field"].should == "value"
    end
  end

  describe "#put" do
    let(:response) { double(:body => {field: 'value'}.to_json) }

    it "put the data using V1 API, and returns parsed JSON response" do
      token.should_receive(:put).
        with("/api/v1/potatoes", :headers => { "Accept" => "application/json", "Content-Type" => "application/json" }, :body => {:person => {:spuds => true}}.to_json).
        and_return(response)

      response = oauth_client.put("potatoes", :person => {:spuds => true})

      response["field"].should == "value"
    end

    it "raises validation exception if there are errors from the server" do

      response_body = {
        "code"=>"validation_failed",
        "message"=>"Validation Failed.",
        "validation_errors"=>{"email"=>[{"type"=>"taken"}]}
      }

      failure_response = double(:parsed => response_body).as_null_object
      token.should_receive(:put).and_raise(OAuth2::Error.new(failure_response))

      expect {
        oauth_client.put("potatoes", :person => {:email => "existing@email.com"})
      }.to raise_error NationBuilder::OauthClient::ValidationError
    end
  end

  describe "#post" do
    let(:response) { double(:body => {field: 'value'}.to_json) }

    it "posts the data using V1 API, and returns parsed JSON response" do
      token.should_receive(:post).
        with("/api/v1/potatoes", :headers => { "Accept" => "application/json", "Content-Type" => "application/json" }, :body => {:person => {:spuds => true}}.to_json).
        and_return(response)

      response = oauth_client.post("potatoes", :person => {:spuds => true})

      response["field"].should == "value"
    end
  end
end