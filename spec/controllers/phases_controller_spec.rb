# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PhasesController, type: :controller do
  before do
    sign_in user
  end
  describe '#index' do
    context 'when the user is admin' do
      let(:user) { FactoryGirl.create(:admin) }
      let(:lead) { FactoryGirl.create(:lead, user_id: user.id) }
      it 'allow admin to view all phase' do
        get :index, params: { lead_id: lead.id }
        expect(response).to have_http_status(200)
        expect(response).to render_template 'index'
      end
    end
    context 'when the user is business_developer' do
      let(:user) { FactoryGirl.create(:business_developer) }
      let(:lead) { FactoryGirl.create(:lead, user_id: user.id) }
      it 'allow business_developer to view all requests' do
        get :index, params: { lead_id: lead.id }
        expect(response).to have_http_status(200)
        expect(response).to render_template 'index'
      end
    end
    context 'when the user is manager' do
      let(:user) { FactoryGirl.create(:manager) }
      let(:lead) { FactoryGirl.create(:lead, user_id: user.id) }
      it 'allow manager to view all requests' do
        get :index, params: { lead_id: lead.id }
        expect(response).to have_http_status(200)
        expect(response).to render_template 'index'
      end
    end
    context 'when the user is engineer' do
      let(:user) { FactoryGirl.create(:engineer) }
      let(:lead) { FactoryGirl.create(:lead, user_id: user.id) }
      it 'allow engineer  to view all requests' do
        get :index, params: { lead_id: lead.id }
        expect(response).to have_http_status(200)
        expect(response).to render_template 'index'
      end
    end
  end
  describe '#new' do
    context 'when the user is admin' do
      let(:user) { FactoryGirl.create(:admin) }
      let(:lead) { FactoryGirl.create(:lead, user_id: user.id) }
      it 'allow admin to create new phase' do
        get :new, params: { lead_id: lead.id }
        expect(response).to have_http_status(200)
        expect(response).to render_template 'new'
      end
    end
    context 'when the user is Bussiness Developer' do
      let(:user) { FactoryGirl.create(:business_developer) }
      let(:lead) { FactoryGirl.create(:lead, user_id: user.id) }
      it 'allow Bussiness Developer to create new phase' do
        get :new, params: { lead_id: lead.id }
        expect(response).to have_http_status(200)
        expect(response).to render_template 'new'
      end
    end
    context 'when the user is Manager' do
      let(:user) { FactoryGirl.create(:manager) }
      let(:lead) { FactoryGirl.create(:lead, user_id: user.id) }
      it 'do not allow Manager to create new phase' do
        get :new, params: { lead_id: lead.id }
        expect(flash[:error]).to eq('translation missing: en.pundit.You are not authorize to do this action')
      end
    end
    context 'when the user is Engineer' do
      let(:user) { FactoryGirl.create(:engineer) }
      let(:lead) { FactoryGirl.create(:lead, user_id: user.id) }
      it 'do not allow engineer to create new phase' do
        get :new, params: { lead_id: lead.id }
        expect(flash[:error]).to eq('translation missing: en.pundit.You are not authorize to do this action')
      end
    end
  end

  describe '#create' do
    context 'when the user is admin' do
      let(:user) { FactoryGirl.create(:admin) }
      let(:lead) { FactoryGirl.create(:lead, user_id: user.id) }
      it 'allow admin to create phase' do
        phase = attributes_for(:phase, user_id: user.id, lead_id: lead.id)
        post :create, params: { lead_id: lead.id, phase: phase }
        expect(flash['notice']).to eq('Phase add successfully')
      end
      it 'raise error while creating phase' do
        phase = attributes_for(:phase, name: nil, user_id: user.id, lead_id: lead.id)
        post :create, params: { lead_id: lead.id, phase: phase }
        expect(flash[:error]).to be_present
        expect(response).to render_template 'new'
      end
    end
    context 'when the user is Bussiness Developer' do
      let(:user) { FactoryGirl.create(:business_developer) }
      let(:lead) { FactoryGirl.create(:lead, user_id: user.id) }
      it 'allow Bussiness Developer to create phase' do
        phase = attributes_for(:phase, user_id: user.id, lead_id: lead.id)
        post :create, params: { lead_id: lead.id, phase: phase }
        expect(flash['notice']).to eq('Phase add successfully')
      end
      it 'raise error while creating phase' do
        phase = attributes_for(:phase, name: nil, user_id: user.id, lead_id: lead.id)
        post :create, params: { lead_id: lead.id, phase: phase }
        expect(flash[:error]).to be_present
        expect(response).to render_template 'new'
      end
    end
    context 'when the user is Manager' do
      let(:user) { FactoryGirl.create(:manager) }
      let(:lead) { FactoryGirl.create(:lead, user_id: user.id) }
      it 'do not allow Manager to create request' do
        phase = attributes_for(:phase, user_id: user.id, lead_id: lead.id)
        post :create, params: { lead_id: lead.id, phase: phase }
        expect(flash[:error]).to eq('translation missing: en.pundit.You are not authorize to do this action')
      end
    end
    context 'when the user is Engineer' do
      let(:user) { FactoryGirl.create(:engineer) }
      let(:lead) { FactoryGirl.create(:lead, user_id: user.id) }
      it 'do not allow engineer to create phase' do
        phase = attributes_for(:phase, user_id: user.id, lead_id: lead.id)
        post :create, params: { lead_id: lead.id, phase: phase }
        expect(flash[:error]).to eq('translation missing: en.pundit.You are not authorize to do this action')
      end
    end
  end

  describe '#destroy' do
    context 'when the user is admin' do
      let(:user) { FactoryGirl.create(:admin) }
      let(:lead) { FactoryGirl.create(:lead, user_id: user.id) }
      let(:phase) { FactoryGirl.create(:phase, user_id: user.id, lead_id: lead.id) }
      it 'allow admin to delete phase' do
        delete :destroy, params: { lead_id: lead.id, id: phase.id }
        expect(flash[:notice]).to eq('Phase remove successfully')
      end
    end
    context 'when the user is Bussiness Developer' do
      let(:user) { FactoryGirl.create(:business_developer) }
      let(:lead) { FactoryGirl.create(:lead, user_id: user.id) }
      let(:phase) { FactoryGirl.create(:phase, user_id: user.id, lead_id: lead.id) }
      it 'allow Bussiness Developer to delete phase' do
        delete :destroy, params: { lead_id: lead.id, id: phase.id }
        expect(flash[:notice]).to eq('Phase remove successfully')
      end
    end
    context 'when the user is Manager' do
      let(:user) { FactoryGirl.create(:manager) }
      let(:lead) { FactoryGirl.create(:lead, user_id: user.id) }
      let(:phase) { FactoryGirl.create(:phase, user_id: user.id, lead_id: lead.id) }
      it 'do not allow Manager to delete request' do
        delete :destroy, params: { lead_id: lead.id, id: phase.id }
        expect(flash[:error]).to eq('translation missing: en.pundit.You are not authorize to do this action')
      end
    end
    context 'when the user is Engineer' do
      let(:user) { FactoryGirl.create(:engineer) }
      let(:lead) { FactoryGirl.create(:lead, user_id: user.id) }
      let(:phase) { FactoryGirl.create(:phase, user_id: user.id, lead_id: lead.id) }
      it 'do not allow engineer to delete request' do
        delete :destroy, params: { lead_id: lead.id, id: phase.id }
        expect(flash[:error]).to eq('translation missing: en.pundit.You are not authorize to do this action')
      end
    end
  end

  describe '#edit' do
    context 'when the user is admin' do
      let(:user) { FactoryGirl.create(:admin) }
      let(:lead) { FactoryGirl.create(:lead, user_id: user.id) }
      let(:phase) { FactoryGirl.create(:phase, user_id: user.id, lead_id: lead.id) }
      it 'allow admin to edit phase' do
        get :edit, params: { lead_id: lead.id, id: phase.id }
        expect(response).to have_http_status(200)
        expect(response).to render_template 'edit'
      end
    end
    context 'when the user is Bussiness Developer' do
      let(:user) { FactoryGirl.create(:business_developer) }
      let(:lead) { FactoryGirl.create(:lead, user_id: user.id) }
      let(:phase) { FactoryGirl.create(:phase, user_id: user.id, lead_id: lead.id) }
      it 'allow Bussiness Developer to edit phase' do
        get :edit, params: { lead_id: lead.id, id: phase.id }
        expect(response).to have_http_status(200)
        expect(response).to render_template 'edit'
      end
    end
    context 'when the user is Manager' do
      let(:user) { FactoryGirl.create(:manager) }
      let(:lead) { FactoryGirl.create(:lead, user_id: user.id) }
      let(:phase) { FactoryGirl.create(:phase, user_id: user.id, lead_id: lead.id) }
      it 'do not allow Manager to edit request' do
        get :edit, params: { lead_id: lead.id, id: phase.id }
        expect(flash[:error]).to eq('translation missing: en.pundit.You are not authorize to do this action')
      end
    end
    context 'when the user is Engineer' do
      let(:user) { FactoryGirl.create(:engineer) }
      let(:lead) { FactoryGirl.create(:lead, user_id: user.id) }
      let(:phase) { FactoryGirl.create(:phase, user_id: user.id, lead_id: lead.id) }
      it 'do not allow engineer to edit request' do
        get :edit, params: { lead_id: lead.id, id: phase.id }
        expect(flash[:error]).to eq('translation missing: en.pundit.You are not authorize to do this action')
      end
    end
  end

  describe '#update' do
    context 'when the user is admin' do
      let(:user) { FactoryGirl.create(:admin) }
      let(:lead) { FactoryGirl.create(:lead, user_id: user.id) }
      let(:phase) { FactoryGirl.create(:phase, user_id: user.id, lead_id: lead.id) }
      it 'allow admin to update phase' do
        post :update, params: { lead_id: lead.id, id: phase.id, phase: attributes_for(:phase) }
        expect(flash[:notice]).to be_present
      end
      it 'raise error while updating phase' do
        post :update, params: { lead_id: lead.id, id: phase.id, phase: attributes_for(:phase, name: nil) }
        expect(flash[:error]).to eq("Phase not update successfully  Name can't be blank")
        expect(response).to render_template 'edit'
      end
    end
    context 'when the user is Bussiness Developer' do
      let(:user) { FactoryGirl.create(:business_developer) }
      let(:lead) { FactoryGirl.create(:lead, user_id: user.id) }
      let(:phase) { FactoryGirl.create(:phase, user_id: user.id, lead_id: lead.id) }
      it 'allow Bussiness Developer to update phase' do
        post :update, params: { lead_id: lead.id, id: phase.id, phase: attributes_for(:phase) }
        expect(flash[:notice]).to be_present
      end
      it 'raise error while updating phase' do
        post :update, params: { lead_id: lead.id, id: phase.id, phase: attributes_for(:phase, name: nil) }
        expect(flash[:error]).to eq("Phase not update successfully  Name can't be blank")
        expect(response).to render_template 'edit'
      end
    end
    context 'when the user is Manager' do
      let(:user) { FactoryGirl.create(:manager) }
      let(:lead) { FactoryGirl.create(:lead, user_id: user.id) }
      let(:phase) { FactoryGirl.create(:phase, user_id: user.id, lead_id: lead.id) }
      it 'do not allow Manager to update request' do
        post :update, params: { lead_id: lead.id, id: phase.id, phase: phase }
        expect(flash[:error]).to eq('translation missing: en.pundit.You are not authorize to do this action')
      end
    end
    context 'when the user is Engineer' do
      let(:user) { FactoryGirl.create(:engineer) }
      let(:lead) { FactoryGirl.create(:lead, user_id: user.id) }
      let(:phase) { FactoryGirl.create(:phase, user_id: user.id, lead_id: lead.id) }
      it 'do not allow engineer to update request' do
        post :update, params: { lead_id: lead.id, id: phase.id, phase: phase }
        expect(flash[:error]).to eq('translation missing: en.pundit.You are not authorize to do this action')
      end
    end
  end

  describe '#status' do
    context 'when the user is admin' do
      let(:user) { FactoryGirl.create(:admin) }
      let(:lead) { FactoryGirl.create(:lead, user_id: user.id) }
      let(:phase) { FactoryGirl.create(:phase, user_id: user.id, lead_id: lead.id) }
      let(:request) { FactoryGirl.create(:request, user_id: user.id, phase_id: phase.id) }
      it 'allow admin to update status' do
        get :status, params: { phase_id: phase.id }
        expect(response).to have_http_status(200)
      end
    end

    context 'when the user is Bussiness Developer' do
      let(:user) { FactoryGirl.create(:business_developer) }
      let(:lead) { FactoryGirl.create(:lead, user_id: user.id) }
      let(:phase) { FactoryGirl.create(:phase, user_id: user.id, lead_id: lead.id) }
      let(:request) { FactoryGirl.create(:request, user_id: user.id, phase_id: phase.id) }
      it 'allow Bussiness Developer to update  status' do
        get :status, params: { phase_id: phase.id }
        expect(response).to have_http_status(200)
      end
    end

    context 'when the user is Manager' do
      let(:user) { FactoryGirl.create(:manager) }
      let(:lead) { FactoryGirl.create(:lead, user_id: user.id) }
      let(:phase) { FactoryGirl.create(:phase, user_id: user.id, lead_id: lead.id) }
      let(:request) { FactoryGirl.create(:request, user_id: user.id, phase_id: phase.id) }
      it 'do not allow Manager to update  status' do
        get :status, params: { phase_id: phase.id }
        expect(response).to have_http_status(200)
      end
    end

    context 'when the user is Engineer' do
      let(:user) { FactoryGirl.create(:engineer) }
      let(:lead) { FactoryGirl.create(:lead, user_id: user.id) }
      let(:phase) { FactoryGirl.create(:phase, user_id: user.id, lead_id: lead.id) }
      let(:request) { FactoryGirl.create(:request, user_id: user.id, phase_id: phase.id) }
      it 'do not allow engineer to update status' do
        get :status, params: { phase_id: phase.id }
        expect(flash[:error]).to eq('translation missing: en.pundit.You are not authorize to do this action')
      end
    end
  end

  describe 'post #status' do
    context 'when the user is admin' do
      let(:user) { FactoryGirl.create(:admin) }
      let(:lead) { FactoryGirl.create(:lead, user_id: user.id) }
      let(:phase) { FactoryGirl.create(:phase, user_id: user.id, lead_id: lead.id) }
      it 'allow admin to update phase status' do
        post :status, params: { phase_id: phase.id,
                                phase: attributes_for(:phase, user_id: user.id, lead_id: lead.id, status: 'completed') }
        expect(flash[:notice]).to eq('Phase status change successfully')
      end
    end

    context 'when the user is Bussiness Developer' do
      let(:user) { FactoryGirl.create(:business_developer) }
      let(:lead) { FactoryGirl.create(:lead, user_id: user.id) }
      let(:phase) { FactoryGirl.create(:phase, user_id: user.id, lead_id: lead.id) }
      it 'allow Bussiness Developer to update phase status' do
        post :status, params: { phase_id: phase.id,
                                phase: attributes_for(:phase, user_id: user.id, lead_id: lead.id, status: 'completed') }
        expect(flash[:notice]).to eq('Phase status change successfully')
      end
    end

    context 'when the user is Manager' do
      let(:user) { FactoryGirl.create(:manager) }
      let(:lead) { FactoryGirl.create(:lead, user_id: user.id) }
      let(:phase) { FactoryGirl.create(:phase, user_id: user.id, lead_id: lead.id) }
      let(:request) { FactoryGirl.create(:request, user_id: user.id, phase_id: phase.id) }
      it 'do not allow Manager to update phase status' do
        post :status, params: { phase_id: phase.id,
                                phase: attributes_for(:phase, user_id: user.id, lead_id: lead.id, status: 'completed') }
        expect(flash[:notice]).to eq('Phase status change successfully')
      end
    end

    context 'when the user is Engineer' do
      let(:user) { FactoryGirl.create(:engineer) }
      let(:lead) { FactoryGirl.create(:lead, user_id: user.id) }
      let(:phase) { FactoryGirl.create(:phase, user_id: user.id, lead_id: lead.id) }
      let(:request) { FactoryGirl.create(:request, user_id: user.id, phase_id: phase.id) }
      it 'do not allow engineer to update phase status' do
        post :status, params: { phase_id: phase.id,
                                phase: attributes_for(:phase, user_id: user.id, lead_id: lead.id, status: 'completed') }
        expect(flash[:error]).to eq('translation missing: en.pundit.You are not authorize to do this action')
      end
    end
  end
  describe '#accept' do
    context 'when the user is admin' do
      let(:user) { FactoryGirl.create(:admin) }
      let(:lead) { FactoryGirl.create(:lead, user_id: user.id) }
      let(:phase) { FactoryGirl.create(:phase, user_id: user.id, lead_id: lead.id) }
      let(:request) { FactoryGirl.create(:request, user_id: user.id, phase_id: phase.id) }
      it 'do not allow admin to accept request' do
        get :accept, params: { phase_id: phase.id, id: user.id }
        expect(flash[:error]).to eq('translation missing: en.pundit.You are not authorize to do this action')
      end
    end

    context 'when the user is Bussiness Developer' do
      let(:user) { FactoryGirl.create(:business_developer) }
      let(:lead) { FactoryGirl.create(:lead, user_id: user.id) }
      let(:phase) { FactoryGirl.create(:phase, user_id: user.id, lead_id: lead.id) }
      let(:request) { FactoryGirl.create(:request, user_id: user.id, phase_id: phase.id) }
      it 'do not allow Bussiness Developer to accept request' do
        get :accept, params: { phase_id: phase.id, id: user.id }
        expect(flash[:error]).to eq('translation missing: en.pundit.You are not authorize to do this action')
      end
    end

    context 'when the user is Manager' do
      let(:user) { FactoryGirl.create(:manager) }
      let(:lead) { FactoryGirl.create(:lead, user_id: user.id) }
      let(:phase) { FactoryGirl.create(:phase, user_id: user.id, lead_id: lead.id) }
      let(:request) { FactoryGirl.create(:request, user_id: user.id, phase_id: phase.id) }
      it 'allow manager to accept request' do
        get :accept, params: { phase_id: phase.id, id: user.id, request: request }
        expect(flash[:notice]).to eq('You are successfully added in to a lead. Please login for Confirmation')
      end
    end

    context 'when the user is Engineer' do
      let(:user) { FactoryGirl.create(:engineer) }
      let(:lead) { FactoryGirl.create(:lead, user_id: user.id) }
      let(:phase) { FactoryGirl.create(:phase, user_id: user.id, lead_id: lead.id) }
      let(:request) { FactoryGirl.create(:request, user_id: user.id, phase_id: phase.id) }
      it 'do not allow engineer to accept request' do
        get :accept, params: { phase_id: phase.id, id: user.id }
        expect(flash[:error]).to eq('translation missing: en.pundit.You are not authorize to do this action')
      end
    end
  end
  describe 'get#reject' do
    context 'when the user is admin' do
      let(:user) { FactoryGirl.create(:admin) }
      let(:lead) { FactoryGirl.create(:lead, user_id: user.id) }
      let(:phase) { FactoryGirl.create(:phase, user_id: user.id, lead_id: lead.id) }
      let(:request) { FactoryGirl.create(:request, user_id: user.id, phase_id: phase.id) }
      it 'do not allow admin to reject request' do
        get :reject, params: { phase_id: phase.id, id: user.id, request: request }
        expect(flash[:error]).to eq('translation missing: en.pundit.You are not authorize to do this action')
      end
    end

    context 'when the user is Bussiness Developer' do
      let(:user) { FactoryGirl.create(:business_developer) }
      let(:lead) { FactoryGirl.create(:lead, user_id: user.id) }
      let(:phase) { FactoryGirl.create(:phase, user_id: user.id, lead_id: lead.id) }
      let(:request) { FactoryGirl.create(:request, user_id: user.id, phase_id: phase.id) }
      it 'do not allow Bussiness Developer to reject request' do
        get :reject, params: { phase_id: phase.id, id: user.id }
        expect(flash[:error]).to eq('translation missing: en.pundit.You are not authorize to do this action')
      end
    end

    context 'when the user is Manager' do
      let(:user) { FactoryGirl.create(:manager) }
      let(:lead) { FactoryGirl.create(:lead, user_id: user.id) }
      let(:phase) { FactoryGirl.create(:phase, user_id: user.id, lead_id: lead.id) }
      let(:request) { FactoryGirl.create(:request, user_id: user.id, phase_id: phase.id) }
      it 'allow manager to reject request' do
        get :reject, params: { phase_id: phase.id, id: user.id }
        expect(response).to have_http_status(302)
      end
    end

    context 'when the user is Engineer' do
      let(:user) { FactoryGirl.create(:engineer) }
      let(:lead) { FactoryGirl.create(:lead, user_id: user.id) }
      let(:phase) { FactoryGirl.create(:phase, user_id: user.id, lead_id: lead.id) }
      let(:request) { FactoryGirl.create(:request, user_id: user.id, phase_id: phase.id) }
      it 'do not allow engineer to reject request' do
        get :reject, params: { phase_id: phase.id, id: user.id }
        expect(flash[:error]).to eq('translation missing: en.pundit.You are not authorize to do this action')
      end
    end
  end
  describe 'post#reject' do
    context 'when the user is admin' do
      let(:user) { FactoryGirl.create(:admin) }
      let(:lead) { FactoryGirl.create(:lead, user_id: user.id) }
      let(:phase) { FactoryGirl.create(:phase, user_id: user.id, lead_id: lead.id) }
      let(:request) { FactoryGirl.create(:request, user_id: user.id, phase_id: phase.id) }
      it 'do not allow admin to reject request' do
        post :reject, params: { phase_id: phase.id, id: user.id, request: request, text: 'dadwda' }
        expect(flash[:error]).to eq('translation missing: en.pundit.You are not authorize to do this action')
      end
    end

    context 'when the user is Bussiness Developer' do
      let(:user) { FactoryGirl.create(:business_developer) }
      let(:lead) { FactoryGirl.create(:lead, user_id: user.id) }
      let(:phase) { FactoryGirl.create(:phase, user_id: user.id, lead_id: lead.id) }
      let(:request) { FactoryGirl.create(:request, user_id: user.id, phase_id: phase.id) }
      it 'do not allow Bussiness Developer to reject request' do
        post :reject, params: { phase_id: phase.id, id: user.id, request: request, text: 'dadwda' }
        expect(flash[:error]).to eq('translation missing: en.pundit.You are not authorize to do this action')
      end
    end

    context 'when the user is Manager' do
      let(:user) { FactoryGirl.create(:manager) }
      let(:lead) { FactoryGirl.create(:lead, user_id: user.id) }
      let(:phase) { FactoryGirl.create(:phase, user_id: user.id, lead_id: lead.id) }
      let(:request) { FactoryGirl.create(:request, user_id: user.id, phase_id: phase.id) }
      it 'allow manager to reject request' do
        post :reject, params: { phase_id: phase.id, id: user.id, request: request, text: 'dadwda' }
        expect(flash[:notice]).to eq('Thanks')
      end
    end

    context 'when the user is Engineer' do
      let(:user) { FactoryGirl.create(:engineer) }
      let(:lead) { FactoryGirl.create(:lead, user_id: user.id) }
      let(:phase) { FactoryGirl.create(:phase, user_id: user.id, lead_id: lead.id) }
      let(:request) { FactoryGirl.create(:request, user_id: user.id, phase_id: phase.id) }
      it 'do not allow engineer to reject request' do
        post :reject, params: { phase_id: phase.id, id: user.id, request: request, text: 'dadwda' }
        expect(flash[:error]).to eq('translation missing: en.pundit.You are not authorize to do this action')
      end
    end
  end
end
