class ConversationsController < ApplicationController

  def index
    respond_to do |format|
      format.json do
        hash, h = Hash.new, Hash.new
        date = params["date"] || '01-01-2001'
        @conversations = Conversation.find_by_date date

        unless @conversations.empty?
          @conversations.each do |conversation|
           hash[conversation.id] = { name:       conversation.name,
                                     start:      conversation.start_date,
                                     end:        conversation.end_date,
                                     duration:   conversation.duration,
                                     mood:       conversation.mood,
                                     deviations: conversation.deviations }
          end
        else
          hash[404] = "Conversations on #{date} were not found"
        end
        h["conversations"] = hash
        render json: h
      end
    end
  end

  def show
    respond_to do |format|
      format.json do
        hash, h = Hash.new, Hash.new
        id = params['id'].to_i || -1
        @conversation = Conversation.where id: id

        unless @conversation.empty?
          @conversation.first.emota.each do |emotum|
            mood = emotum.emotion
            emo = { emotion_id: mood.id,
                    anger:      mood.anger_p,
                    surprised:  mood.surprise_p,
                    contempt:   mood.contempt_p,
                    disgust:    mood.disgust_p,
                    fear:       mood.fear_p,
                    happiness:  mood.happiness_p,
                    neutral:    mood.neutral_p,
                    sadness:    mood.sadness_p,
                    created_at: mood.created_at }
            hash[emotum.id] = emo
          end
        else
          hash[404] = "Record: #{id} is not found"
        end
        h['conversation'] = hash
        render json: h
      end
    end
  end

  private

  def set_conversation
    @conversation = Conversation.find(params[:id])
  end

  def conversation_params
   # params.permit :name, :on_server, :sent_to_api, :received_from_api, :stored_score, :avatar
  end
end
