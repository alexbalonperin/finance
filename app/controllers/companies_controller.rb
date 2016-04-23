class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy, :historical_data]

  # GET /companies
  # GET /companies.json
  def index
  end

  def list
    @companies = Company.includes([:industry, :sector])
                     .order("#{params[:sort] || 'companies.name'} #{params[:order]}")
                     .limit(params[:limit])
                     .offset(params[:offset])
    @companies = @companies
                     .joins([:industry, :sector])
                     .where('industries.name ~* ? OR sectors.name ~* ? OR companies.name ~* ? OR companies.symbol ~* ?',
                            params[:search], params[:search], params[:search], params[:search]) if params[:search].present?
    @count = Company.count
    respond_to do |format|
      format.json { render json: { :total => @count,
                                   :rows => @companies.map(&:to_json) } }
    end
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
  end

  # GET /companies/new
  def new
    @company = Company.new
  end

  # GET /companies/1/edit
  def edit
  end

  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(company_params)

    respond_to do |format|
      if @company.save
        format.html { redirect_to @company, notice: 'Company was successfully created.' }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to @company, notice: 'Company was successfully updated.' }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to companies_url, notice: 'Company was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:name, :industry_id, :symbol)
    end
end
