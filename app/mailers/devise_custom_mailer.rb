class DeviseCustomMailer < Devise::Mailer
  before_filter :add_inline_attachment!

  private
  def add_inline_attachment!
    attachments.inline['logo.png'] = { :content => File.read(Rails.root.join('app/assets/images/symbol.png'))}
  end
end
