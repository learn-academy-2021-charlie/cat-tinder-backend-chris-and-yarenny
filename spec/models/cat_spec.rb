require 'rails_helper'

RSpec.describe Cat, type: :request do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe "GET /index" do
    it "gets a list of cats" do
      Cat.create name:'Sam', age: 55, enjoys: 'eating'
      get '/cats'
      cat = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(cat.length).to eq 1
    end
  end
  describe "POST /create" do
    it "creates a cat" do
      cat_params = {
        cat: {
          name: 'sam',
          age: 55,
          enjoys: 'meowing'
        }
      }
      post '/cats', params: cat_params
      new_cat = Cat.first
      expect(response).to have_http_status(200)
      expect(new_cat.name).to eq 'sam'
    end
  end
  describe "PATCH /update" do
    it "updates a cat" do
      cat_params = {
        cat: {
          name: 'sam',
          age: 55,
          enjoys: 'meowing'
        }
      }
      post '/cats', params: cat_params
      updated_cat_params = {
        cat: {
          name: 'sam',
          age: 66,
          enjoys: 'meowing'
        }
      }
      cat = Cat.first
      patch "/cats/#{cat.id}", params: updated_cat_params
      updated_cat = Cat.find(cat.id)
      expect(response).to have_http_status(200)
      expect(updated_cat.age).to eq 66
    end
  end
  describe "DELETE /destroy" do
    it "deletes a cat" do
      cat_params = {
        cat: {
          name: 'sam',
          age: 55,
          enjoys: 'meowing'
        }
      }
      post "/cats", params: cat_params
      cat = Cat.first
      delete "/cats/#{cat.id}"
      expect(response).to have_http_status(200)
      cats = Cat.all
      expect(cats).to be_empty
    end
  end
end
