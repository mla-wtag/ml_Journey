module SignInHelper
  def sign_in(user)
    allow(controller).to receive(:current_user).and_return(user)
  end

  def stub_authorize
    allow(controller).to receive(:authorize!).and_return(true)
  end
end
