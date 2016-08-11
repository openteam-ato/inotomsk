class DocumentsMailer < ActionMailer::Base
  before_filter :add_inline_attachment!

  default from: 'noreply@ino-tomsk.ru'

  def send_notify(user, document)
    @user = user
    @document = document
    mail(to: @user.email, subject: 'Добавлен новый документ')
  end

  private

  def add_inline_attachment!
    attachments.inline['logo.png'] = { content: File.read(Rails.root.join('app/assets/images/symbol.png')) }
  end
end
