require_relative '../spec_helper.rb'

describe NationBuilder::PeopleController do
  let(:oauth_client) { MockOauthClient.new }
  let(:people_controller) { NationBuilder::PeopleController.new(oauth_client) }

  describe "#list" do
    it "retrieves a list of people" do
      people_list = {
        "results" => [
          {"id" => 5, "first_name" => "Jim", "last_name" => "Gilliam", "email" => "jim@gilliam.com"}
        ]
      }

      oauth_client.stub(:get).with('people', {}).and_return(people_list)

      result = people_controller.list.first
      result.first_name.should == "Jim"
      result.last_name.should == "Gilliam"
    end

    it "passes parameters through to API endpoint" do
      oauth_client.should_receive(:get).with('people', {page: 2}).and_return({"results" => []})
      people_controller.list(page: 2)
    end
  end

  describe "#find" do
    it "retrieves a single person" do
      oauth_client.should_receive(:get).with('people/5').and_return({"person" => {}})
      people_controller.find(5)
    end
  end

  describe "#save" do
    it "saves a new person and sets their ID" do
      person = NationBuilder::Model::Person.new(:first_name => "Steve", :last_name => "Gutenberg")

      oauth_client.should_receive(:post).
        with('people', {:first_name=>"Steve", :last_name=>"Gutenberg", :email=>nil}).
        and_return({"person" => {:id => 5, :first_name => "Steve", :last_name => "Gutenberg", :email=>nil}})

      people_controller.save(person)

      person.id.should == 5
    end

    it "saves an existing person, updating any attributes which changed (e.g. as a result of server-side callbacks)" do
      person = NationBuilder::Model::Person.new(:id => 10, :first_name => "Steve", :last_name => "Jobs")

      oauth_client.should_receive(:put).
        with('people', {:id => 10, :first_name=>"Steve", :last_name=>"Jobs", :email=>nil}).
        and_return({"person" => {:id => 10, :first_name => "Steve", :last_name => "Jobs", :email=>"steve@apple.com"}})

      people_controller.save(person)

      person.id.should == 10
      person.email.should == "steve@apple.com"
    end
  end

  # it "handles authentication errors" do
  #   pending
  #   rejection = {
  #                 "code" => "unauthorized",
  #                 "message" => "You are not authorized to access this content. Your access token may be missing. The resource owner also may not have a permission level sufficient to grant access."
  #               }
  #   token.should_receive(:get).with("/api/v1/people") do |thing|
  #     #thing...
  #   end
  #   client.stub(:token => token)
  # end
end