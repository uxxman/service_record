# ServiceRecord

![GitHub Workflow Status](https://img.shields.io/github/workflow/status/uxxman/service_record/Continuous%20Integration)
[![Maintainability](https://api.codeclimate.com/v1/badges/7634ecae285ff14e6bd6/maintainability)](https://codeclimate.com/github/uxxman/service_record/maintainability)
[![Gem Version](https://badge.fury.io/rb/service_record.svg)](https://badge.fury.io/rb/service_record)

An ActiveRecord lookalike but for business model requirements, a.k.a Service Objects.

Rails is packed with amazing tools to get you started with building your new awesome project and enforces reliable and battle-tested guidelines. One of those guideline is "**thin controllers and fat models**", but sometimes (actually most of the time) its difficult to follow because most business requirements are not that simple like most CRUD operations. 

Enters, ServiceRecord. Its similar to ActiveRecord models but their sole purpose is to perform a big/complex/muilt-step task without bloating the controllers or models.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'service_record'
```

And then execute:

```shell
$ bundle install
```

Or install it yourself as:

```shell
$ gem install service_record
```

Now you can start creating new service classes. Rails generator can be used to create new services, e.g, the following will create a service class file `app/services/authenticate_user.rb`.

```shell
rails g service authenticate_user
```

## Usage

A basic Service class looks like the following

```ruby
class MyService < ApplicationService
  attribute :email, :string
  attribute :password, :string

  validates :email, :password, presence: true

  def perform
  end
end
```

Now you can invoke this service by writting;

```ruby
response = MyService.perform(email: '', password: '')
```

The returned response from a service will have the following useful attributes/methods,

* `success?` contains true if service was performed without any errors, false otherwise
* `failure?` contains opposite of success?
* `result` contains returned value of service perform function
* `errors` contains details about issues that occurr while performing the service 



## Example

Let's take a real world example of users controller and the sign_in action that involes JWT authentication.

Without ServiceRecord 🙈

```ruby
# Inside controllers/users_controller.rb
def sign_in
  token = nil
  errors = []

  # Basic validation
  errors << 'Email is required' if params[:email].blank?
  errors << 'Email is invalid' if params[:email].present? && /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.match?(params[:email])
  errors << 'Password is required' if params[:password].blank?

  if errors.size == 0
    user = User.find_by(email: params[:email]).try(:authenticate, params[:password])

    if user.present?
      token = JsonWebToken.encode(user_id: user.id)
    else
      errors << 'Invalid credentials'
    end
  end

  if errors.size == 0
    render json: token
  else
    render json: errors, status: :unauthorized
  end
end
```

With ServiceRecord 😍

```ruby
# Inside services/authenticate_user.rb
class AuthenticateUser < ApplicationService
  attribute :email, :string
  attribute :password, :string

  validates :email, :password, presence: true
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

  def perform
    user = User.find_by(email: email).try(:authenticate, password)

    return JsonWebToken.encode(user_id: user.id) if user.present?
    
    errors.add :authentication, 'invalid credentials'
  end
end


# Inside controllers/users_controller.rb
def sign_in
  response = AuthenticateUser.perform(params.permit(:email, :password))

  if response.success?
    render json: response.result
  else
    render json: response.errors, status: :unauthorized
  end
end
```

## Validations

ServiceRecord extends on `ActiveModel::Validations`, so, everything that you can do there can be done inside a service class and ServiceRecord will make sure that a service only runs the perform function when all validations are passed, otherwise `errors` will contain details about the validation issues.


## Custom Errors

Just like validation errors, you can also add custom errors that you want to be reported. Use them to handle errors which are not related to input parameters validation. E.g.

```ruby
errors.add :authentication, 'invalid credentials'
```

## Callbacks

You can also add callbacks on the perform function similar to [ActiveJob's](https://edgeguides.rubyonrails.org/active_job_basics.html#callbacks) perform function. E.g.

```ruby
class SampleService < ApplicationService
  before_perform :do_something

  def perform
  end

  private
    
  def do_something
  end
end
```

Availble callbacks are `before_perform`, `after_perform` and `around_perform`. If a `before_perform` calls `throw :abort`, the callback chain is hallted and perform function will not be called.


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

Bug reports and pull requests are welcome on GitHub at https://github.com/uxxman/service_record.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
