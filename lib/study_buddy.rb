require_relative "../lib/study_buddy/version"
require_relative "../lib/study_buddy/initializer"
require_relative "../lib/study_buddy/test_maker"
require_relative "../lib/study_buddy/test_checker"

class StudyBuddy
  def initialize(command, data_file, options={})
    @options = options
    @options[:data_file] = @options[:weak] ? '.study_buddy/test/WEAK' : data_file
    @command = command
  end
  
  def process(test_dir = File.join(Dir.pwd, ".study_buddy", "test"))
    case @command
    when "init"
      StudyBuddy::Initializer.new(@options).init
    when "make"
      StudyBuddy::TestMaker.new(@options)
    when "take"
      Kernel.exec("vim -o #{test_dir}/ANSWER #{test_dir}/TEST")
    when "check"
      diff = `diff #{test_dir}/TEST #{test_dir}/KEY`
      test_checker = StudyBuddy::TestChecker.new
      test_checker.process_diff(diff)
      test_checker.write_wrong

      Kernel.exec("colordiff #{test_dir}/TEST #{test_dir}/KEY")
    when "reset_weak"
      File.open('.study_buddy/test/WEAK', 'w')
    else
      puts %Q(
************************
Please specify a command.
************************
)
    end
  end
end
