require_relative "../lib/study_buddy/version"
require_relative "../lib/study_buddy/initializer"
require_relative "../lib/study_buddy/test_maker"

class StudyBuddy
  def initialize(command, data_file, options={})
    @options = options
    @options[:data_file] = data_file
    @command = command
    @test_dir = File.join(Dir.pwd, ".study_buddy", "test")
  end
  
  def process
    case @command
    when "init"
      StudyBuddy::Initializer.new(@options).init
    when "make"
      StudyBuddy::TestMaker.new(@options)
    when "take"
      Kernel.exec("vim -o #{@test_dir}/ANSWER #{@test_dir}/TEST")
    when "check"
      Kernel.exec("colordiff #{@test_dir}/TEST #{@test_dir}/KEY")
    else
      raise "Please specify a command."
    end
  end
end
