require 'nation_builder/model/base'
require 'nation_builder/model/page_base'
require 'nation_builder/model/point_of_contact'
require 'nation_builder/model/rsvp_form_settings'
require 'nation_builder/model/venue'
require 'nation_builder/model/event_shift'
require 'nation_builder/model/autoresponse_details'

module NationBuilder::Model
  class Event < PageBase
    attribute :intro, String,
      accessibility: :optional,
      sample: "Lets change the world!",
      description: "introductory information about the event"

    attribute :calendar_id, Integer,
      accessibility: :optional,
      sample: 12345,
      description: "ID of the calendar on which this event should appear"

    attribute :contact, PointOfContact,
      accessibility: :optional,
      description: "Information about the point of contact for the event"

    attribute :start_time, DateTime,
      accessibility: :required,
      sample: "2013-09-23T06:00:00-07:00",
      description: "When the event starts"

    attribute :end_time, DateTime,
      accessibility: :required,
      sample: "2013-09-23T07:00:00-07:00",
      description: "When the event ends"

    attribute :rsvp_form, RSVPFormSettings,
      accessibility: :optional,
      description: "details about the form users will fill out to (leave out and the event will not accept RSVPs)"

    attribute :capacity, Integer,
      accessibility: :optional,
      sample: 30,
      description: "The event's capacity for attendees"

    attribute :show_guests, Boolean,
      accessibility: :optional,
      sample: true,
      description: "whether to show the guest list publically"

    attribute :venue, Venue,
      accessibility: :optional,
      description: "The details about the location of the event"

    attribute :autoresponse, AutoresponseDetails,
      accessibility: :optional,
      description: "The details of the email to send to a person after they RSVP (leave out to not send RSVP confirmation email)"

    attribute :shifts, Array[EventShift],
      accessibility: :optional,
      description: "shifts to display on the RSVP form"

  end
end