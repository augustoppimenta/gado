class RowsController < ApplicationController

  #->Prelang (scaffolding:rails/scope_to_user)
  before_filter :require_user_signed_in, only: [:new, :edit, :create, :update, :destroy]

  before_action :set_row, only: [:show, :edit, :update, :destroy, :vote]

  # GET /rows
  # GET /rows.json
  def index
    @rows = Row.all
  end

  # GET /rows/1
  # GET /rows/1.json
  def show
  end

  # GET /rows/new
  def new
    @row = Row.new
  end

  # GET /rows/1/edit
  def edit
  end

  # POST /rows
  # POST /rows.json
  def create
    @row = Row.new(row_params)
    @row.user = current_user

    respond_to do |format|
      if @row.save
        format.html { redirect_to @row, notice: 'Row was successfully created.' }
        format.json { render :show, status: :created, location: @row }
      else
        format.html { render :new }
        format.json { render json: @row.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rows/1
  # PATCH/PUT /rows/1.json
  def update
    respond_to do |format|
      if @row.update(row_params)
        format.html { redirect_to @row, notice: 'Row was successfully updated.' }
        format.json { render :show, status: :ok, location: @row }
      else
        format.html { render :edit }
        format.json { render json: @row.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rows/1
  # DELETE /rows/1.json
  def destroy
    @row.destroy
    respond_to do |format|
      format.html { redirect_to rows_url, notice: 'Row was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  #->Prelang (voting/acts_as_votable)
  def vote

    direction = params[:direction]

    # Make sure we've specified a direction
    raise "No direction parameter specified to #vote action." unless direction

    # Make sure the direction is valid
    unless ["like", "bad"].member? direction
      raise "Direction '#{direction}' is not a valid direction for vote method."
    end

    @row.vote_by voter: current_user, vote: direction

    redirect_to action: :index
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_row
      @row = Row.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def row_params
      params.require(:row).permit(:user_id, :age, :race_id)
    end
end
