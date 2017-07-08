Lita.configure do |config|
  def get_value_from_str(value)
    case value
    when 'true', 'false', /^:.+/, /^[0..9]+$/
      value
    else
      value.inspect
    end
  end
  # The name your robot will use.

  # The locale code for the language to use.
  config.robot.locale = :en

  # The severity of messages to log. Options are:
  # :debug, :info, :warn, :error, :fatal
  # Messages at the selected level and above will be logged.
  config.robot.log_level = :debug

  # An array of user IDs that are considered administrators. These users
  # the ability to add and remove other users from authorization groups.
  # What is considered a user ID will change depending on which adapter you use.
  # config.robot.admins = ["1", "2"]

  # The adapter you want to connect with. Make sure you've added the
  # appropriate gem to the Gemfile.
  # config.robot.adapter = :shell

  ## Example: Set options for the chosen adapter.
  # config.adapter.username = "myname"
  # config.adapter.password = "secret"

  ## Example: Set options for the Redis connection.
  # config.redis.host = "127.0.0.1"
  # config.redis.port = 1234

  ENV.each do |key, value|
    next unless key =~ /CONFIG/
    config_name = key.downcase.sub!('_', '.') + '=' + get_value_from_str(value)
    eval(config_name)
  end

  # config.redis[:url] = ENV['CONFIG_REDIS_URL']

  ## Example: Set configuration for any loaded handlers. See the handler's
  ## documentation for options.
  # config.handlers.some_handler.some_config_key = "value"
end
