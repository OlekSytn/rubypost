class AuthenticationController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }

  ALLOWED_DATA = %(email password).freeze

  # POST /auth/login
  def login
    data = json_payload.select { |allow| ALLOWED_DATA.include?(allow) }
    @member = Member.find_by_email!(data[:email])
    if @member.valid_password?(data[:password])
      token = JsonWebToken.encode(member_id: @member.id)
      time = Time.now + 24.hours.to_i
      render json: { token:, exp: time.strftime('%m-%d-%Y %H:%M'),
                     email: @member.email }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'Member and/or email not found' }, status: :not_found
  end
end
