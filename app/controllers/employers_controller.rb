class EmployersController < ApplicationController
  before_action :set_employer, only: %i[show edit update destroy]

  # GET /employers or /employers.json
  def index
    @employers = Employer.all
  end

  # GET /employers/1 or /employers/1.json
  def show; end

  # GET /employers/new
  def new
    @employer = Employer.new
  end

  # GET /employers/1/edit
  def edit; end

  def random
    @employer = Employer.find(params[:format])

    if @employer.status != 'Verified'
      @employer.update(status: 'Verified')
      redirect_to @employer, success: { msg: 'Employee Verified.!!!!', code: SecureRandom.alphanumeric }
    else
      redirect_to @employer, danger: { msg: 'Employee Already Verified' }

    end
  end

  # POST /employers or /employers.json
  def create
    @employer = Employer.new(employer_params.merge(status: 'Not Verified'))

    respond_to do |format|
      if @employer.save
        format.html { redirect_to @employer, success: { msg: 'Employer was successfully created.' } }
        format.json { render :show, status: :created, location: @employer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @employer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employers/1 or /employers/1.json
  def update
    old_phone = @employer.phone
    old_email = @employer.email

    respond_to do |format|
      if @employer.update(employer_params)

        if old_phone != @employer.phone || old_email != @employer.email
          @employer.update(status: 'Not Verified')
          flash[:warning] = { msg: 'Email or Phone have been update! Please compleate verification' }
        end
        format.html { redirect_to @employer, success: { msg: 'Employee details successfully updated.' } }
        format.json { render :show, status: :ok, location: @employer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @employer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employers/1 or /employers/1.json
  def destroy
    @employer.destroy
    respond_to do |format|
      format.html { redirect_to employers_url, danger: { msg: 'Employee was successfully deleted.' } }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_employer
    @employer = Employer.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def employer_params
    params.require(:employer).permit(:name, :email, :phone, :gender, :dob, :location, :status)
  end
end
