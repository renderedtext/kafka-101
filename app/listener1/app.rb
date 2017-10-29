require "kafka"

$stdout.sync = true

sleep 10

options = { :seed_brokers => ["kafka:9092"] }

$kafka = Kafka.new(options)

consumer = $kafka.consumer(group_id: "my-consumer")
consumer.subscribe("greetings")

trap("TERM") { consumer.stop }

consumer.each_message do |message|
  puts "topic: #{message.topic}, partition: #{message.partition}, offset: #{message.offset}, key: #{message.key}, value: #{message.value}"
end
