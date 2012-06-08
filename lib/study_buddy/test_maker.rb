class StudyBuddy
  class TestMaker
    attr_accessor :data_file, :questions, :answers, :lines

    def initialize(options={})
      @options = options
      @questions = []
      @answers = []
      @number = options[:number].to_i
      @range = options[:range]
      read_data_file
      get_topic_name
      make_test_dir
      get_questions
      write_test_file
      write_answer_file
      write_key_file
      start_if_requested
    end

    def read_data_file
      if @options[:data_file].nil?
        raise "Please specify a data file." 
      else
        @data_file = @options[:data_file]
      end
    end

    def get_topic_name
      @topic = File.basename(@data_file, ".txt")
    end

    def make_test_dir
      dir = File.join(Dir.pwd, ".study_buddy", "test")
      Dir.mkdir(dir) unless File.exists?(dir)
    end

    #TODO: Refactor
    def get_questions
      lines = IO.readlines(@data_file)

      if @range != nil
        start = @range.split("-")[0].to_i
        stop = @range.split("-")[1].to_i
        lines = lines[start-1..stop-1]
        @lines = lines.shuffle # Make the questions random
      elsif @number == 0 
        lines = lines.shuffle # Make the questions random
        @number = lines.length
        @lines = lines[0...@number]
      else
        lines = lines.shuffle # Make the questions random
        @lines = lines[0...@number]
      end

      @lines.each do |line|
        question = line.split("=")[0]
        answer = line.split("=")[1]

        @questions << question
        @answers << answer
      end
    end

    def write_test_file
      file_name = File.join(Dir.pwd, ".study_buddy", "test", @topic + "_TEST")
      File.open(file_name, "w+") do |file|
        @questions.map do |q|
          q = "#{q}= \n"
          file << q
        end
      end
    end

    def write_answer_file
      file_name = File.join(Dir.pwd, ".study_buddy", "test", @topic + "_ANSWER")
      File.open(file_name, "w+") do |file|
        @answers.shuffle.each{|a| file << "#{a.strip}\n"}
      end
    end

    def write_key_file
      file_name = File.join(Dir.pwd, ".study_buddy", "test", @topic + "_KEY")
      File.open(file_name, "w+") do |file|
        n = @questions.length
        (0...n).each do |i|
          file << "#{@questions[i]}=#{@answers[i]}"
        end
      end
    end

    def start_if_requested
      if @options[:start_test] == true
        file = File.join(Dir.pwd, ".study_buddy", "test", @topic)
        Kernel.exec("vim -o #{file}_ANSWER #{file}_TEST")
      end
    end
  end
end
