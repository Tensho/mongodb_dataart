class User
  include Mongoid::Document

  field :full_name, type: String
  field :birthday, type: Date
  field :email, type: String
  field :phone, type: Hash
  filed :position, type: String
  filed :status, type: Boolean
  field :photo, type: Moped::BSON::Binary
  field :domain_login, type: String
  field :wish_users, type: Array
end
