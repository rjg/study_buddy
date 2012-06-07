require_relative '../../../lib/study_buddy/initializer'

describe StudyBuddy::Initializer do
  before(:each) do
    Dir.rmdir(".study_buddy") if File.exists?(".study_buddy")
  end

  it "makes a new directory based on the destination" do
    opts = {:test_destination => ".study_buddy"}
    StudyBuddy::Initializer.new(opts).init
    File.exists?(File.join(Dir.pwd, ".study_buddy")).should == true
  end

  it "recognizes when there is no directory specified" do
    opts = {}
    StudyBuddy::Initializer.new(opts).init
    File.exists?(File.join(Dir.pwd, ".study_buddy")).should == true
  end

  it "recognizes when you already have study buddy data" do 
    Dir.mkdir(File.join(Dir.pwd, ".study_buddy"))
    expect { StudyBuddy::Initializer.new({}).init }.to raise_error("It appears you already have StudyBuddy data in this directory.")
  end

  after(:each) do
    FileUtils.rm_rf(".study_buddy") if File.exists?(".study_buddy")
  end
end
