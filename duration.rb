class Duration
  include Mongoid::Document

  field :description, type: String
  field :date, type: Date
  field :time, type: Time

  belongs_to :user
  belongs_to :project
  belongs_to :task
end
