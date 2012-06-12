require_relative "../../../lib/study_buddy"

describe StudyBuddy::TestChecker do
  before(:each) do
    diff = IO.readlines(File.join("spec", "fixtures", "diff.txt")).join
    @test_checker = StudyBuddy::TestChecker.new
    @test_checker.process_diff(diff)

    # setup tmp dir
    @tmp = File.join(Dir.pwd, 'tmp')
    Dir.mkdir(@tmp) unless File.exists?(@tmp)
    @tmp_weak_file = File.join(@tmp, 'WEAK')
  end

  it "processes the diff" do
    @test_checker.right_answers.length.should == 2
  end

  it "removes the '>' character from the string" do
    @test_checker.right_answers[0].should == "phosphorylation glycosylation and hydroxylation                                 = covalent modifications"
  end

  it "writes wrong answers to WEAK file" do
    @test_checker.write_wrong(@tmp_weak_file)
    File.readlines(@tmp_weak_file).length.should == 2
  end

  after(:each) do 
    FileUtils.rm_rf(@tmp)
  end
end
