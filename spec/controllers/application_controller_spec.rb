describe ApplicationController do
  describe "Homepage" do
    it 'returns 200 status code when page successfully loads' do
      get '/'
      expect(last_response.status).to eql(200)
    end

    it 'loads the page' do
      get '/'
      expect(last_response.body).to include("Welcome to BookProgress")
    end
  end
end
