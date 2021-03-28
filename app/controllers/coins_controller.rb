class CoinsController < ApplicationController
  before_action :set_coin, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  before_action :correct_user, only: %i[ show edit update destroy ]
  # GET /coins or /coins.json
  def index
    @coins = Coin.all
     require 'net/http'
    require 'json'

    @url = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?CMC_PRO_API_KEY=f20de4a4-9bf9-4a57-bdb0-e68559b87260&start=1&limit=5000&convert=KRW'
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @lookup_coin = JSON.parse(@response)
    @profit_loss = 0
    @invest_total = 0
    @profit_total = 0
    
  end

  # GET /coins/1 or /coins/1.json
  def show
     require 'net/http'
    require 'json'

    @url = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?CMC_PRO_API_KEY=f20de4a4-9bf9-4a57-bdb0-e68559b87260&start=1&limit=5000&convert=KRW'
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @show_coin = JSON.parse(@response)
  end

  # GET /coins/new
  def new
    @coin = Coin.new
  end

  # GET /coins/1/edit
  def edit
  end

  # POST /coins or /coins.json
  def create
    @coin = Coin.new(coin_params)

    respond_to do |format|
      if @coin.save
        format.html { redirect_to @coin, notice: "이 코인 떡상각." }
        format.json { render :show, status: :created, location: @coin }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @coin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /coins/1 or /coins/1.json
  def update
    respond_to do |format|
      if @coin.update(coin_params)
        format.html { redirect_to @coin, notice: "코인정보 갱신완료." }
        format.json { render :show, status: :ok, location: @coin }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @coin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coins/1 or /coins/1.json
  def destroy
    @coin.destroy
    respond_to do |format|
      format.html { redirect_to coins_url, notice: "익절 성공적." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coin
      @coin = Coin.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def coin_params
      params.require(:coin).permit(:symbol, :user_id, :cost_per, :amount_owned)
    end

    def correct_user
    @correct = current_user.coins.find_by(id: params[:id])
    redirect_to coins_path, notice: "이 페이지에 권한이 없습니다." if @correct.nil?
    end


end
