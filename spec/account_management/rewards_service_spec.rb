require "spec_helper"

describe AccountManagement::RewardsService do 
  describe "validates customer rewards" do
    let(:account) { 1234 }
    let(:subscriptions) { ["sports", "kids", "music"] }
    let(:rewards_service) { AccountManagement::RewardsService.new(account, subscriptions) }

    before do
      allow(CustomerStatus::EligibilityService).to receive(:new)
        .and_return(double "EligibilityService", 
          service_output: "CUSTOMER_ELIGIBLE",
          description: "Customer is eligible")  
    end
     
    context "when account is eligible" do
      describe "for a mixture of channels" do
        it "returns rewards for an array of channels" do
          expect(rewards_service.available).to eql ["CHAMPIONS_LEAGUE_FINAL_TICKET", "KARAOKE_PRO_MICROPHONE"]
        end
      end

      describe "only sports channel" do
        let(:subscriptions) { ["sports"] }
        it "returns rewards for sports channel" do
          expect(rewards_service.available).to eql ["CHAMPIONS_LEAGUE_FINAL_TICKET"]
        end
      end

      describe "no rewards channel" do
        let(:subscriptions) { ["kids"] }
        it "returns no rewards" do
          expect(rewards_service.available).to eql []
        end
      end
    end

    context "when a none eligible account is supplied" do
      before do
        allow(CustomerStatus::EligibilityService).to receive(:new)
          .and_return(double "EligibilityService", 
            service_output: "CUSTOMER_INELIGIBLE",
            description: "Customer is not eligible")  
      end

      it "returns the expected ineligibility message" do
        expect(rewards_service.available).to eql "Customer is not eligible"
      end
    end

    context "when there is a technical failure" do
      before do
        allow(CustomerStatus::EligibilityService).to receive(:new)
          .and_return(double "EligibilityService", 
            service_output: "Technical failure exception",
            description: "Service technical failure")  
      end

      it "returns a technical failure message" do
        expect(rewards_service.available).to eql "Service technical failure"
      end
    end

    context "when the supplied account number is invalid" do
      before do
        allow(CustomerStatus::EligibilityService).to receive(:new)
          .and_return(double "EligibilityService", 
            service_output: "Invalid account number exception",
            description: "The supplied account number is invalid")  
      end

      it "returns an invalid account message" do
        expect(rewards_service.available).to eql "The supplied account number is invalid"
      end
    end
  end  
end