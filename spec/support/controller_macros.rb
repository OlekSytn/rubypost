module ControllerMacros
  def login_admin
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:admin]
      sign_in FactoryBot.create(:admin)
    end
  end

  def login_member
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:member]
      member = FactoryBot.create(:member)
      sign_in member
    end
  end
end
