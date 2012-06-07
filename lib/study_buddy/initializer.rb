class StudyBuddy
  class Initializer
    def initialize(options)
      @dir = options[:test_destination] || ".study_buddy"
    end

    def init
      study_buddy_path = File.join(Dir.pwd, @dir)
      if File.exists?(study_buddy_path)
        raise "It appears you already have StudyBuddy data in this directory."
      else
        Dir.mkdir(study_buddy_path)
      end
    end
  end
end
