require_relative '../../../lib/study_buddy/test_maker'

describe StudyBuddy::TestMaker do
  let(:dummy_file){ File.expand_path("spec/fixtures/test.txt") }
  let(:opts) { {:data_file => dummy_file} }
  let(:study_buddy_dir) { File.join(Dir.pwd, ".study_buddy") }

  before(:each) do
    Dir.mkdir(study_buddy_dir) unless File.exists?(study_buddy_dir)
  end

  after(:each) do
    FileUtils.rm_rf(study_buddy_dir)
  end

  it "responds correctly when there's no data in the options hash" do
    expect { StudyBuddy::TestMaker.new({}) }.to raise_error("Please specify a data file.")
  end

  it "makes the test dir" do
    StudyBuddy::TestMaker.new(opts)
    File.exists?(File.join(study_buddy_dir, "test")).should == true
  end

  it "reads only the populated lines of the file" do
    opts[:number] = 1000
    StudyBuddy::TestMaker.new(opts).lines.length.should == 25
  end

  it "reads the number from the options hash" do
    opts[:number] = 1
    test = StudyBuddy::TestMaker.new(opts)
    test.questions.length.should == 1
  end

  it "reads the range from the options hash" do
    opts[:range] = "2-4"
    test = StudyBuddy::TestMaker.new(opts)
    test.questions.length.should == 3
  end

  it "defaults to 10 questions when no number is indicated in the options" do
    test = StudyBuddy::TestMaker.new(opts)
    test.questions.length.should == 10
  end

  it "responds correctly when n > # of questions" do
    opts[:number] = 1000
    test = StudyBuddy::TestMaker.new(opts)
    test.questions.length.should == 25 # Grabs all possible Q's (Fails gracefully)
  end

  context "writing the test files" do
    before(:each) do
      StudyBuddy::TestMaker.new(opts)
    end

    it "makes the test" do
      File.exists?(File.join(Dir.pwd, ".study_buddy", "test", "TEST")).should == true
    end

    it "makes the answer choices" do
      File.exists?(File.join(Dir.pwd, ".study_buddy", "test", "ANSWER")).should == true
    end

    it "makes the answer key" do
      File.exists?(File.join(Dir.pwd, ".study_buddy", "test", "KEY")).should == true
    end
  end
  
  it "calls 'start' if the option is specified" do
    Kernel.stub(:exec) 
    opts[:start_test] = true
    Kernel.should_receive(:exec)
      .with("vim -o #{study_buddy_dir}/test/ANSWER #{study_buddy_dir}/test/TEST")

    StudyBuddy::TestMaker.new(opts)
  end

end
