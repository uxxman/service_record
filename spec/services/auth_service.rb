# frozen_string_literal: true

class AuthService < ServiceRecord::Base
  attribute :email,    :string
  attribute :password, :string

  validates :email, :password, presence: true
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

  EMAIL    = 'test@mail.com'
  PASSWORD = '1234567'

  def perform
    if email == EMAIL && password == PASSWORD
      { success: true }
    else
      errors.add :credentials, 'invalid'
    end
  end
end
