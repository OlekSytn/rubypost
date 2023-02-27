class Api::V1::MembersController < ApplicationController
  before_action :authorize_request, except: %i[index]
  before_action :find_member, except: %i[index]

  # GET /members
  def index
    @members = Member.all
    render json: @members
  end

  # GET /members/:id
  def show
    render json: @member
  end

  private

  def find_member
    @member = Member.find_by_id!(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'Member not found' }, status: :not_found
  end
end
