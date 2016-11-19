require 'rails_helper'

RSpec.describe RecipesController, type: :controller do
  let(:user) { create(:user) }
  let(:recipe_attrs) { attributes_for(:recipe) }

  describe 'POST #create' do
    it 'create recipe' do
      sign_in user
      expect {
        post :create, recipe: recipe_attrs, format: :json
      }.to change(Recipe, :count).by(1)
      expect(json_response['title']).to eq(recipe_attrs[:title])
      expect(json_response['description']).to eq(recipe_attrs[:description])
    end

    it 'return errors' do
      sign_in user
      post :create, recipe: {title: ''}, format: :json
      expect(json_response_error.length).to eq(6)
    end

    it 'return 401' do
      post :create, recipe: recipe_attrs, format: :json
      assert_401
    end
  end
end
