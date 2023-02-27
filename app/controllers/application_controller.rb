class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, unless: -> { request.format.json? }

  before_action :update_allowed_parameters, if: :devise_controller?

  def current_user
    current_member
  end

  def posts_per_page
    @posts_per_page = 2
  end

  def json_payload
    return [] if request.raw_post.empty?

    HashWithIndifferentAccess.new(JSON.parse(request.raw_post))
  end

  def not_found
    render json: { error: 'not_found' }
  end

  def authorize_request
    header = request.headers['Authorization']
    if header
      header = header.split.last
      begin
        @decoded = JsonWebToken.decode(header)
        @current_member = Member.find_by_id!(@decoded[:member_id])
      rescue ActiveRecord::RecordNotFound || JWT::DecodeError => e
        render json: { errors: e.message }, status: :unauthorized
      end
    else
      render json: { errors: 'Unauthorized member' }, status: :unauthorized
    end
  end

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:name, :email, :password, :password_confirmation, :bio, :photo)
    end
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:name, :email, :password, :password_confirmation, :current_password)
    end
  end
end
