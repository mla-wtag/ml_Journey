require "rails_helper"
RSpec.describe UsersController, type: :controller do
  let!(:user) do
    FactoryBot.create(:user,
                      firstname: "Michael",
                      lastname: "Lavelanet",
                      employee_id: "1234",
                      date_of_birth: "2004-12-12",
                      joining_day: "2004-12-12",
                      designation: "Junior Software Engineer",
                      email: "Mail",
                      password: "code")
  end

  describe "GET users#index" do
    it "renders the :index template" do
      get :index
      expect(response).to render_template :index
    end
  end
end
