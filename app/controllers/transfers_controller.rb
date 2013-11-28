class TransfersController < ApplicationController
  before_action :set_transfer, only: [:show, :edit, :update, :destroy]
  before_action :load_bank_account

  def cancel
    @transfer = Transfer.find(params[:transfer_id])
    begin
      result = @transfer.cancel
      if result[:status] == "canceled"
        @transfer.status = result[:status]
        @transfer.save
        notice = 'Transfer was successfully cancelled.'
      else
        notice = 'Transfer failed.'
      end
    rescue => e
      notice = e.message
    end

    redirect_to user_bank_account_transfer_path(
                    @user, @bank_account, @transfer
                ),
                notice: notice
  end

  # GET /transfers
  # GET /transfers.json
  def index
    @transfers = @bank_account.transfers.all
  end

  # GET /transfers/1
  # GET /transfers/1.json
  def show
  end

  # GET /transfers/new
  def new
    @transfer = @bank_account.transfers.new
  end

  # GET /transfers/1/edit
  def edit
  end

  # POST /transfers
  # POST /transfers.json
  def create
    @transfer = @bank_account.transfers.new(transfer_params)

    begin
      transfer_result = @transfer.initiate_transfer(params[:amount])
      @transfer.status = transfer_result[:status]
      @transfer.stripe_token = transfer_result[:id]
    rescue => e
      @transfer_error = e.message
    end

    respond_to do |format|
      if !@transfer_error && @transfer.save
        format.html {
          redirect_to user_bank_account_transfer_path(
                          @user, @bank_account, @transfer
                      ),
                      notice: 'Transfer was successfully created.'
        }
        format.json { render action: 'show', status: :created, location: @transfer }
      else
        format.html { render action: 'new' }
        format.json { render json: @transfer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transfers/1
  # PATCH/PUT /transfers/1.json
  def update
    respond_to do |format|
      if @transfer.update(transfer_params)
        format.html { redirect_to @transfer, notice: 'Transfer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @transfer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transfers/1
  # DELETE /transfers/1.json
  def destroy
    @transfer.destroy
    respond_to do |format|
      format.html { redirect_to transfers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transfer
      @transfer = Transfer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transfer_params
      params.require(:transfer).permit(:bank_account_id, :stripe_token, :description, :name, :status)
    end

    def load_bank_account
      @bank_account = BankAccount.find(params[:bank_account_id])
      @user = @bank_account.user
    end
end
