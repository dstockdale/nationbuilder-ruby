module Nationbuilder::Model

  class Person < Base

    attribute :id, Integer
    attribute :first_name, String
    attribute :last_name, String
    attribute :email, String

    def name
      [first_name, last_name].compact.join(" ")
    end

  end

end
