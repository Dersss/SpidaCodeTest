require 'rails_helper'

RSpec.describe 'Jobs API', type: :request do
  # initialize test data 
  let!(:jobs) { create_list(:job, 10, requirements: 'Requirements') }
  let(:job_id) { jobs.first.id }

  # Test suite for GET /jobs
  describe 'GET /jobs' do
    # make HTTP get request before each example
    before { get '/jobs' }

    it 'returns jobs' do
      # Note `json` is a custom helper to parse JSON responses
      expect(response.body).not_to be_empty
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /jobs/:id
  describe 'GET /jobs/:id' do
    before { get "/jobs/#{job_id}" }

    context 'when the record exists' do
      it 'returns the job' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(job_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:job_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Job/)
      end
    end
  end

  # Test suite for POST /jobs
  describe 'POST /jobs' do
    # valid payload
    let(:valid_attributes) { { position: 'Ironman', description: 'Test description.', requirements: 'Smart and Rich.' } }

    context 'when the request is valid' do
      before { post '/jobs', params: valid_attributes }

      it 'creates a job' do
        expect(json['position']).to eq('Ironman')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/jobs', params: { position: 'Foobar'} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  # Test suite for PUT /jobs/:id
  describe 'PUT /jobs/:id' do
    let(:valid_attributes) { { position: 'Spiderman', requirements: 'Shoot webs' } }

    context 'when the record exists' do
      before { put "/jobs/#{job_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /jobs/:id
  describe 'DELETE /jobs/:id' do
    before { delete "/jobs/#{job_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end