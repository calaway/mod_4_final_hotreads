require 'rails_helper'

RSpec.describe Api::V1::ReadsController, type: :controller do
  context "api/v1/reads#create" do
    it "saves the read" do
      link_count = Link.count
      read_count = Read.count
      post :create, params: {url: "http://example.com"}
      link = Link.last

      expect(response).to have_http_status(:success)
      expect(Link.count).to eq(link_count + 1)
      expect(Read.count).to eq(read_count + 1)
      expect(link.url).to eq("http://example.com")
      expect(link.reads.count).to eq(1)

      post :create, params: {url: "http://example.com"}

      expect(Link.count).to eq(link_count + 1)
      expect(Read.count).to eq(read_count + 2)
      expect(link.reads.count).to eq(2)
    end
  end
end
