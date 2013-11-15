require_relative '../spec_helper.rb'

describe NationBuilder::Client do
  it "requires consumer_key, consumer_secret, access_token and nation_url" do
    consumer_key = "1234"
    consumer_secret = "5678"
    access_token = "0000"
    nation_url = "http://abeforprez.nbuild.dev/"

    expect { NationBuilder::Client.new(consumer_key, consumer_secret, access_token, nation_url) }.to_not raise_error
  end

  describe "#people" do
    let(:client) { NationBuilder::Client.new("1234", "5678", "0000", "http://abeforprez.nbuild.dev/")}

    it "retrieves a list of people" do
      people_list = {
        "results" => [
          {"id" => 5, "first_name" => "Jim", "last_name" => "Gilliam", "email" => "jim@gilliam.com"}
        ]
      }

      # XXX TODO: better testing? this should not stub an internal method... I think.
      # though perhaps we can do integration testing of this specific method elsewhere...
      client.stub(:get).with('people', {}).and_return(people_list)

      client.people.first.first_name.should == "Jim"
    end

    it "paginates"

    it "handles authentication errors" do
      pending
      rejection = {
                    "code" => "unauthorized",
                    "message" => "You are not authorized to access this content. Your access token may be missing. The resource owner also may not have a permission level sufficient to grant access."
                  }
      token.should_receive(:get).with("/api/v1/people") do |thing|
        #thing...
      end
      client.stub(:token => token)
    end
  end
end