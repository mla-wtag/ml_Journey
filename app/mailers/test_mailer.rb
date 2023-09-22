class TestMailer < ApplicationMailer
  default from: 'michael.lavelanet@welldev.io'

  def index(user_email)
    mail(
      subject: 'Email confirmation',
      to: 'michael.lavelanet@welldev.io',
      from: 'michael.lavelanet@welldev.io',
      track_opens: 'true',
      message_stream: 'broadcast',
    )
  end
end
