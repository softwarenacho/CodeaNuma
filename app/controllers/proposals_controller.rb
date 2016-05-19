class ProposalsController < ApplicationController
  def index
    @proposal  = Proposal.new
    @proposals = Proposal.all
  end

  def new
    @proposal = Proposal.new
  end

  def create
    
    @proposal = Proposal.find_or_create_by_name(proposal_params[:name])
    if @proposal.save
      redirect_to proposals_path
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
      redirect_to proposals_path
    else
      render 'edit'
    end
  end

  def destroy
    Proposal.find(params[:id]).destroy
    flash[:success] = "Propuesta borrada"
    redirect_to proposals_path
  end

  def add_proposal    
    if @proposal = Proposal.create_with(proposal_params).find_or_create_by(twitter_handle: proposal_params[:twitter_handle])
      flash[:success] = "Propuesta Agregada"
      redirect_to proposals_path
    else
      render 'new'
    end


  end

  private

    def proposal_params
      params.require(:proposal).permit(:name, :avatar, :twitter_handle)
    end
end














