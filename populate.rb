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

def batch_insert(model, n, fast_save = false)
  logger.info("Insert #{n * BATCH_SIZE} #{model.to_s.pluralize}") do
    n.times do
      collection = []

      logger.info("Collect #{n} batch")
      BATCH_SIZE.times do
        if fast_save
          model_attributes = yield
          model.create(model_attributes)
        else
          collection << yield
        end
      end

      logger.info("Save #{n} batch")
      model.create(collection) unless fast_save
    end
  end
end

batch_insert(User, 100, true) do
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
    wish_users: User.all.sample(rand(10))
  }
end

batch_insert(Project, 10) do
  start_date = Faker::Date.backward
  end_date = start_date + rand(365)

  {
    name: Faker::Company.name,
    start_date: start_date,
    end_date: end_date,
    status: ['opened', 'closed', 'deferred'].sample,
    budget: Faker::Number.between(500, 10000),
    manager: User.all.sample,
    participants: User.all.sample(rand(10) + 1)
  }
end

batch_insert(Task, 200) do
  start_date = Faker::Date.backward
  end_date = start_date + rand(365)

  {
    name: Faker::Hacker.say_something_smart,
    start_date: start_date,
    end_date: end_date,
    status: ['opened', 'in_progress', 'done', 'reopened', 'closed'].sample,
    description: Faker::Lorem.sentence,
    project: Project.all.sample,
    responsible: User.all.sample
  }
end

batch_insert(Duration, 1000) do
  date = Faker::Date.backward
  time = date.to_time + rand(60 * 60 * 60)

  {
    description: Faker::Lorem.paragraph,
    date: date,
    time: time,
    user: User.all.sample,
    project: Project.all.sample,
    task: Task.all.sample
  }
end

logger.close
