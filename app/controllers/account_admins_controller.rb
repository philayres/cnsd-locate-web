class AccountAdminsController < ApplicationController
  before_action :set_account_admin, only: [:show, :edit, :update, :destroy]
  

  # GET /account_admins
  # GET /account_admins.json
  def index
    @account_admins = AccountAdmin.all
  end

  # GET /account_admins/1
  # GET /account_admins/1.json
  def show
  end

  # GET /account_admins/new
  def new
    @account_admin = AccountAdmin.new   
  end

  # GET /account_admins/1/edit
  def edit
  end

  # POST /account_admins
  # POST /account_admins.json
  def create
    @account_admin = AccountAdmin.new(account_admin_params)

    respond_to do |format|
      if @account_admin.save
        format.html { redirect_to @account_admin, notice: 'Account admin was successfully created.' }
        format.json { render action: 'show', status: :created, location: @account_admin }
      else
        format.html { render action: 'new' }
        format.json { render json: @account_admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /account_admins/1
  # PATCH/PUT /account_admins/1.json
  def update
    respond_to do |format|
      if @account_admin.update(account_admin_params)
        format.html { redirect_to @account_admin, notice: 'Account admin was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @account_admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /account_admins/1
  # DELETE /account_admins/1.json
  def destroy
    @account_admin.destroy
    respond_to do |format|
      format.html { redirect_to account_admins_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account_admin
      @account_admin = AccountAdmin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_admin_params
      params.require(:account_admin).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end
