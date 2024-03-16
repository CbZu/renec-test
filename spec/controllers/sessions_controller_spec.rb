require 'rails_helper'

RSpec.describe SessionsController,  type: :controller do
  describe "POST /login", type: :request do
    let(:path) { '/login' }
    let(:user_params) do
      {
        email: 'abc@gmail.com',
        password: 'xyz'
      }
    end
    let(:jwt_token) { 'jwt_token' }

    before do
      allow(JsonWebTokenService).to receive(:encode).and_return(jwt_token)
    end

    context 'login with existing email and wrong password' do
      let!(:user) { create(:user, email: 'abc@gmail.com', password: 'xyz1') }
      let(:response_body) { JSON.parse(response.body).with_indifferent_access }

      it 'responses 401' do
        post path, params: user_params

        expect(response).to have_http_status(:unauthorized)
        expect(response_body[:error]).to eq 'Wrong password'
      end
    end

    context 'login with existing email and return the token' do
      let!(:user) { create(:user, email: 'abc@gmail.com', password: 'xyz') }
      let(:response_body) { JSON.parse(response.body).with_indifferent_access }

      it 'responses 200' do
        post path, params: user_params

        expect(response).to have_http_status(:ok)
        expect(response_body[:email]).to eq 'abc@gmail.com'
        expect(response_body[:token]).to eq jwt_token
      end
    end

    context 'login with new email and return the token when register successfull' do
      let(:response_body) { JSON.parse(response.body).with_indifferent_access }

      it 'responses 200' do
        post path, params: user_params

        expect(response).to have_http_status(:ok)
        expect(response_body[:email]).to eq 'abc@gmail.com'
        expect(response_body[:token]).to eq jwt_token
      end
    end

    context 'login with new email and return error Can not register when register failed' do
      before do
        user = instance_double(User)
        allow(User).to receive(:new).and_return(user)
        allow(user).to receive(:save).and_return(false)
      end
      let(:response_body) { JSON.parse(response.body).with_indifferent_access }

      it 'responses 422' do
        post path, params: user_params

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response_body[:error]).to eq 'Can not register'
      end
    end

  end
end
