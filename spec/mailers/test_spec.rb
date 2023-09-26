require 'rails_helper'

RSpec.describe TestMailer, type: :mailer do
  let(:user) { create(:user) } # This will be available for all examples in this describe block

  describe 'does the mail has his header' do
    let(:mail) { TestMailer.confirmation_email(user) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Verification Email')
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['michael.lavelanet@welldev.io'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match(confirm_email_user_url(id: user.id, confirmation_token: user.confirmation_token))
    end
  end

  it 'enqueues email for delivery' do
    expect { TestMailer.confirmation_email(user).deliver_now }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end
end
