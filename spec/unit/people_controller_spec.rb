require_relative '../spec_helper.rb'

# XXX TODO: most of these tests could be factored into a "controller spec" which applies to all types
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
      person = NationBuilder::Model::Person.new(:first_name => "Steve")

      oauth_client.should_receive(:post).
        with('people', "person" => hash_including(:first_name=>"Steve")).
        and_return({"person" => {:id => 5, :first_name=>"Steve"}})

      people_controller.save(person)

      person.id.should == 5
    end

    it "saves an existing person, updating any attributes which changed (e.g. as a result of server-side callbacks)" do
      person = NationBuilder::Model::Person.new(:id => 10, :first_name => "Steve")

      oauth_client.should_receive(:put).
        with('people/10', "person" => hash_including(:id => 10, :first_name=>"Steve")).
        and_return({"person" => {:id => 10, :first_name => "Steve", :email=>"steve@apple.com"}})

      people_controller.save(person)

      person.id.should == 10
      person.email.should == "steve@apple.com"
    end

    it "returns false on validation errors" do
      person = NationBuilder::Model::Person.new(:id => 10, :first_name => "Steve", :email => 'taken@email.com')
      oauth_client.should_receive(:put).and_raise(NationBuilder::OauthClient::ValidationError.new({"email"=>[{"type"=>"taken"}]}))

      expect {
        people_controller.save(person).should be_false
        person.errors.full_messages.should include "email 'taken@email.com' is taken"
      }.to_not raise_error
    end

    it "clears validation errors on success" do
      person = NationBuilder::Model::Person.new(:id => 10, :first_name => "Steve")
      person.errors.add(:email, "is bogus")

      oauth_client.should_receive(:put).
        and_return({"person" => {:id => 10, :first_name=>"Steve"}})

      people_controller.save(person)

      person.errors.should be_empty
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