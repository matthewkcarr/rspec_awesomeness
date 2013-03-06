
# awesome_leaderboard.rb
# The leaderboard to the awesome people

require File.join(File.dirname(__FILE__), 'person')

class AwesomeLeaderboard

  attr_accessor :person_array

  # accepts an array of the Person class
  # returns an AwesomeLeaderboard object
  def initialize( person_array )
    @person_array = person_array
  end

  # accepts nothing
  # must return person who is the leader
  def leader
    new_leader = nil
    for person in @person_array
      new_leader = person if new_leader.nil?
      new_leader = person unless person.awesomeness < new_leader.awesomeness
    end
    return new_leader
  end

  # accepts nothing
  # must return the average awesome rating
  def average
    total_sum = @person_array.inject(0){ |sum, p| sum += p.awesomeness } 
    size = @person_array.size 
    return (total_sum / size)
  end

  # accepts nothing
  # must return the top ten awesome people
  def top_ten
    sorted = @person_array.sort { |a, b| a.awesomeness <=> b.awesomeness }
    sorted.reverse!
    return sorted[0..9] if sorted.size >= 10
    return sorted
  end

end

