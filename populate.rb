require 'bundler/setup'
Bundler.require

ENV['MONGOID_ENV'] = 'development'

Mongoid.load!("config/mongoid.yml")

require_relative 'initializers/faker_position'
require_relative 'user'
require_relative 'project'

10.times do
  phone = Phone.new work: Faker::PhoneNumber.phone_number,
                    home: Faker::PhoneNumber.phone_number,
                    mobile: Faker::PhoneNumber.phone_number

  User.create full_name: Faker::Name.name,
              birthday: Faker::Date.birthday,
              email: Faker::Internet.email,
              phone: phone,
              position: Faker::Name.position,
              status: [true, false].sample,
              # photo: Moped::BSON::Binary.new,
              domain_login: Faker::Internet.domain_name,
              wish_users: []
end


