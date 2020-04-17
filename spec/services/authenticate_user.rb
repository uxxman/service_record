class AuthenticateUser < ServiceRecord::Base
  attribute :email, :string
  attribute :password, :string
  attribute :performed, :boolean, default: false

  validates :email, :password, presence: true
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

  PASSWORD = '123'.freeze
  EMAIL = 'test@mail.com'.freeze

  before_perform do
    throw :abort if password == 'admin'
  end

  def perform
    self.performed = true

    if email == EMAIL && password == PASSWORD
      { user_id: 1 }
    else
      errors.add :authentication, 'invalid credentials'
    end
  end
end
