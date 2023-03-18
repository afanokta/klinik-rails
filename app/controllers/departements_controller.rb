class DepartementsController < ApplicationController
    before_action :set_departement, only: [:show, :update, :destroy]

    # GET /departements
    def index
      @departements = Departement.all

      render json: @departements.map { |departement| departement.new_attr }
    end

    # GET /departement/1
    def show
      render json: @departement.new_attr
    end

    # POST /departement
    def create
      @departement = Departement.new(departement_params)

      if @departement.save
        render json: @departement.new_attr, status: :created
      else
        render json: @departement.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /departement/1
    def update
      if @departement.update(departement_params)
        render json: @departement.new_attr
      else
        render json: @departement.errors, status: :unprocessable_entity
      end
    end

    # DELETE /departement/1
    def destroy
      @departement.destroy
    end

    private

      # Only allow a trusted parameter "white list" through.
    def departement_params
        params.permit(:name)
    end
    def set_departement
      @departement = Departement.find_by_id(params[:id])
      if @departement.nil?
        render json: { error: "departement not found" }, status: :not_found
      end
    end
    # def departement_params
    # {
    # #   id: params[ :id],
    #   name: params[:name],
    # }
#   end

end
