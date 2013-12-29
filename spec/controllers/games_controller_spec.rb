require "spec_helper"

describe GamesController do
  before do
    rank = Rank.new(:code => 1, :name => 'moderator')
    rank.save!

    @user = User.new(:username => 'nim', :password => '1234', :email => 'foo@foo.gr', :rank => rank)
    @user.save!

    @category = Category.new(:code => 'code', :name => 'name')
    @category.save!
  end

  context "#new" do
    it 'should get new' do
      get :new
      assigned_game = assigns(:game)
      assigned_game.should_not be_nil
      assigned_game.should be_new_record
    end

    it 'should respond with 200' do
      get :new
      response.status.should == 200
    end
  end

  context "#index" do
    it 'should get index' do
      game = Game.new(:title => 'krifto', :description => 'perigrafi krifto', :approved => true, :user => @user)
      game.categories << @category
      game.save!

      get :index
      assigned_games = assigns(:games)
      assigned_games.should_not be_nil
      assigned_games.should be_a(Array)
      assigned_games.should_not be_empty
      assigned_games.should include(game)
    end

    it 'should respond with 200' do
      get :index
      response.status.should == 200
    end

    it 'should get only the approved games' do
      game = Game.new(:title => 'krifto', :description => 'perigrafi krifto', :approved => true, :user => @user)
      game.categories << @category
      game.save!

      game2 = Game.new(:title => 'krifto2', :description => 'perigrafi krifto2', :approved => false, :user => @user)
      game2.categories << @category
      game2.save!

      get :index
      assigned_games = assigns(:games)
      assigned_games.should_not be_nil
      assigned_games.should be_a(Array)
      assigned_games.should_not be_empty
      assigned_games.should include(game)
      assigned_games.should_not include(game2)
    end

    it 'should get only the not approved games' do
      game = Game.new(:title => 'krifto', :description => 'perigrafi krifto', :approved => true, :user => @user)
      game.categories << @category
      game.save!

      game2 = Game.new(:title => 'krifto2', :description => 'perigrafi krifto2', :approved => false, :user => @user)
      game2.categories << @category
      game2.save!

      get :not_approved
      assigned_games = assigns(:games)
      assigned_games.should_not be_nil
      assigned_games.should be_a(Array)
      assigned_games.should_not be_empty
      assigned_games.should_not include(game)
      assigned_games.should include(game2)
    end
  end

  context '#create' do
    it 'should create a new game' do
      game_attributes = {:title => 'krifto', :description => 'perigrafi gia to krifto', :user_id => @user.id, :category_ids => [@category.id]}

      lambda do
        post :create, :game => game_attributes
      end.should change{ Game.count }.by(1)
    end

    it 'should create a new game instance' do
      game_attributes = {:title => 'krifto', :description => 'perigrafi gia to krifto', :user_id => @user.id, :category_ids => [@category.id]}

      post :create, :game => game_attributes

      assigned_game = assigns(:game)
      assigned_game.should_not be_nil
      assigned_game.title.should == 'krifto'
    end

    it 'should redirect_to edit_game_path' do
      game_attributes = {:title => 'krifto', :description => 'perigrafi gia to krifto', :user_id => @user.id, :category_ids => [@category.id]}

      post :create, :game => game_attributes

      last_game = Game.last
      response.should redirect_to game_path(:id => last_game.id)
      flash.notice.should == 'Game has been successfully created!'
    end

    it 'should not create a new game without a title' do
      game_attributes = {:description => 'perigrafi gia to krifto', :user_id => @user.id, :category_ids => [@category.id]}

      lambda do
        post :create, :game => game_attributes
      end.should change{ Game.count }.by(0)

      assigned_game = assigns(:game)
      assigned_game.errors[:title].should include "can't be blank"
    end

    it 'should not create a new game without a description' do
      game_attributes = {:title => 'krifto', :user_id => @user.id, :category_ids => [@category.id]}

      lambda do
        post :create, :game => game_attributes
      end.should change{ Game.count }.by(0)

      assigned_game = assigns(:game)
      assigned_game.errors[:description].should include "can't be blank"
    end

    it 'should not create a new game without a user id' do
      game_attributes = {:title => 'krifto', :description => 'perigrafi gia to krifto', :category_ids => [@category.id]}

      lambda do
        post :create, :game => game_attributes
      end.should change{ Game.count }.by(0)

      assigned_game = assigns(:game)
      assigned_game.errors[:user_id].should include "can't be blank"
    end

    it 'should render new if save fails' do
      game_attributes = {:title => 'krifto', :description => 'perigrafi gia to krifto', :category_ids => [@category.id]}

      post :create, :category => game_attributes
      response.should render_template :new
      flash[:error].should == 'Problem creating Game!'
    end
  end

  context '#show' do
    it 'should get show' do
      game = Game.new(:title => 'krifto', :description => 'perigrafi krifto', :approved => true, :user => @user)
      game.categories << @category
      game.save!

      get :show, :id => game.id

      assigned_game = assigns(:game)
      assigned_game.should_not be_nil
      assigned_game.should_not be_new_record
      assigned_game.should == game
    end
  end
end