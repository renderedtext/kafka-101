require "kafka"

sleep 10 # give time to kafka to start up

options = {
  # At least one of these nodes must be available:
  :seed_brokers => ["kafka:9092"],

  # Set an optional client id in order to identif
  :client_id => "message-source-1"
}

$kafka = Kafka.new(options)

message_index = 0

loop do
  message = "Hello, #{message_index}"

  p "Publishing: #{message}"

	$kafka.deliver_message(message, :topic => "greetings")

  message_index += 1

  sleep 10
end

at_exit { $kafka.shutdown }
