class Project
  include Mongoid::Document

  field :name, type: String
  field :start_date, type: Date
  field :end_date, type: Date
  field :status, type: String
  field :budget, type: Integer

  belongs_to :manager, class_name: 'User', inverse_of: :managed_projects
  has_and_belongs_to_many :participants, class_name: 'User', inverse_of: :participating_projects

  # has_many :tasks
  # has_many :durations
end
