require 'rails_helper'

RSpec.describe JsonWebTokenService do
  describe '.encode' do
    let(:payload) { { user_id: 1 } }
    let(:token) { JsonWebTokenService.encode(payload) }

    it 'encodes a payload into a JWT token' do
      expect(token).to be_a(String)
    end
  end

  describe '.decode' do
    let(:payload) { { user_id: 1 } }
    let(:token) { JsonWebTokenService.encode(payload) }

    it 'decodes a JWT token into a payload' do
      decoded_payload = JsonWebTokenService.decode(token)
      expect(decoded_payload[:user_id]).to eq(1)
    end
  end
end
