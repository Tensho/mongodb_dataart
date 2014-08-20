class User
  include Mongoid::Document

  field :full_name, type: String
  field :birthday, type: Date
  field :email, type: String
  field :phone, type: Phone
  filed :position, type: String
  filed :status, type: Boolean
  # field :photo, type: Moped::BSON::Binary
  field :domain_login, type: String
  field :wish_users, type: Array
end

class Phone
  attr_accessor :work, :home, :mobile

  def initializer(work, home, mobile)
    @work, @home, @mobile = work, home, mobile
  end

  def mongoize
    { work: work, home: home, mobile: mobile }
  end

  class << self
    def demongoize(object)
      Phone.new(object[0], object[1], object[2])
    end

    def mongoize(object)
      case object
      when Phone then object.mongoize
      when Hash then Phone.new(object[:work], object[:home], object[:mobile]).mongoize
      else object
      end
    end

    def evolve(object)
      case object
      when Phone then object.mongoize
      else object
      end
    end
  end
end
