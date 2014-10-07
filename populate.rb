require 'logger'

def logger
  @logger ||= Logger.new(STDOUT)
end

require 'bundler/setup'
Bundler.require

ENV['MONGOID_ENV'] = 'development'

Mongoid.load!("config/mongoid.yml")

require_relative 'initializers/faker_position'
require_relative 'models/user'
require_relative 'models/project'
require_relative 'models/task'
require_relative 'models/duration'

logger.info('Clean Mongo') do
  Mongoid.purge!
end

BATCH_SIZE = 1000

def batch_insert(model, n)
  logger.info("#{n * BATCH_SIZE} #{model.to_s.pluralize} inserted") do
    n.times do |i|
      collection = []

      logger.info("#{i} batch collected")
      BATCH_SIZE.times do
        collection << yield
      end

      logger.info("#{i} batch saved")
      model.create(collection)
    end
  end
end

batch_insert(User, 100) do
  phone = Phone.new work: Faker::PhoneNumber.phone_number,
                    home: Faker::PhoneNumber.phone_number,
                    mobile: Faker::PhoneNumber.phone_number

  {
    full_name: Faker::Name.name,
    birthday: Faker::Date.birthday,
    email: Faker::Internet.email,
    phone: phone,
    position: Faker::Name.position,
    status: [true, false].sample,
    photo: BSON::Binary.new(Random.new.bytes(250)),
    domain_login: Faker::Internet.domain_name,
    wish_user_ids: User.pluck(:id).sample(rand(10))
  }
end

user_ids = User.pluck(:id)

batch_insert(Project, 10) do
  start_date = Faker::Date.backward
  end_date = start_date + rand(365)

  {
    name: Faker::Company.name,
    start_date: start_date,
    end_date: end_date,
    status: ['opened', 'closed', 'deferred'].sample,
    budget: Faker::Number.between(500, 10000),
    manager_id: user_ids.sample,
    participant_ids: user_ids.sample(rand(10) + 1)
  }
end

project_ids = Project.pluck(:id)

batch_insert(Task, 200) do
  start_date = Faker::Date.backward
  end_date = start_date + rand(365)

  {
    name: Faker::Hacker.say_something_smart,
    start_date: start_date,
    end_date: end_date,
    status: ['opened', 'in_progress', 'done', 'reopened', 'closed'].sample,
    description: Faker::Lorem.sentence,
    project_id: user_ids.sample,
    responsible_id: project_ids.sample
  }
end

task_ids = Task.pluck(:id)

batch_insert(Duration, 1000) do
  date = Faker::Date.backward
  time = date.to_time + rand(60 * 60 * 60)

  {
    description: Faker::Lorem.paragraph,
    date: date,
    time: time,
    user_id: user_ids.sample,
    project_id: project_ids.sample,
    task_id: task_ids.sample
  }
end

logger.close
