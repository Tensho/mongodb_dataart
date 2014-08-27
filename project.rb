class Project
  include Mongoid::Document

  field :name, type: String
  field :start_date, type: Date
  field :end_date, type: Date
  field :status, type: String
  field :budget, type: Integer

  has_one :manager, class_name: 'User'
  has_many :participants, class_name: 'User'
end
