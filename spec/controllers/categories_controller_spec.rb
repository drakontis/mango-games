require "spec_helper"

describe CategoriesController do
  context "#new" do
    it 'should get new' do
      get :new
      assigned_category = assigns(:category)
      assigned_category.should_not be_nil
      assigned_category.should be_new_record
    end

    it 'should respond with 200' do
      get :new
      response.status.should == 200
    end
  end

  context "index" do
    it 'should get index' do
      category = Category.new(:code => 'code', :name => 'aname')
      category.save.should be_true

      get :index
      assigned_categories = assigns(:categories)
      assigned_categories.should_not be_nil
      assigned_categories.should_not be_empty
      assigned_categories.should include category
    end

    it 'should respond with 200' do
      get :index
      response.status.should == 200
    end
  end

  context 'create' do
    it 'should create a new category' do
      category_attributes = {:code => 'code', :name => 'name'}

      lambda do
        post :create, :category => category_attributes
      end.should change { Category.count }.by(1)
    end

    it 'should create a new category instance' do
      category_attributes = {:code => 'code', :name => 'name'}

      post :create, :category => category_attributes

      assigned_category = assigns(:category)
      assigned_category.should_not be_nil
      assigned_category.code.should == 'code'
    end

    it 'should redirect_to edit_category_path' do
      category_attributes = {:code => 'code', :name => 'name'}

      post :create, :category => category_attributes

      last_category = Category.last
      response.should redirect_to edit_category_path(:id => last_category.id)
      flash.notice.should == 'Category has been successfully created!'
    end

    it 'should not create a new category without code' do
      category_attributes = {:name => 'name'}

      lambda do
        post :create, :category => category_attributes
      end.should_not change { Category.count }
    end

    it 'should render new if save fails' do
      category_attributes = {:name => 'name'}

      post :create, :category => category_attributes
      response.should render_template :new
      flash[:error].should == 'Problem creating Category!'
    end
  end

  context 'edit' do
    it 'should get edit' do
      category = Category.new(:code => 'code', :name => 'name')
      category.save.should be_true

      get :edit, :id => category.id
      assigned_category = assigns(:category)
      assigned_category.should_not be_nil
      assigned_category.should_not be_new_record
    end

    it 'should respond with 200' do
      category = Category.new(:code => 'code', :name => 'name')
      category.save.should be_true

      get :edit, :id => category.id
      response.status.should == 200
    end
  end

  context 'Update' do
    it "should update an existing category's code" do
      category = Category.new(:code => 'code', :name => 'name')
      category.save.should be_true

      put :update, :id => category.id, :category => {:code => 'another_code'}

      category.reload
      category.code.should == 'another_code'
    end

    it "should update an existing category's name" do
      category = Category.new(:code => 'code', :name => 'name')
      category.save.should be_true

      put :update, :id => category.id, :category => {:name => 'another_name'}

      category.reload
      category.name.should == 'another_name'
    end

    it 'should redirect to edit category path' do
      category = Category.new(:code => 'code', :name => 'name')
      category.save.should be_true

      put :update, :id => category.id, :category => {:name => 'another_name'}

      response.status.should redirect_to edit_category_path(:id => category.id)
      flash.notice.should == 'Category has been successfully updated!'
    end

    it 'should render edit if update fails' do
      category = Category.new(:code => 'code', :name => 'name')
      category.save.should be_true

      Category.any_instance.stub(:update_attributes!).and_return false
      put :update, :id => category.id

      response.should render_template :edit
      flash[:error].should == 'Problem updating Category!'
    end
  end

  context 'destroy' do
    it 'should find the correct category' do
      category = Category.new(:code => 'code', :name => 'name')
      category.save.should be_true

      delete :destroy, :id => category.id
      assigned_category = assigns(:category)
      assigned_category.id.should == category.id
    end

    it 'should destroy a category' do
      category = Category.new(:code => 'code', :name => 'name')
      category.save.should be_true

      lambda do
        delete :destroy, :id => category.id
      end.should change { Category.count }.by(-1)
    end

    it 'should redirect to categories_path' do
      category = Category.new(:code => 'code', :name => 'name')
      category.save.should be_true

      delete :destroy, :id => category.id
      response.should redirect_to categories_path
      flash.notice.should == 'Category has been successfully deleted!'
    end

    it 'should render index if destroy fails' do
      category = Category.new(:code => 'code', :name => 'name')
      category.save.should be_true
      Category.any_instance.stub(:destroy).and_return false

      delete :destroy, :id => category.id
      response.should render_template :index
      flash[:error].should == 'Problem deleting Category!'
    end
  end
end