class BuildMailer < ApplicationMailer
  def build_started_mail(build)
    @build = build
    mail(to: build.email, subject: t('mailer.build_mailer.build_started_mail.subject'))
  end

  def build_done_success_mail(build)
    @build = build
    mail(to: build.email, subject: t('mailer.build_mailer.build_done_success_mail.subject'))
  end

  def build_done_fail_mail(build)
    @build = build
    mail(to: build.email, subject: t('mailer.build_mailer.build_done_fail_mail.subject'))
  end
end
