
# game_spec.rb
require File.join(File.dirname(__FILE__), 'person')

describe Person do
  describe "#initialize" do
    let(:person) { Person.new( 'matt', 2.0 ) }

    specify "returns a person object" do
      person.class.should == Person
    end

    specify "name is public" do
      person.name.should == 'matt'
    end

    specify "awesomeness is public" do
      person.awesomeness.should == 2.0
    end
  end
end
