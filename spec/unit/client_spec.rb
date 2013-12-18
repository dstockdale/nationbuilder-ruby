require_relative '../spec_helper.rb'

describe NationBuilder::Client do
  it "requires consumer_key, consumer_secret, access_token and nation_url" do
    consumer_key = "1234"
    consumer_secret = "5678"
    access_token = "0000"
    nation_url = "http://abeforprez.nbuild.dev/"

    expect { NationBuilder::Client.new(consumer_key, consumer_secret, access_token, nation_url) }.to_not raise_error
  end

  let(:client) { NationBuilder::Client.new("1234", "5678", "0000", "http://abeforprez.nbuild.dev/")}
  describe "#people" do
    it "is a people controller" do
      client.people.should be_a NationBuilder::PeopleController
    end
  end

  describe "#events" do
    it "is nested by site" do
      ec = client.sites['abeforprez'].events
      ec.should be_a NationBuilder::EventsController
      ec.site_slug.should == 'abeforprez'
    end
  end
end