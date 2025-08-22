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
    ActiveRecord::Base.transaction do
      # TODO: fix the querying to find the investor with the encrypted ssn field
      # @investor = Investor.find_by(
      #   first_name: investor_params[:first_name].to_s.strip.downcase,
      #   last_name:  investor_params[:last_name].to_s.strip.downcase,
      #   ssn:        investor_params[:ssn]
      # )
      #
      # if @investor
      #   @investor.assign_attributes(investor_params.slice(:street_address, :state, :zip, :phone, :dob))
      #   @investor.documents.attach(docs) if docs.any?
      #   @investor.save!
      #   notice = "Existing investor updated. Enter the next investor."
      # else
      #   @investor = Investor.new(investor_params)
      #   @investor.documents.attach(docs) if docs.any?
      #   @investor.save!
      #   notice = "Investor created. Enter the next investor."
      # end
      #
      @investor = Investor.new(investor_params)

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
      params.expect(investor: [ :first_name, :last_name, :dob, :phone, :street_address, :state, :zip, :ssn, documents: [] ])
    end
end
