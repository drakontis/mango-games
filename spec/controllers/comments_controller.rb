require "spec_helper"

describe CommentsController do
  before do
    rank = Rank.new(:code => 1, :name => 'moderator')
    rank.save!

    @user = User.new(:username => 'nim', :password => '1234', :email => 'foo@foo.gr', :rank => rank)
    @user.save!

    @category = Category.new(:code => 'code', :name => 'name')
    @category.save!

    game = Game.new(:title => 'krifto', :description => 'perigrafi krifto', :approved => true, :user => @user)
    game.categories << @category
    game.save!
  end

  context '#create' do
    it 'should create a new comment' do
      pending 'Not implemented Yet'
    end

    it 'should respond with 200' do
      pending 'Not implemented yet'
    end

    it 'should respond with 404' do

    end
  end
end