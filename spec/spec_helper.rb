current_path = File.expand_path("..", File.dirname(__FILE__))
$:.unshift File.expand_path(File.join( current_path, "account_management"))
$:.unshift File.expand_path(File.join( current_path, "customer_status"))

require "rewards_service"