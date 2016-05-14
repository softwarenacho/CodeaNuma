class ProposalsController < ApplicationController
  def index
    @proposal  = Proposal.new
    @proposals = Proposal.all
  end

  def new
    @proposal = Proposal.new
  end

  def create
    @proposal = Proposal.new(proposal_params)
    if @proposal.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
    @proposal = Proposal.find(params[:id])
  end

  def edit
    @proposal = Proposal.find(params[:id])
  end

  def update
    @proposal = Proposal.find(params[:id])
    if @proposal.update(proposal_params)
      flash[:success] = "Propuesta actualizada"
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    Proposal.find(params[:id]).destroy
    flash[:success] = "Propuesta borrada"
    redirect_to root_url
  end

  def add_proposal
    p "Entre a add proposal"
    p params

    @proposal = Proposal.new(proposal_params)
    if @proposal.save
      flash[:success] = "Propuesta Agregada"
      redirect_to root_path
    else
      render 'new'
    end


  end

  private

    def proposal_params
      params.require(:proposal).permit(:name, :avatar, :twitter_handle)
    end
end














