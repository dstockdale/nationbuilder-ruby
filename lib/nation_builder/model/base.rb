require 'active_model'
require 'virtus'

module NationBuilder::Model
  class Base
    extend ActiveModel::Naming
    include ActiveModel::Conversion
    include Virtus.model

    def to_hash
      self.attributes
    end

    def to_model
      self
    end

    def to_param
      id
    end

    def persisted?
      id.present?
    end

  end
end