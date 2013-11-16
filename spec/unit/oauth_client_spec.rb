require_relative '../spec_helper.rb'

describe NationBuilder::OauthClient do
  describe "#get" do
    let(:oauth_client) { NationBuilder::OauthClient.new("key", "secret", "token", "http://abeforprez.nbuild.dev") }
    let(:token) { double }
    let(:response) { double(:body => {field: 'value'}.to_json) }

    before do
      oauth_client.stub(:token => token)
    end

    it "gets the data using V1 API, and returns parsed JSON response" do
      token.should_receive(:get).
        with("/api/v1/potatoes", :headers => { "Accept" => "application/json", "Content-Type" => "application/json" }, :params => {:spuds => true}).
        and_return(response)

      response = oauth_client.get("potatoes", :spuds => true)

      response["field"].should == "value"
    end
  end
end