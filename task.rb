class Task
  include Mongoid::Document

  field :name, type: String
  field :start_date, type: Date
  field :end_date, type: Date
  field :status, type: String
  field :description, type: String

  embeds_one :project
  embeds_one :responsible, class_name: 'User'
end
