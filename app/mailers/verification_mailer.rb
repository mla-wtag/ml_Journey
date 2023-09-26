class VerificationMailer < ApplicationMailer
  def confirmation_email(user)
    @user = user
    mail(
      subject: I18n.t('mailer.subject'),
      to: @user.email,
      from: 'michael.lavelanet@welldev.io',
    )
  end
end
