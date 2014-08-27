class Duration
  include Mongoid::Document

  field :description, type: String
  field :date, type: Date
  field :time, type: Time

  has_one :user
  has_one :project
  has_one :task
end
