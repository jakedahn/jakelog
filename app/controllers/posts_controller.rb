class PostsController < ApplicationController
  layout "editor", :only => [:edit, :new]

  def index
    @posts = Post.all(:select => "title, id, created_at", :order => "created_at DESC")
    @post_months = @posts.group_by { |t| t.created_at.beginning_of_month }

    respond_to do |format|
      format.html
      format.json { render json: @posts }
    end
  end

  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @post }
    end
  end


  def new
    if current_user
      title = "Untitled Post #{Time.now.strftime("%m/%d/%Y")}"
      @post = Post.create(title: title,
                          raw_body: "!!## #{title} ##!!",
                          cached_body: "",
                          draft: true)
      redirect_to edit_post_path(@post)
    end
  end


  def edit
    if current_user
      @post = Post.find(params[:id])
    end
  end


  def create
    if current_user
      @post = Post.new(params[:post])

      respond_to do |format|
        if @post.save
          format.html { redirect_to edit_post_url(@post), notice: 'Post was successfully created.' }
          format.json { render json: @post, status: :created, location: @post }
        else
          format.html { render action: "new" }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end
  end


  def update
    if current_user
      @post = Post.find(params[:id])

      raw_body = params[:post][:raw_body]

      if @post.raw_body != raw_body
        respond_to do |format|
          post_title = parse_title(raw_body)
          raw_body_minus_title = raw_body.split("\#\#\!\!\n")[1]

          if @post.update_attributes(raw_body: raw_body,
                                     cached_body: markdown(raw_body_minus_title),
                                     title: post_title)
            format.html { redirect_to @post, notice: 'Post was successfully updated.' }
            format.json { head :no_content }
          else
            format.html { render action: "edit" }
            format.json { render json: @post.errors, status: :unprocessable_entity }
          end
        end
      end

    end
  end


  # def destroy
  #   @post = Post.find(params[:id])
  #   @post.destroy

  #   respond_to do |format|
  #     format.html { redirect_to posts_url }
  #     format.json { head :no_content }
  #   end
  # end


def feed
  # this will be the name of the feed displayed on the feed reader
  @title = "JakeLog"

  # the news items
  @posts = Post.order("updated_at desc")

  @updated = @posts.first.updated_at unless @posts.empty?

  respond_to do |format|
    format.atom { render :layout => false }
  end
end


private

  def parse_title(string)
    string.match(/\!\!\#\#(.*?)\#\#\!\!/)[1].lstrip.rstrip || "Untitled"
  end

end
