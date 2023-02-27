class Api::V1::LikesController < ApplicationController
  before_action :find_member_post

  def create
    like = @post.likes.new
    like.author = @member
    if like.save
      render json: like
    else
      render json: { error: 'Could not create it' }, status: :unprocessable_entity
    end
  end

  def destroy
    like = Like.where(post: @post, author: @member)
    like.destroy_all
  end

  private

  def find_member_post
    @member = current_user
    @post = Post.find_by_id!(params[:post_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Member and/or post not found' }, status: :not_found
  end
end
