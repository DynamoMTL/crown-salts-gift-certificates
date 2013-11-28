class BankAccountsController < ApplicationController
  before_action :set_bank_account, only: [:show, :edit, :update, :destroy]
  before_action :load_user

  # GET /bank_accounts
  # GET /bank_accounts.json
  def index
    @bank_accounts = @user.bank_accounts.all
  end

  # GET /bank_accounts/1
  # GET /bank_accounts/1.json
  def show
  end

  # GET /bank_accounts/new
  def new
    @bank_account = @user.bank_accounts.new
  end

  # GET /bank_accounts/1/edit
  def edit
  end

  # POST /bank_accounts
  # POST /bank_accounts.json
  def create
    @bank_account = @user.bank_accounts.new(bank_account_params)
    begin
      bank_account_result = @bank_account.stripe_create(
          params[:temp_token],
      )

      if bank_account_result[:active_account]
        recipient_id = bank_account_result[:id]
        bank_account_id = bank_account_result[:active_account][:id]
        @bank_account.stripe_token = bank_account_id
        @user.stripe_recipient_token = recipient_id
      else
        @stripe_errors = "Identity not verified"
      end
    rescue => e
      @stripe_errors = e.message
    end

    respond_to do |format|
      if !@stripe_errors && @user.save && @bank_account.save
        format.html { redirect_to user_bank_account_path(@user, @bank_account), notice: 'Bank account was successfully created.' }
        format.json { render action: 'show', status: :created, location: @bank_account }
      else
        format.html { render action: 'new' }
        format.json { render json: @bank_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bank_accounts/1
  # PATCH/PUT /bank_accounts/1.json
  def update
    respond_to do |format|
      if @bank_account.update(bank_account_params)
        format.html { redirect_to @bank_account, notice: 'Bank account was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @bank_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bank_accounts/1
  # DELETE /bank_accounts/1.json
  def destroy
    @bank_account.destroy
    respond_to do |format|
      format.html { redirect_to bank_accounts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bank_account
      @bank_account = BankAccount.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bank_account_params
      params.require(:bank_account).permit(:user_id, :stripe_token, :description, :name)
    end

    def load_user
      @user = User.find(params[:user_id])
    end
end
