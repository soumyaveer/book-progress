describe ApplicationController do
  describe 'GET /' do
    it 'loads the page with the react app with its placeholder div' do
      get '/'

      expect(last_response.status).to eql(200)
      response_body = last_response.body
      expect(response_body).to include("/dist/main.js")
      expect(response_body).to include("/dist/main.css")
      expect(response_body).to include('id="root"')
    end
  end
end
