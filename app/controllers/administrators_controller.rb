class AdministratorsController < ApplicationController
  include AccountAccess
  
  before_action :set_administrator, only: [:show, :edit, :update, :destroy]
  

  # GET /administrators
  # GET /administrators.json
  def index
    @administrators = Administrator.all
  end

  # GET /administrators/1
  # GET /administrators/1.json
  def show    
    if current_user_pending?
      redirect_to edit_administrator_path(@administrator)
    end
  end

  # GET /administrators/new
  def new
    set_account    
    @administrator = @account.administrators.build    
  end

  # GET /administrators/1/edit
  def edit
    if current_user_pending?
      render :edit_pending
    end
  end

  # POST /administrators
  # POST /administrators.json
  def create
    
    set_account
    @administrator = @account.administrators.build(administrator_params)

    respond_to do |format|
      if @administrator.save
        format.html { redirect_to @account, notice: 'Account admin was successfully created.' }
        format.json { render action: 'show', status: :created, location: @administrator }
      else
        format.html { render action: 'new' }
        format.json { render json: @administrator.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    if @administrator.status_as_key == :pending
      if params[:administrator][:accept]
        @administrator.accept_invitation! 
        redirect_to @administrator, notice: 'You have accepted the invitation. Now check your details are correct.'
      elsif params[:administrator][:decline]
        @administrator.decline_invitation! 
        redirect_to accounts_path, notice: "You declined the invitation."
      else
        flash[:notice] = "Your response was not recognized. Please try again."
        render :edit_pending
      end
      
    else
    
      respond_to do |format|
        if @administrator.update(administrator_params)
          format.html { redirect_to @administrator, notice: 'Account admin was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @administrator.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /administrators/1
  # DELETE /administrators/1.json
  def destroy
    @administrator.destroy
    respond_to do |format|
      format.html { redirect_to administrators_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_administrator
      @administrator = Administrator.find(params[:id])      
      redirect_to accounts_path, notice: 'You are not authorized to access this administrator' and return unless @administrator && @administrator.accessible_by?(current_user)
      @account = @administrator.account 
            
      redirect_to accounts_path, notice: 'You are not authorized to access this application' and return unless @account.accessible_by?(current_user)
      
      @adminsitrator
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def administrator_params
      params.require(:administrator).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
    
    def current_user_pending?
      @administrator.user == current_user &&  @administrator.status_as_key == :pending
    end
end
