class EmotaController < ApplicationController
  before_action :set_emotum, only: [:show, :edit, :update, :destroy]

  def index
    @emota = Emotum.all.reverse
  end

  def createProgressBar
#    uid = params[:uid]
#    pusher_channel = "signup_process_#{uid}"
#    progress_job Emotum.last, pusher_channel
  end

  def show
    redirect_to emota_path
  end

  def new
    @emotum = Emotum.new
  end

  def edit
  end

  def create
    @emotum = Emotum.new(emotum_params)

    respond_to do |format|
      if @emotum.save
        format.html { redirect_to emota_url, notice: 'Emotum was successfully created.' }
        format.json { render :show, status: :created, location: @emotum }
      else
        format.html { render :new }
        format.json { render json: @emotum.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @emotum.update(emotum_params)
        format.html { redirect_to @emotum, notice: 'Emotum was successfully updated.' }
        format.json { render :show, status: :ok, location: @emotum }
      else
        format.html { render :edit }
        format.json { render json: @emotum.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @emotum.destroy
    respond_to do |format|
      format.html { redirect_to emota_url, notice: 'Emotum was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def progress_job(emotum, pusher_channel)
#    Pusher.trigger(pusher_channel, 'update', {message: "Received photo from the Raspberry Pi", progress: 10 })# if emotum.on_server
#    sleep(3)
#    Pusher.trigger(pusher_channel, 'update', {message: "Sent photo to Microsoft API", progress: 30 })# if emotum.sent_to_api
#    sleep(2)
#    Pusher.trigger(pusher_channel, 'update', {message: "Received score back from Microsft API", progress: 60 })# if emotum.received_from_api
  end

  def set_emotum
    @emotum = Emotum.find(params[:id])
  end

  def emotum_params
    params.permit :name, :on_server, :sent_to_api, :received_from_api, :stored_score, :avatar
  end
end
