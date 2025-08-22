class InvestorsController < ApplicationController
  before_action :set_investor, only: %i[ show edit update destroy ]

  # GET /investors or /investors.json
  def index
    @investors = Investor.all
  end

  # GET /investors/1 or /investors/1.json
  def show
  end

  # GET /investors/new
  def new
    @investor = Investor.new
  end

  # GET /investors/1/edit
  def edit
  end

  # POST /investors or /investors.json
  def create
    @investor = Investor.new(investor_params)

    existing = Investor.where(
      "lower(first_name) = ? AND lower(last_name) = ? AND dob = ?",
      investor_params[:first_name].to_s.downcase,
      investor_params[:last_name].to_s.downcase,
      investor_params[:dob]
    ).first

    respond_to do |format|
      if @investor.save
        format.html { redirect_to @investor, notice: "Investor was successfully created." }
        format.json { render :show, status: :created, location: @investor }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @investor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /investors/1 or /investors/1.json
  def update
    respond_to do |format|
      if @investor.update(investor_params)
        format.html { redirect_to @investor, notice: "Investor was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @investor }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @investor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /investors/1 or /investors/1.json
  def destroy
    @investor.destroy!

    respond_to do |format|
      format.html { redirect_to investors_path, notice: "Investor was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    def set_investor
      @investor = Investor.find(params.expect(:id))
    end

    def investor_params
      params.expect(investor: [ :first_name, :last_name, :dob, :phone, :street_address, :state, :zip, documents: [] ])
    end
end
