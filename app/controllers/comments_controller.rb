class CommentsController < ApplicationController
  def create
    comment = Comment.new(params[:comment])
    comment.user_id = session[:user_id]

    if comment.save
      render :partial => 'comment_details', :locals => {:comment => comment}, :status => 200
    else
    end
  end
end