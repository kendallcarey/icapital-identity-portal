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
    attrs = investor_params.dup
    docs  = Array(attrs.delete(:documents)).compact
    debugger
    ActiveRecord::Base.transaction do
      @investor = Investor.where(
        "LOWER(first_name) = ? AND LOWER(last_name) = ? AND ssn = ?",
        attrs[:first_name].to_s.downcase,
        attrs[:last_name].to_s.downcase,
        attrs[:ssn]
      ).first

      if @investor
        @investor.assign_attributes(attrs.slice(:street_address, :state, :zip, :phone, :dob))
        @investor.save!
        @investor.documents.attach(docs) if docs.any?
        notice = "Existing investor updated. Enter the next investor."
      else
        @investor = Investor.new(attrs)
        @investor.save!
        @investor.documents.attach(docs) if docs.any?
        notice = "Investor created. Enter the next investor."
      end

      respond_to do |format|
        format.html { redirect_to new_investor_path, notice: notice }
        format.json { render :show, status: :created, location: @investor }
      end
    rescue ActiveRecord::RecordInvalid
      respond_to do |format|
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
      params.expect(investor: [ :first_name, :last_name, :dob, :phone, :street_address, :state, :zip, :ssn, documents: [] ])
    end
end
