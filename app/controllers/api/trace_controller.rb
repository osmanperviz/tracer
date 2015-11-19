class Api::TraceController < ApplicationController

  include CalculatingDistancesElevations

  def index
    traces = Trace.all
    @traces = calc_elevations_and_distances(traces)
    render json: @traces
  end

  def create
    trace = Trace.new(trace_params)
    @trace = assign_distance_and_elevation(trace)
    if @trace.save
      render json: @trace,status: 201
    else
      render json: @trace.errors,status: :unprocessable_entity
    end
  end

  def show
    @trace = Trace.find(params[:id])
     assign_distance_and_elevation(@trace)
    render json: @trace,status: 200
  end

  def update
    @trace = Trace.find(params[:id])
    if @trace.update_attributes(trace_params)
      render json: @trace,status: 200
    else
      render json: @trace.errors,status: 404
    end

  end

  def destroy
    @trace = Trace.find(params[:id])
    if @trace.destroy
      render nothing:true,status: 200
    else
      render json: @trace.errors
    end

  end

  private

  def trace_params
    params.require(:trace).permit(:longitude,:latitude)
  end
end
