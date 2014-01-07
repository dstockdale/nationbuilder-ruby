module Nationbuilder::Model

  class EventShift < Base

    attribute :id, Integer

    attribute :start_time, Time,
      sample: "2013-09-23T06:00:00-07:00",
      description: "The starting time of the shift"

    attribute :end_time, Time,
      sample: "2013-09-23T07:00:00-07:00",
      description: "The ending time of the shift"

    attribute :goal, Integer,
      sample: 100,
      description: "The number of volunteers to seek for the shift"

  end

end
