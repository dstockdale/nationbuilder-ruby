require 'nation_builder/model/base'

module NationBuilder::Model
  class Site < Base
    attribute :id, Integer
    attribute :slug, String
  end
end