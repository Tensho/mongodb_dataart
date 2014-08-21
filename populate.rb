require 'bundler/setup'
Bundler.require

ENV['MONGOID_ENV'] = 'development'

Mongoid.load!("config/mongoid.yml")

require_relative 'initializers/faker_position'
require_relative 'user'
require_relative 'project'

# TODO: clean db before population

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
              wish_users: User.all.sample(rand(10))
end

10.times do
  start_date = Faker::Date.backward
  end_date = start_date + rand(365)

  Project.create name: Faker::Company.name,
                 start_date: start_date,
                 end_date: end_date,
                 status: ['opened', 'closed', 'deferred'].sample,
                 budget: Faker::Number.between(500, 10000),
                 manager: User.all.sample,
                 participants: User.all.sample(rand(10) + 1)
end



