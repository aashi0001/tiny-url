require 'rails_helper'
require 'open-uri'

RSpec.describe "Links ", type: :model do
    let!(:link) { create(:link)  }


	  context "it validate the Link Object" do
	    
	    it "Link id should not be nil " do
	     expect(link.id).not_to be_nil
	    end

	    it "Link original url should not be nil " do
	     expect(link.original_url).not_to be_nil
	    end

	    it "Link original_url should be unique " do
	     link_with_same_original_url = link.dup
	     link_with_same_original_url.save	
	     expect(link_with_same_original_url).to_not be_valid
	    end

	    it "Link url should match the defined expression" do
	      expect(link.original_url).to match(URI::regexp(%w(http https)))
	    end

	  end
end
