class ChargesController < ApplicationController
  before_action :set_charge, only: [:show, :edit, :update, :destroy]
  before_action :load_card

  # GET /charges
  # GET /charges.json
  def index
    @charges = @card.charges.all
  end

  # GET /charges/1
  # GET /charges/1.json
  def show
  end

  # GET /charges/new
  def new
    @charge = @card.charges.new
  end

  # GET /charges/1/edit
  def edit
  end

  # POST /charges
  # POST /charges.json
  def create
    stripe_charge = @card.charge(params[:amount], params[:charge][:description])
    @charge = @card.charges.new(charge_params)
    @charge.stripe_token = stripe_charge[:id]

    respond_to do |format|
      if @charge.save
        format.html { redirect_to user_card_charge_path(@card.user, @card.id, @charge.id), notice: 'Charge was successfully created.' }
        format.json { render action: 'show', status: :created, location: @charge }
      else
        format.html { render action: 'new' }
        format.json { render json: @charge.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /charges/1
  # PATCH/PUT /charges/1.json
  def update
    respond_to do |format|
      if @charge.update(charge_params)
        format.html { redirect_to @charge, notice: 'Charge was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @charge.errors, status: :unprocessable_entity }
      end
    end
  end

  def refund
    @charge = Charge.find(params[:charge_id])
    response = @charge.refund
    @charge.refunded = response["refunded"]
    @charge.save
    if response["refunded"]
      redirect_to user_card_charge_path(@card.user, @card.id, @charge.id), notice: 'Charge was successfully refunded.'
    else
      raise Exception.new(response.to_s)
    end

  end

  # DELETE /charges/1
  # DELETE /charges/1.json
  def destroy
    @charge.destroy
    respond_to do |format|
      format.html { redirect_to charges_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_charge
      @charge = Charge.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def charge_params
      params.require(:charge).permit(:card_id, :stripe_token, :description, :refunded)
    end

  def load_card
    @card = Card.find(params[:card_id])
    @user = @card.user
  end
end
