require 'spec_helper'

describe Movie do
  describe 'all ratings' do
    it 'should always return a string' do
      Movie.all_ratings.should == ["G", "PG", "PG-13", "NC-17", "R"]
    end
  end
end