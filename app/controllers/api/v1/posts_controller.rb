class Api::V1::PostsController < ApplicationController
  before_action :authorize_request
  before_action :find_member

  def index
    posts = @member.posts
    render json: posts
  end

  def show
    post = @member.posts.find_by_id!(params[:id])
    render json: post
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'Post not found' }, status: :not_found
  end

  private

  def find_member
    @member = Member.find_by_id!(params[:member_id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'Member not found' }, status: :not_found
  end
end
