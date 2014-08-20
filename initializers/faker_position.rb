module Faker
  class Name
    class << self
      def position
        fetch('name.title.job')
      end
    end
  end
end
