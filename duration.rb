class Duration
  include Mongoid::Document

  field :description, type: String
  field :date, type: Date
  field :time, type: Time

  embeds_one :user
  embeds_one :project
  embeds_one :task
end
