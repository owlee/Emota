class ConversationsController < ApplicationController

  def index
    @conversations = Conversation.all
  end

  private

  def set_conversation
    @conversation = Conversation.find(params[:id])
  end

  def conversation_params
   # params.permit :name, :on_server, :sent_to_api, :received_from_api, :stored_score, :avatar
  end
end
