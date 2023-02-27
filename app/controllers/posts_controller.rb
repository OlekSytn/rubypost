class PostsController < ApplicationController
  before_action :authenticate_member!
  before_action :set_post, only: %i[show destroy]
  before_action :set_member, only: %i[index show]
  load_and_authorize_resource

  def index
    @page = params.fetch(:page, 1)
    @posts = @member.posts.offset(posts_per_page * (@page.to_i - 1)).limit(posts_per_page)
  end

  def show
    @comments = @post.comments.ordered.includes(:author)
    @like = Like.where(post: @post, author: current_user)
    @current_user = current_user
  end

  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    post.author = current_user
    if post.save
      redirect_to member_path(current_user), notice: 'Post was successfully created'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy

    redirect_to root_path, notice: 'Post was successfully deleted'
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def set_member
    @member = Member.find(params[:member_id])
  end

  def post_params
    params.require(:member_posts).permit(:title, :text)
  end
end
