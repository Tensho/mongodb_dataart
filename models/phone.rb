class Phone
  attr_accessor :work, :home, :mobile

  def initialize(phones)
    @work, @home, @mobile = phones[:work], phones[:home], phones[:mobile]
  end

  def mongoize
    { work: work, home: home, mobile: mobile }
  end

  class << self
    def demongoize(object)
      Phone.new(work: object[0], home: object[1], mobile: object[2])
    end

    def mongoize(object)
      case object
      when Phone then object.mongoize
      when Hash then Phone.new(work: object[:work], home: object[:home], mobile: object[:mobile]).mongoize
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
