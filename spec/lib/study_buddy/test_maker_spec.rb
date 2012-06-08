require_relative '../../../lib/study_buddy/test_maker'

# StudyBuddy::TestMaker.new(@options).make_test
# Make a new test with the given data file
# This is where all the options are used like number and range
# StudyBuddy::TestMaker.new(data, options).make
# TODO: Handle it when there is not .test dir
# TODO: Handle it when there is no data file or bad data file
# TODO: Have an option here to automatically call the "take" command

describe StudyBuddy::TestMaker do
  let(:dummy_file){dummy_file = File.expand_path("spec/dummy/test.txt")}

  before(:each) do
    Dir.mkdir(File.join(Dir.pwd, ".study_buddy")) unless File.exists?(File.join(Dir.pwd, ".study_buddy"))
  end

  after(:each) do
    FileUtils.rm_rf(File.join(Dir.pwd, ".study_buddy"))
  end

  it "responds correctly when there's no data in the options hash" do
    expect {StudyBuddy::TestMaker.new({})}.to raise_error("Please specify a data file.")
  end

  it "makes the test dir" do
    opts = {:data_file => dummy_file}
    StudyBuddy::TestMaker.new(opts)
    File.exists?(File.join(Dir.pwd, ".study_buddy", "test")).should == true
  end

  it "reads the lines of the file" do
    opts = {:data_file => dummy_file}
    StudyBuddy::TestMaker.new(opts).lines.kind_of?(Array) == true
  end

  it "defaults to 5 questions when no number is indicated in the options" do 
    opts = {:data_file => dummy_file}
    StudyBuddy::TestMaker.new(opts).questions.length.should == 5
    StudyBuddy::TestMaker.new(opts).answers.length.should == 5
  end

  it "reads the number from the options hash" do
    opts = {:number => 1, :data_file => dummy_file}
    StudyBuddy::TestMaker.new(opts).questions.length.should == 1
  end

  it "reads the range from the options hash" do
    opts = {:range => "2-4", :data_file => dummy_file}
    StudyBuddy::TestMaker.new(opts).questions.length.should == 3
  end

  # I don't know how to implement this.
  it "calls 'start' if the option is specified" 

  context "writing the test files" do
    before(:each) do
      opts = {:data_file => dummy_file}
      StudyBuddy::TestMaker.new(opts)
    end

    it "makes the test" do
      File.exists?(File.join(Dir.pwd, ".study_buddy", "test", "test_TEST")).should == true
    end

    it "makes the answer choices" do
      File.exists?(File.join(Dir.pwd, ".study_buddy", "test", "test_ANSWER")).should == true
    end

    it "makes the answer key" do
      File.exists?(File.join(Dir.pwd, ".study_buddy", "test", "test_KEY")).should == true
    end
  end
end
