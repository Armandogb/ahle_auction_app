class SectionsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_check
  before_action :set_section, only: %i[ show edit update destroy ]

  # GET /sections or /sections.json
  def index
    @sections = Section.all
  end

  # GET /sections/1 or /sections/1.json
  def show
  end

  # GET /sections/new
  def new
    @section = Section.new
  end

  # GET /sections/1/edit
  def edit
  end

  def reset_sections
    @sections = Section.all

    @sections.each do |sect|
      sect.set_alerts(false)
      sect.active = true
      sect.save
    end

    redirect_to admin_index_path, notice: "Sections Active and texts reset."

  end

  # POST /sections or /sections.json
  def create
    @section = Section.new(section_params)

      if @section.save
        redirect_to admin_index_path, notice: "Section was successfully created."
      else
        render :new, status: :unprocessable_entity
      end

  end

  # PATCH/PUT /sections/1 or /sections/1.json
  def update
      if @section.update(section_params)
        redirect_to admin_index_path, notice: "Section was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
  end

  # DELETE /sections/1 or /sections/1.json
  def destroy
    @section.destroy

      redirect_to admin_index_path, notice: "Section was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_section
      @section = Section.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def section_params
      params.require(:section).permit!
    end
end
