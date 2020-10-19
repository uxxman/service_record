class AuthenticateUser < ServiceRecord::Base
  attribute :email, :string
  attribute :password, :string
  attribute :performed, :boolean, default: false
  attribute :after_callback_called, :boolean, default: false
  attribute :before_callback_called, :boolean, default: false
  attribute :around_callback_called_after_yield, :boolean, default: false
  attribute :around_callback_called_before_yield, :boolean, default: false

  validates :email, :password, presence: true
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

  PASSWORD = '123'.freeze
  EMAIL = 'test@mail.com'.freeze

  before_perform do
    self.before_callback_called = true
    throw :abort if password == 'admin'
  end

  around_perform do |_, block|
    self.around_callback_called_before_yield = true

    block.call

    self.around_callback_called_after_yield = true
  end

  after_perform do
    self.after_callback_called = true
  end

  after_perform do
    self.after_callback_called = true
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
