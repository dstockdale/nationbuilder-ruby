module Nationbuilder::Model

  class Base

    extend ActiveModel::Naming
    include ActiveModel::Conversion
    include ActiveModel::Validations
    include Virtus.model
    attr_reader   :errors

    def initialize(*args)
      @errors = ActiveModel::Errors.new(self)
      super
    end

    def to_hash
      self.attributes
    end

    def to_model
      self
    end

    def to_param
      id
    end

    def self.human_attribute_name(col, opts={})
      col.to_s
    end

    def persisted?
      id.present?
    end

  end

end
