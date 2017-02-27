class EmotaController < ApplicationController
  before_action :set_emotum, only: [:show, :edit, :update, :destroy]

  def index
    @emota = Emotum.all
    listener = Listen.to('bin_emota') do |modified, added, removed|
      if !modified.empty? || !added.empty?
        self.response_body = nil
        fileName ||= added.first
        fileName ||= modified.first
        @emotum = Emotum.first_or_create(emotum_params.merge on_server: true, name: fileName)
        respond_to do |format|
          if @emotum
            format.html { redirect_to emota_url, notice: 'Emotum was successfully created.' }
            return
          end
        end
       # redirect_to new_emotum_path
       # flash[:notice] = 'Emotum was successfully created.'
      else
        raise Exception # Something went wrong
      end
    end
    listener.start # not blocking
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
  def process_image modified, added

  end

  def set_emotum
    @emotum = Emotum.find(params[:id])
  end

  def emotum_params
    params.permit :name, :on_server, :sent_to_api, :received_from_api, :stored_score
  end
end
