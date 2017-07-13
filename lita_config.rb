# frozen_string_literal: true

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
  config.robot.name = ENV['ROBOT_NAME']
  config.robot.mention_name = ENV['ROBOT_MENTION_NAME']
  config.robot.alias = ENV['ROBOT_ALIAS']
  config.robot.adapter = ENV['ROBOT_ADAPTER'].to_sym
  config.robot.admins = ENV['ROBOT_ADMINS'].split(',')

  config.adapters.slack.token = ENV['SLACK_TOKEN']
  config.adapters.slack.link_names = ENV['SLACK_LINK_NAMES'] == 'true'
  config.adapters.slack.parse = ENV['SLACK_PARSE']
  config.adapters.slack.unfurl_links = ENV['SLACK_UNFURL_LINKS'] == 'true'
  config.adapters.slack.unfurl_media = ENV['SLACK_UNFURL_MEDIA'] == 'true'

  config.handlers.consul.consul_host = ENV['CONSUL_HOST']
  config.handlers.consul.consul_port = ENV['CONSUL_PORT']
  
  config.handlers.teamcity.endpoint = ENV['TEAMCITY_ENDPOINT']
  config.handlers.teamcity.user = ENV['TEAMCITY_USER']
  config.handlers.teamcity.password = ENV['TEAMCITY_PASSWORD']

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
    next unless key =~ /^CONFIG/
    config_name = key.downcase.sub!('_', '.') + '=' + get_value_from_str(value)
    eval(config_name)
  end

  config.redis[:url] = ENV['REDIS_URL']

  ## Example: Set configuration for any loaded handlers. See the handler's
  ## documentation for options.
  # config.handlers.some_handler.some_config_key = "value"
end
