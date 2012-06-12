class StudyBuddy
  class TestChecker
    attr_accessor :right_answers

    def initialize
      @right_answers = []
    end

    def process_diff(diff)
      diff.each_line($/) do |line|
        if line.match(/^>/)
          @right_answers << line.delete('>').strip.chomp('\n')
        end
      end
    end

    def write_wrong(weak_file=".study_buddy/test/WEAK")
      File.open(weak_file, "a+") do |file|
        @right_answers.each do |answer| 
          file << answer + "\n"
        end
      end
    end
  end
end
