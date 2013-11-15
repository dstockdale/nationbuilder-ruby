require 'active_model'
require 'virtus'

module NationBuilder::Model
  class Base
    extend ActiveModel::Naming
    include ActiveModel::Conversion
    include Virtus

    def self.from_hash(hash)
      # one-to-one mapping from hash
      new.tap do |object|
        self.attribute_set.each do |attribute|
          object[attribute.name] = hash.fetch(attribute.name.to_s)
        end
      end
    end

    def to_hash
      self.attributes.stringify_keys
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