class DinosaursController < ApplicationController
  before_action :set_dinosaur, only: [:show, :edit, :update, :destroy]

  # GET /dinosaurs
  def index
    @dinosaurs = Dinosaur.all
    render json: @dinosaurs
  end

end
