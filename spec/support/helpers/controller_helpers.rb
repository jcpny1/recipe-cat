module ControllerHelpers
  def sign_in!(role = 'user')
    user = create(:user, role: role)
    allow(request.env['warden']).to receive(:authenticate!).and_return(user)
    allow(controller).to receive(:current_user).and_return(user)
  end
end
