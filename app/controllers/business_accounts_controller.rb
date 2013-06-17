class BusinessAccountsController < ApplicationController
  # GET /business_accounts
  # GET /business_accounts.json
  def index
    redirect_to(new_business_account_path)
  end

  # GET /business_accounts/1
  # GET /business_accounts/1.json
  def show
    @business_account = BusinessAccount.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @business_account }
    end
  end

  # GET /business_accounts/new
  # GET /business_accounts/new.json
  def new
    @business_account = BusinessAccount.new
      respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @business_account }
    end
  end

  # # GET /business_accounts/1/edit
  # def edit
  #   @business_account = BusinessAccount.find(params[:id])
  # end

  # # POST /business_accounts
  # # POST /business_accounts.json
  def create
    @business_account = BusinessAccount.new(params[:business_account])

    respond_to do |format|
      if @business_account.save
        format.html { redirect_to "/business_accounts/#{@business_account.id.to_s}/payment/new", notice: 'Business account was successfully created.' }
        format.json { render json: @business_account, status: :created, location: @business_account }
      else
        format.html { render action: "new" }
        format.json { render json: @business_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /business_accounts/1
  # PUT /business_accounts/1.json
  def update
    @business_account = BusinessAccount.find(params[:id])

    respond_to do |format|
      if @business_account.update_attributes(params[:business_account])
        format.html { redirect_to "/business_accounts/#{@business_account.id.to_s}/payment/new", notice: 'Business account was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @business_account.errors, status: :unprocessable_entity }
      end
    end
  end

  def payments
    @business_account = BusinessAccount.find(params[:id])

    respond_to do |format|
      format.html { render action: "payment" }
    end
  end

  # # DELETE /business_accounts/1
  # # DELETE /business_accounts/1.json
  # def destroy
  #   @business_account = BusinessAccount.find(params[:id])
  #   @business_account.destroy

  #   respond_to do |format|
  #     format.html { redirect_to business_accounts_url }
  #     format.json { head :no_content }
  #   end
  # end
end
