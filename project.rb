class Project
  include Mongoid::Document

  field :name, type: String
  field :start_date, type: Date
  field :end_date, type: Date
  field :status, type: String
  field :budget, type: Integer

  embeds_one :manager, class_name: 'User'
  embeds_many :participants, class_name: 'User'
end
