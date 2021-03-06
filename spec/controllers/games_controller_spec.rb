require "spec_helper"

describe GamesController do
  before do
    login_without_capybara
  end

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
      game = Game.last!

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
      game = Game.new(:title => 'kinigito', :instructions => 'odigies gia to kinigito', :description => 'perigrafi krifto', :approved => true, :user => @user)
      game.categories << @category
      game.save!

      game2 = Game.new(:title => 'kinigito2',  :instructions => 'odigies gia to kinigito2', :description => 'perigrafi krifto2', :approved => false, :user => @user)
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
      game = Game.new(:title => 'kinigito', :instructions => 'odigies gia to kinigito', :description => 'perigrafi krifto', :approved => true, :user => @user)
      game.categories << @category
      game.save!

      game2 = Game.new(:title => 'kinigito2', :instructions => 'odigies gia to kinigito', :description => 'perigrafi krifto2', :approved => false, :user => @user)
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
      game_attributes = {:title => 'kinigito', :instructions => 'odigies gia to kinigito', :description => 'perigrafi gia to krifto', :user_id => @user.id, :category_ids => [@category.id]}

      lambda do
        post :create, :game => game_attributes
      end.should change{ Game.count }.by(1)
    end

    it 'should create a new game instance' do
      game_attributes = {:title => 'kinigito', :description => 'perigrafi gia to krifto', :user_id => @user.id, :category_ids => [@category.id]}

      post :create, :game => game_attributes

      assigned_game = assigns(:game)
      assigned_game.should_not be_nil
      assigned_game.title.should == 'kinigito'
    end

    it 'should redirect_to edit_game_path' do
      game_attributes = {:title => 'kinigito', :instructions => 'odigies gia to kinigito', :description => 'perigrafi gia to krifto', :user_id => @user.id, :category_ids => [@category.id]}

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

    it 'should not create a new game without instructions' do
      game_attributes = {:title => 'krifto', :description => 'perigrafi gia to krifto', :user_id => @user.id, :category_ids => [@category.id]}

      lambda do
        post :create, :game => game_attributes
      end.should change{ Game.count }.by(0)

      assigned_game = assigns(:game)
      assigned_game.errors[:instructions].should include "can't be blank"
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
      game = Game.last!

      get :show, :id => game.id

      assigned_game = assigns(:game)
      assigned_game.should_not be_nil
      assigned_game.should_not be_new_record
      assigned_game.should == game
    end
  end

  context '#edit' do
    it 'should get edit' do
      game = Game.last!

      get :edit, :id => game.id

      assigned_game = assigns(:game)
      assigned_game.should_not be_nil
      assigned_game.should_not be_new_record
      assigned_game.should == game
    end
  end

  context '#update' do
    before do
      @game = Game.last!
    end

    it "should update an existing game's title" do
      put :update, :id => @game.id, :game => {:title => 'kinigito'}

      @game.reload
      @game.title.should == 'kinigito'
    end

    it "should update an existing game's description" do
      put :update, :id => @game.id, :game => {:description => 'perigrafi kinigito'}

      @game.reload
      @game.description.should == 'perigrafi kinigito'
    end

    it "should update an existing game's approved" do
      put :update, :id => @game.id, :game => {:approved => false}
      @game.reload
      @game.approved.should be_false
    end

    it 'should redirect to edit game path' do
      put :update, :id => @game.id, :game => {:title => 'another_name'}

      response.status.should redirect_to game_path(:id => @game.id)
      flash.notice.should == 'Game has been successfully updated!'
    end

    it 'should render edit if update fails' do
      Game.any_instance.stub(:update_attributes!).and_return false
      put :update, :id => @game.id

      response.should render_template :edit
      flash[:error].should == 'Problem updating Game!'
    end
  end
end