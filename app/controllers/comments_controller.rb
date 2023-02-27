class CommentsController < ApplicationController
  before_action :authenticate_member!
  before_action :set_member, only: %i[new create edit update destroy]
  before_action :set_post, only: %i[new create edit update destroy]
  before_action :set_comment, only: %i[edit update destroy]
  load_and_authorize_resource

  def new
    @comment = @post.comments.new
  end

  def create
    @comment = @post.comments.new(comment_params)
    @comment.author = current_user
    if @comment.save
      respond_to do |format|
        format.html { redirect_to member_post_path(@member, @post), notice: 'Comment was successfully created' }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      redirect_to member_post_path(@member, @post), notice: 'Comment was successfully updated'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to member_post_path(@member, @post), notice: 'Comment was successfully deleted' }
      format.turbo_stream
    end
  end

  private

  def set_member
    @member = Member.find(params[:member_id])
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
