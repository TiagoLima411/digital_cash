class Geral < ApplicationMailer

  def wellcome(user, link, email)
    @title = 'Nobe - Bem vindo'
    @address = "atendimento@nobe.com.br"
    @link = link
    mail(to: email, subject: @title)
  end

end
