# frozen_string_literal: true

require 'rails_helper'
require 'support/json_helper'

RSpec.describe LessonsController, type: :controller do
  describe "#index" do
    subject { get :index }

    let!(:lessons){ create_list(:lesson, 5) }

    it 'responds with 200' do
      expect(response).to be_ok
    end

    it "returns all the lessons" do
      subject
      expect(json_response.size).to eq(5)
      expect(json_response.first[:id]).to be_in(lessons.map(&:id))
    end
  end

  describe "#create" do
    subject { post(:create, params: { lesson: params }) }

    let(:params) do
      {
        title: title,
        description: description
      }
    end
    let(:title) { Faker::Lorem.word }
    let(:description) { Faker::DrWho.quote.first(300) }

    it "returns a 201" do
      subject
      expect(response).to be_created
    end

    it "returns the new lesson" do
      subject
      expect(json_response[:id]).not_to be_blank
    end

    it "creates the lesson" do
      expect{ subject }.to change(Lesson, :count).by(1)
    end
  end

  describe "#show" do
    subject { get(:show, params: { id: id }) }
    let(:lesson) { create(:lesson) }

    context "if the id exists" do
      let(:id) { lesson.id }

      it "returns a 200" do
        subject
        expect(response).to be_ok
      end
    end
  end
end
