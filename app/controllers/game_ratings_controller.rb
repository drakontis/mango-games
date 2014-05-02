class GameRatingsController < ApplicationController
  def create

    rating = GameRating.where(:game_id => params[:game_id]).where(:user_id => session[:user_id]).first

    if rating.present?
      rating.score = params[:score]
    else
      rating = GameRating.new(:game_id => params[:game_id], :user_id => session[:user_id], :score => params[:score])
    end

    if rating.save
      render :partial => 'game_ratings/star_rating', :locals => {:game => rating.game, :div_id => 'average-rating'}
    else
      render :nothing => true
    end
  end
end