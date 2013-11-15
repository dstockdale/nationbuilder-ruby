require 'active_model'
class Person
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_accessor :id, :email, :first_name, :last_name
  def self.from_hash(hash)
    new.tap do |person|
      person.id = hash.fetch("id")
      person.email = hash.fetch("email")
      person.first_name = hash.fetch("first_name")
      person.last_name = hash.fetch("last_name")
    end
  end

  def name
    [first_name, last_name].compact.join(" ")
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
