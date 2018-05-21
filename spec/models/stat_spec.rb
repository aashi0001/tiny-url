require 'rails_helper'

RSpec.describe Stat, type: :model do
    let!(:stats) { build(:stat) }


	  context "it validate the Link Object" do
	    
	    it "Link id should not be nil " do
	     
	     expect(stats.link_id).not_to be_nil
	    end

	    it "stat platform should not be nil " do
	     expect(stats.platform).not_to be_nil
	    end

	    it "stat ip_address should not be nil " do
	    expect(stats.ip_address).not_to be_nil
	    end

	  end
end
