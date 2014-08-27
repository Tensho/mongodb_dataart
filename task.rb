class Task
  include Mongoid::Document

  field :name, type: String
  field :start_date, type: Date
  field :end_date, type: Date
  field :status, type: String
  field :description, type: String

  belongs_to :project
  belongs_to :responsible, class_name: 'User'

  # has_many :durations
end
