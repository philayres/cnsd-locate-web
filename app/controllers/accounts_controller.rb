class AccountsController < ApplicationController
  
  include AccountAccess
  
  before_action :authenticate_user!
      
  before_action :set_account, only: [:show, :edit, :update, :destroy]  
  
  StatusLabels = ['Disabled', 'Active', 'On-Hold']
  
  def index
    @accounts = Account.all_for_user current_user
  end

  def show
    
    if @user_status == :pending
      redirect_to edit_administrator_path(@administrator)    
    end    
    
  end

  def new
    @account = Account.new
    @administrator = @account.administrators.build
  end

  def edit
    
    if @user_status == :pending
      redirect_to edit_administrator_path(@administrator)    
    end
  end

  def create
    @account = Account.new(account_params)
    @account.make_current_user_admin current_user
    
    respond_to do |format|
      if @account.save
        format.html { redirect_to edit_administrator_path(@account.administrators.first), notice: 'Application updated. Update your details.' }
        format.json { render action: 'show', status: :created, location: @account }
      else
        format.html { render action: 'new' }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update

    #if account_params[:administrators_attributes]['0'][:password].blank?
    #  account_params[:administrators_attributes]['0'].delete('password')
     # account_params[:administrators_attributes]['0'].delete('password_confirmation')
    #end
    #puts account_params[:administrators_attributes]['0'].delete_if {|d,v| v.blank?}
    res = @account.update!(account_params)     
    
    respond_to do |format|
      if res
        format.html { redirect_to @account, notice: 'Account was successfully updated.' }
        format.json { head :no_content }
      else
        flash[:notice] = "Failed to update"
        format.html { render action: 'edit' }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
      
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    @account.disable
    respond_to do |format|
      format.html { redirect_to accounts_url }
      format.json { head :no_content }
    end
  end

  private


    def account_params
      params.require(:account).permit(:owner_name, administrators_attributes: [:id, :last_name, :first_name, :email, :password, :password_confirmation])
    end
    
end
