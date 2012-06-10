require_relative "../lib/study_buddy/version"
require_relative "../lib/study_buddy/initializer"
require_relative "../lib/study_buddy/test_maker"

class StudyBuddy
  def initialize(command, data_file, options={})
    @options = options
    @options[:data_file] = data_file
    @command = command
    unless @command == "make"
      test_dir = File.join(Dir.pwd, ".study_buddy", "test")
      file_name = Dir.glob("#{test_dir}/**")[0].match(/(\w*)_ANSWER/)[0].gsub("_ANSWER", "")
      @full_path = File.join(test_dir, file_name)
    end
  end
  
  def process
    case @command
    when "init"
      StudyBuddy::Initializer.new(@options).init
    when "make"
      StudyBuddy::TestMaker.new(@options)
    when "take"
      Kernel.exec("vim -o #{@full_path}_ANSWER #{@full_path}_TEST")
    when "check"
      Kernel.exec("colordiff #{@full_path}_TEST #{@full_path}_KEY")
    else
      raise "Please specify a command."
    end
  end
end
