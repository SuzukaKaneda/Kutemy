class Devise::Mailer < ApplicationMailer
    def reset_password_instructions(record, token, opts={})
      @token = token
      @resource = record
  
      # メールの送信設定
      mail(
        to: @resource.email,
        subject: "パスワード再設定の指示"
      ) do |format|
        format.html { render 'devise/mailer/reset_password_instructions' } # HTMLテンプレートを指定
      end
    end
  end