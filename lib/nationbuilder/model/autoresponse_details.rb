module Nationbuilder::Model

  class AutoresponseDetails < Base

    attribute :broadcaster_id, Integer,
      sample: 12345,
      description: "The id of the broadcaster from which the response should be sent"

    attribute :subject, String,
      sample: "Lets change the world!",
      description: "The subject of the response email"

    attribute :body, String,
      description: "The body of the response email"

  end

end
