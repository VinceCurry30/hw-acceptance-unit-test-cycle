require 'rails_helper'

describe MoviesController do

  describe 'happy path' do
    before :each do
      @movie = double(Movie, :title => "Star Wars", :director => "George Lucas", :id => "1")
      Movie.stub(:find_by_id).with("1").and_return(@movie)
    end
  
    it 'should find route for find movie with same directors' do
      { :get => search_directors_path(1) }.
      should route_to(:controller => "movies", :action => "search_directors", :id => "1")
    end
    
    it 'should call the method that finds movie with same directors' do
      fake_results = [double('Movie1'), double('Movie2')]
      Movie.should_receive(:where).with(:director => 'George Lucas').and_return(fake_results)
      get :search_directors, {:id => "1"}
    end
    
    it 'should select the search_directors template for rendering' do
      fake_results = [double('Movie1'), double('Movie2')]
      Movie.stub(:where).with(:director => 'George Lucas').and_return(fake_results)
      get :search_directors, :id => 1
      response.should render_template('search_directors')
    end
    
    it 'should make results available' do
      fake_results = [double('Movie1'), double('Movie2')]
      Movie.should_receive(:where).with(:director => 'George Lucas').and_return(fake_results)
      get :search_directors, {:id => 1}
      assigns(:movies).should == fake_results
    end
  end
  
  describe 'sad path' do
    before :each do
      m=double(Movie, :title => "Star Wars", :director => nil, :id => "1")
      Movie.stub(:find_by_id).with("1").and_return(m)
    end
  
    it 'should find route for find movie with same directors' do
      { :get => search_directors_path(1) }.
      should route_to(:controller => "movies", :action => "search_directors", :id => "1")
    end
    
    it 'should select the Index template for rendering and show a flash' do
      Movie.stub(:where)
      get :search_directors, :id => 1
      response.should redirect_to(movies_path)
      flash[:notice].should_not be_blank
    end
  end
end