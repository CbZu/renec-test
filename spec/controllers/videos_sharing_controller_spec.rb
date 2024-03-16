require 'rails_helper'

RSpec.describe VideosSharingController,  type: :controller do
  describe "GET /videos-sharing", type: :request do
    let(:path) { '/videos-sharing' }
    context 'get shared videos' do
      let!(:video) { create(:video, url: 'https://www.youtube.com') }
      let(:response_body) { JSON.parse(response.body) }
      it 'responses 200' do
        get path

        expect(response).to have_http_status(:ok)
        expect(response_body.first["url"]).to eq 'https://www.youtube.com'
        expect(response_body.first["sharedBy"]).to eq 'default-email'
      end
    end
  end

  describe "POST /videos-sharing", type: :request do
    let(:path) { '/videos-sharing' }
    let(:video_params) do
      {
        url: 'url-dummy'
      }
    end
    let!(:user) { create(:user, email: 'abc@gmail.com', password: 'xyz1') }
    before do
      allow_any_instance_of(ApplicationController).to receive(:authenticate!).and_return(true)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    end

    context 'post shared videos and return status 200' do
      before do
        video_snippet = Google::Apis::YoutubeV3::VideoSnippet.new(
          title: 'title-dummy',
          description: 'description-dummy'
        )
        allow_any_instance_of(VideosSharingController).to receive(:get_youtube_video_info).and_return(video_snippet)
      end

      it 'responses 200' do
        post path, params: video_params

        expect(response).to have_http_status(:ok)
      end
    end

    context 'post shared videos return Can not share video when call youtube api' do
      before do
        allow_any_instance_of(VideosSharingController).to receive(:get_youtube_video_info).and_raise(instance_double(StandardError))
      end
      let(:response_body) { JSON.parse(response.body).with_indifferent_access }

      it 'responses 422' do
        post path, params: video_params

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response_body[:error]).to eq 'Can not share video'
      end
    end
  end
end
