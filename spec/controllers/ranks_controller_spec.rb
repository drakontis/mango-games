require "spec_helper"

describe RanksController do

  before do
    login_without_capybara
  end

  context "#new" do
    it 'should get new' do
      get :new
      assigned_rank = assigns(:rank)
      assigned_rank.should_not be_nil
      assigned_rank.should be_new_record
    end

    it 'should respond with 200' do
      get :new
      response.status.should == 200
    end
  end

  context "index" do
    it 'should get index' do
      rank = Rank.last!

      get :index
      assigned_ranks = assigns(:ranks)
      assigned_ranks.should_not be_nil
      assigned_ranks.should_not be_empty
      assigned_ranks.should include rank
    end

    it 'should respond with 200' do
      get :index
      response.status.should == 200
    end
  end

  context 'create' do
    it 'should create a new rank' do
      rank_attributes = {:code => 100, :name => 'name'}

      lambda do
        post :create, :rank => rank_attributes
      end.should change { Rank.count }.by(1)
    end

    it 'should create a new rank instance' do
      rank_attributes = {:code => 0, :name => 'name'}

      post :create, :rank => rank_attributes

      assigned_rank = assigns(:rank)
      assigned_rank.should_not be_nil
      assigned_rank.code.should == 0
    end

    it 'should redirect_to edit_rank_path' do
      rank_attributes = {:code => 100, :name => 'name'}

      post :create, :rank => rank_attributes

      last_rank = Rank.last
      response.should redirect_to edit_rank_path(:id => last_rank.id)
      flash.notice.should == 'Rank has been successfully created!'
    end

    it 'should not create a new rank without code' do
      rank_attributes = {:name => 'name'}

      lambda do
        post :create, :rank => rank_attributes
      end.should_not change { Rank.count }
    end

    it 'should render new if save fails' do
      rank_attributes = {:name => 'name'}

      post :create, :rank => rank_attributes
      response.should render_template :new
      flash[:error].should == 'Problem creating Rank!'
    end
  end

  context 'edit' do
    it 'should get edit' do
      rank = Rank.last!

      get :edit, :id => rank.id
      assigned_rank = assigns(:rank)
      assigned_rank.should_not be_nil
      assigned_rank.should_not be_new_record
    end

    it 'should respond with 200' do
      rank = Rank.last!

      get :edit, :id => rank.id
      response.status.should == 200
    end
  end

  context 'Update' do
    it "should update an existing rank's code" do
      rank = Rank.last!

      post :update, :id => rank.id, :rank => {:code => '1'}

      rank.reload
      rank.code.should == 1
    end

    it "should update an existing rank's name" do
      rank = Rank.last!

      post :update, :id => rank.id, :rank => {:name => 'another_name'}

      rank.reload
      rank.name.should == 'another_name'
    end

    it 'should redirect to edit rank path' do
      rank = Rank.last!

      post :update, :id => rank.id, :rank => {:name => 'another_name'}

      response.status.should redirect_to edit_rank_path(:id => rank.id)
      flash.notice.should == 'Rank has been successfully updated!'
    end

    it 'should render edit if update fails' do
      rank = Rank.last!

      Rank.any_instance.stub(:update_attributes!).and_return false
      post :update, :id => rank.id

      response.should render_template :edit
      flash[:error].should == 'Problem updating Rank!'
    end
  end

  context 'destroy' do
    it 'should find the correct rank' do
      rank = Rank.find_by_name('Unused')

      delete :destroy, :id => rank.id
      assigned_rank = assigns(:rank)
      assigned_rank.id.should == rank.id
    end

    it 'should destroy a rank' do
      rank = Rank.find_by_name('Unused')

      lambda do
        delete :destroy, :id => rank.id
      end.should change { Rank.count }.by(-1)
    end

    it 'should redirect to ranks_path' do
      rank = Rank.find_by_name('Unused')

      delete :destroy, :id => rank.id
      response.should redirect_to ranks_path
      flash.notice.should == 'Rank has been successfully deleted!'
    end

    it 'should render index if destroy fails' do
      rank = Rank.last!
      Rank.any_instance.stub(:destroy).and_return false

      delete :destroy, :id => rank.id
      response.should render_template :index
      flash[:error].should == 'Problem deleting Rank!'
    end
  end
end