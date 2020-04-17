class AuthenticateUser < ServiceRecord::Base
  attribute :email, :string
  attribute :password, :string

  validates :email, :password, presence: true
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

  PASSWORD = '123'.freeze
  EMAIL = 'test@mail.com'.freeze

  def perform
    if email == EMAIL && password == PASSWORD
      { user_id: 1 }
    else
      errors.add :authentication, 'invalid credentials'
    end
  end
end
