class EmotaController < ApplicationController
  before_action :set_emotum, only: [:show, :edit, :update, :destroy]

  def index
    @emota = Emotum.all
    listener = Listen.to('bin_emota') do |modified, added, removed|
      modified_file if !modified.empty?
      added_file if !added.empty?
      removed_file if !removed.empty?
     # puts "modified absolute path: #{modified}"
     # puts "added absolute path: #{added}"
     # puts "removed absolute path: #{removed}"
    end
    listener.start # not blocking
  end

  def show
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
        format.html { redirect_to @emotum, notice: 'Emotum was successfully created.' }
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
    def modified_file
      puts 'you are in modified file'
    end

    def added_file
      puts 'you are in added file'
    end

    def removed_file
      puts 'you are in removed file'
    end

    def set_emotum
      @emotum = Emotum.find(params[:id])
    end

    def emotum_params
      params.fetch(:emotum, {})
    end
end
