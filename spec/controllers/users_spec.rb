# frozen_string_literal: true
require 'rails_helper'

RSpec.describe UsersController do
  def user_params
    {
      email: 'alice@example.com',
      password: 'foobarbaz',
      password_confirmation: 'foobarbaz'
    }
  end

  after(:each) do
    User.delete_all
  end

  describe 'POST signup' do
    before(:each) do
      post :signup, params: { credentials: user_params }, format: :json
    end

    it 'is successful' do
      expect(response).to be_successful
    end

    it 'renders a JSON response' do
      parsed_response = JSON.parse(response.body)
      expect(parsed_response).not_to be_nil
    end
  end

  describe 'POST signin' do
    before(:each) do
      post :signup, params: { credentials: user_params }, format: :json
      post :signin, params: { credentials: user_params }, format: :json
    end

    it 'is successful' do
      expect(response).to be_successful
    end

    it 'renders a JSON response' do
      parsed_response = JSON.parse(response.body)
      expect(parsed_response).not_to be_nil
    end
  end

  context 'when authenticated' do
    before(:each) do
      post :signup, params: { credentials: user_params }, format: :json
      post :signin, params: { credentials: user_params }, format: :json

      @token = JSON.parse(response.body)['user']['token']
      request.env['HTTP_AUTHORIZATION'] = "Token token=#{@token}"

      @user_id = JSON.parse(response.body)['user']['id']
    end

    describe 'PATCH changepw' do
      def new_password_params
        {
          old: 'foobarbaz',
          new: 'foobarbazqux'
        }
      end

      before(:each) do
        patch :changepw,
              params: { id: @user_id, passwords: new_password_params },
              format: :json
      end

      it 'is successful' do
        expect(response).to be_successful
      end

      it 'renders no response body' do
        expect(response.body).to be_empty
      end
    end

    describe 'DELETE signout' do
      before(:each) do
        delete :signout, params: { id: @user_id }, format: :json
      end

      it 'is successful' do
        expect(response).to be_successful
      end

      it 'renders no response body' do
        expect(response.body).to be_empty
      end
    end

    describe 'GET index' do
      before(:each) do
        get :index, format: :json
      end

      it 'is successful' do
        expect(response).to be_successful
      end

      it 'renders a JSON response' do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response).not_to be_nil
      end
    end

    describe 'GET show' do
      before(:each) do
        get :index, params: { id: @user_id }, format: :json
      end

      it 'is successful' do
        expect(response).to be_successful
      end

      it 'renders a JSON response' do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response).not_to be_nil
      end
    end
  end
end
