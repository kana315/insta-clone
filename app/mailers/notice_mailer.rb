class NoticeMailer < ApplicationMailer
  def notice_mail(notice)
    @notice = notice

    mail to: "example@dic.com", subject: "投稿完了のメール"
  end
end
