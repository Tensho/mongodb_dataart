require_relative 'phone'

class User
  include Mongoid::Document

  field :full_name, type: String
  field :birthday, type: Date
  field :email, type: String
  field :phone, type: Phone
  field :position, type: String
  field :status, type: Boolean
  # field :photo, type: Moped::BSON::Binary
  field :domain_login, type: String

  has_and_belongs_to_many :wish_users, class_name: 'User'

  # has_many :managed_projects, class_name: 'Project', inverse_of: :manager
  # has_many :participating_projects, class_name: 'Project', inverse_of: :participants
  # has_many :tasks
  # has_many :durations
end
