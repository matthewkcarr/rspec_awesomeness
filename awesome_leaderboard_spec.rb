
# game_spec.rb
require File.join(File.dirname(__FILE__), 'awesome_leaderboard')

describe AwesomeLeaderboard do
  describe "#initialize" do
    it "returns a leaderboard object" do
      leaderboard = AwesomeLeaderboard.new( [] )
      leaderboard.class.should == AwesomeLeaderboard
    end
  end
  
  context "given a manageable amount of awesome people" do

    let(:lowest_awesome_but_still_awesome_person){ Person.new( 'matt', 2.0 ) }  
    let(:middle_awesome_but_still_awesome_person) { Person.new( 'kevin', 4.0 ) }  
    let(:most_awesome_but_still_not_perfect_person) { Person.new( 'sasha', 8.0 ) }  

    let(:persons) {
      [ lowest_awesome_but_still_awesome_person, 
        middle_awesome_but_still_awesome_person,
        most_awesome_but_still_not_perfect_person
      ]
    }

    describe "#leader" do
      it "returns the leading awesome person" do
        leaderboard = AwesomeLeaderboard.new( persons )
        leaderboard.leader.should == most_awesome_but_still_not_perfect_person
      end
    end

    describe "#average" do
      it "returns the average awesomeness of a group of persons" do
        leaderboard = AwesomeLeaderboard.new( persons )
        leaderboard.average.should == (14.0 / 3.0)
      end
    end

    #create 15 awesome people
    # get the top ten, make sure the first person's awesomeness is greater than or equal to the next and for each person
    # make sure the bottom five are not included in the top ten
    describe "#top_ten" do
      it "should contain top ten based on awesomeness factor" do
        fifteen = []
        for i in 0..14
          person = Person.new( 'person_' + i.to_s, 1 + rand(10))
          fifteen << person
        end
        fifteen.size.should == 15
        sorted_fifteen = (fifteen.sort { |a, b| a.awesomeness <=> b.awesomeness }).reverse
        bottom_five = sorted_fifteen[10..14]

        leaderboard = AwesomeLeaderboard.new( fifteen )
        top_ten = leaderboard.top_ten
        top_ten.size.should == 10

        last_person = top_ten[0]
        top_ten.each do |person|
          next if person == last_person
          person.awesomeness.should <= last_person.awesomeness
          bottom_five.include?(person).should == false
          last_person = person
        end
      end
    end

  end

end
