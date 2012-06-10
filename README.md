# StudyBuddy

## Dependencies

This gem is pretty much tailored to my workflow.  Look for more customization options in the future.

1. colordiff
2. vim

## Installation

Currently, this github repo is the only place to get this gem.  
    
    git clone https://github.com/rjg/study_buddy
    cd study_buddy
    gem build study_buddy.gemspec
    rake install

## Usage

More to come on this later...

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## TODO:

1. Make it so you can have a range AND a number.  So if I want to do only 10 from a certain directory or range of 20.  
2. Have it remember what the last settings were so when I want to just make a new test, I can just do "study_buddy make"
3. Handle the question number thing (e.g. when I try to do a test with more questions than lines)
4. The checking is broken.  It needs to remember what you were doing last so when you run study_buddy check it knows what test to check.
5. The lib/study_buddy initialize method needs to be cleaned up.
