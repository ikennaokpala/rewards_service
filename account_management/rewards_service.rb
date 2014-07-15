require 'eligibility_service'

module AccountManagement
  class RewardsService
    def initialize(account, subscriptions)
      @account = account
      @subscriptions = subscriptions
    end

    def results
      @results ||= CustomerStatus::EligibilityService.new(@account)
    end

    def available
      if eligible? then rewards else results.description end
    end

    def eligible?
      results.output == "CUSTOMER_ELIGIBLE"
    end

    def rewards
      rewards_manifest = REWARDS.fetch('rewards')
      @subscriptions.inject([]) do |rewards, subcription|
        unless rewards_manifest[subcription] == "N/A"
         rewards.push(rewards_manifest[subcription]) 
        end   
        rewards
      end.compact
    end 
  end
end

REWARDS = -> {
          require 'yaml'
          dir_path = File.expand_path("..", File.dirname(__FILE__))
          YAML.load_file("#{dir_path}/config/rewards.yaml")
        }.()