require "spec_helper"

describe AccountManagement::RewardsService do 
  describe "validates customer rewards" do
    let(:account) { 1234 }
    let(:subscriptions) { ["sports", "kids", "music"] }
    let(:rewards_service) { AccountManagement::RewardsService.new(account, subscriptions) }

    before do
      allow(CustomerStatus::EligibilityService).to receive(:new)
        .and_return(double "EligibilityService", 
          output: "CUSTOMER_ELIGIBLE",
          description: "Customer is eligible")  
    end
     
    context "account is eligible" do
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

    context "none eligible account" do
      before do
        allow(CustomerStatus::EligibilityService).to receive(:new)
          .and_return(double "EligibilityService", 
            output: "CUSTOMER_INELIGIBLE",
            description: "Customer is not eligible")  
      end

      it "returns the ineligibility message" do
        expect(rewards_service.available).to eql "Customer is not eligible"
      end
    end
  end  
end