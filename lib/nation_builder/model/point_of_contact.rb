module NationBuilder::Model
  class PointOfContact < Base
    attribute :name, String,
      sample: "John Doe",
      description: "The contact's name"

    attribute :phone, String,
      sample: "6265551234",
      description: "The contact's phone number"

    attribute :show_phone, Boolean,
      default: true,
      sample: false,
      description: "Whether to publish the contact phone number"

    attribute :email, String,
      sample: "person@example.com",
      description: "The contact's email address"

    attribute :show_email, Boolean,
      default: true,
      sample: false,
      description: "whether to publish the contact email address"

    validates_presence_of :name, :email
  end
end