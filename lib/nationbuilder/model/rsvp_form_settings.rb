module Nationbuilder::Model

  class RSVPFormSettings < Base

    FORM_FIELD_OPTIONS = %w(required hidden optional)

    attribute :phone, String,
      sample: "required",
      description: "Whether to ask for a phone number.  hidden if not asked, required if it is a required field, and optional if it is an optional field."

    attribute :address, String,
      sample: "optional",
      description: "Whether to ask for an address"

    attribute :allow_guests, Boolean,
      sample: true,
      description: "Whether to allow for RSVPing person to bring more guests"

    attribute :gather_volunteers, Boolean,
      sample: true,
      description: "Whether to ask RSVPing people to volunteer for the event"

    validates_inclusion_of :phone, in: FORM_FIELD_OPTIONS
    validates_inclusion_of :address, in: FORM_FIELD_OPTIONS

  end

end
