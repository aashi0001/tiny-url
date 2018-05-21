require 'rails_helper'

RSpec.describe LinksController, type: :controller do
   let!(:link) { create(:link)  }	

	describe "LINK #create" do
    context "with valid attributes" do
      
      it "has a 200 status code" do
      	get :index
      	expect(response.status).to eq(200)
      end
      
      it "create new link" do
        post :create, link: attributes_for(:link)
        expect(Link.count).to eq(1)
      end

      it "responds in html format" do
        post :create, link: attributes_for(:link)
        expect(response.content_type).to eq "text/html"
      end

      it "create method takes back to Root Page" do
        post :create, link: attributes_for(:link)
        expect (redirect_to root_url)
      end

      it "shortened method takes back to original url of link" do
        get :shortened, format: link.original_url
        expect (redirect_to link.original_url)
      end


      it "deletes the link" do
	    expect{ 
	       delete :destroy, :id => link
	    }.to change(Link, :count).by(-1)
	  end
     
    end
  end


  describe "PUT update/:id" do
  let(:attr) do 
    { :original_url => 'http://yahoo.com' }
  end

  before(:each) do
  	put :update, :id => link.id, link: attributes_for(:link)
    link.reload
  end

  it { expect(response).to redirect_to(root_path) }
end


end