require_relative "../../lib/study_buddy"

describe StudyBuddy do
  describe "#process" do
    context "('check')" do
      before(:each) do
        @tmp = File.join(Dir.pwd, "tmp")
        Dir.mkdir(@tmp) unless File.exists?(@tmp)

        @test = File.join(@tmp, "TEST")
        @answer = File.join(@tmp, "ANSWER")
        @key = File.join(@tmp, "KEY")
        @weak = File.join(@tmp, "WEAK")
        
        # Creating the files here just
        # silences the diff when it runs
        [@test, @answer, @key, @weak].each do |name|
          File.new(name, "a+")
        end

        @tc_stub = stub
        StudyBuddy::TestChecker.stub(:new) { @tc_stub }

        @data_file = File.join(Dir.pwd, "spec", "fixtures", "test.txt")
      end

      it "prints the diff output to the screen and records missed problems" do
        Kernel.should_receive(:exec).with("colordiff #{@test} #{@key}")
        @tc_stub.should_receive(:process_diff)
        @tc_stub.should_receive(:write_wrong)

        StudyBuddy.new("check", @data_file).process(@tmp)
      end

      after(:each) do
        FileUtils.rm_rf(@tmp)
      end
    end
  end
end
