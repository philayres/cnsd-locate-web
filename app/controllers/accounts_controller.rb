class AccountsController < ApplicationController
  before_action :requires_authentication, except: [:new, :create]
      
  before_action :set_account, only: [:show, :edit, :update, :destroy]  
  
  StatusLabels = ['Disabled', 'Active', 'On-Hold']
  
  # GET /accounts
  # GET /accounts.json
  def index
    @accounts = Account.all
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
  end

  # GET /accounts/new
  def new
    @account = Account.new    
    @account_admin = @account.account_admins.build
  end

  # GET /accounts/1/edit
  def edit
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new(account_params)
    
    respond_to do |format|
      if @account.save
        format.html { redirect_to @account, notice: 'Account was successfully created.' }
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

    #if account_params[:account_admins_attributes]['0'][:password].blank?
    #  account_params[:account_admins_attributes]['0'].delete('password')
     # account_params[:account_admins_attributes]['0'].delete('password_confirmation')
    #end
    #puts account_params[:account_admins_attributes]['0'].delete_if {|d,v| v.blank?}
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
    # Use callbacks to share common setup or constraints between actions.
    def set_account      
      if params[:id] == 'me' 
        params[:id] = @user.id
      end
        
      if  params[:id] == @user.id        
        @account = Account.find(params[:id])
      else
        @account = nil        
      end
    end

    def account_params
      params.require(:account).permit(:owner_name, account_admins_attributes: [:id, :last_name, :first_name, :email, :password, :password_confirmation])
    end
    
end
