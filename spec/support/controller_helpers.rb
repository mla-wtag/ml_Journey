module ControllerHelpers
  def stub_current_user(user)
    allow(controller).to receive(:current_user).and_return(user)
  end

  def stub_authorize
    allow(controller).to receive(:authorize!).and_return(true)
  end
end
