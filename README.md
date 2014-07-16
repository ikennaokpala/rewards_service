# RewardsService

Rewards Service test code and kata.. 

#Scenario

	A ground-breaking broadcaster has decided to reward its most loyal customers. A software engineering team, developing the customer account website, is working on the story below.
	The Account Management team has partnered with the Customer Status team that provides a service that checks the customer eligibility based on loyalty and billing status.

#Instructions

	You are required to provide an implementation of a RewardsService. You may use any programming language you like.
	The service accepts as input a customer account number and a portfolio containing channels subscriptions. If the customer is eligible for rewards the RewardsService should return a list of all the rewards available according to the subscriptions on the portfolio.

#Acceptance Criteria

	The following table describes the codes for the channel subscriptions and the associated rewards.

#Channel               Reward

	SPORTS             CHAMPIONS_LEAGUE_FINAL_TICKET KIDS N/A
	MUSIC 			   KARAOKE_PRO_MICROPHONE NEWS N/A
	MOVIES 			   PIRATES_OF_THE_CARIBBEAN_COLLECTION

## To run the tests run these commands:

	$ gem install rspec

	$ rspec spec/account_management/rewards_service_spec.rb
