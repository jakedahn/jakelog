class StaticController < ApplicationController

  def index
	  @posts = Post.all(:select => "title, id, created_at", :order => "created_at DESC")
    @post_months = @posts.group_by { |t| t.created_at.beginning_of_month }
  end

  def admin
  	if current_user
			@posts = Post.all
		else
			redirect_to '/auth/github'
  	end
  end

end
