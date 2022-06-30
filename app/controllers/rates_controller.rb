class RatesController < ApplicationController
  before_action :set_rate, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  before_action :correct_user, only: %i[ show edit update destroy ]


  # GET /rates or /rates.json
  def index
    @rates = Rate.all

    @fromparam = params[:from_symbol]
    @toparam = params[:to_symbol]

    if params[:fromcurrency] && params[:tocurrency] == ""
        @from_output = "N/A"
        @to_output = "N/A"
        @rate_output = "N/A"
    elsif params[:fromcurrency] && params[:tocurrency]
        require 'net/http'
        require 'json'
        
        @url = "https://api.apilayer.com/fixer/convert?to=#{@toparam}&from=#{@fromparam}&amount=100&apikey=aySd4XJBlaFfw1Z31bKPP8aPX0UrO7LY"
        @uri = URI(@url)
        
        @response = Net::HTTP.get(@uri)
        @currency = JSON.parse(@response)

        if @currency.empty?
          @from_output = "N/A (You need to enter a pair to calculate rate"
          @to_output = "N/A (You need to enter a pair to calculate rate"
          @rate_output = "N/A (You need to enter a pair to calculate rate"
        elsif !@currency
          @from_output = "N/A (You need to enter a pair to calculate rate"
          @to_output = "N/A (You need to enter a pair to calculate rate"
          @rate_output = "N/A (You need to enter a pair to calculate rate"
        else
          @from_output = @currency["query"]["from"]
          @to_output = @currency["query"]["to"]
          @rate_output = @currency["info"]["rate"]
        end


    end

  end

  # GET /rates/1 or /rates/1.json
  def show
  end

  # GET /rates/new
  def new
    @rate = Rate.new
  end

  # GET /rates/1/edit
  def edit
  end

  # POST /rates or /rates.json
  def create
    @rate = Rate.new(rate_params)

    respond_to do |format|
      if @rate.save
        format.html { redirect_to rate_url(@rate), notice: "Rate was successfully created." }
        format.json { render :show, status: :created, location: @rate }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rates/1 or /rates/1.json
  def update
    respond_to do |format|
      if @rate.update(rate_params)
        format.html { redirect_to rate_url(@rate), notice: "Rate was successfully updated." }
        format.json { render :show, status: :ok, location: @rate }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rates/1 or /rates/1.json
  def destroy
    @rate.destroy

    respond_to do |format|
      format.html { redirect_to rates_url, notice: "Rate was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rate
      @rate = Rate.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def rate_params
      params.require(:rate).permit(:from_symbol, :to_symbol, :rate_symbol, :user_id)
    end
    def correct_user
      @correct = current_user.rates.find_by(id: params[:id])
      redirect_to rates_path, notice: "You are not authorized" if @correct.nil?
    end
end
