class Task
  include Mongoid::Document

  field :name, type: String
  field :start_date, type: Date
  field :end_date, type: Date
  field :status, type: String
  field :description, type: String

  has_one :project
  has_one :responsible, class_name: 'User'
end
