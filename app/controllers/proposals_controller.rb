class ProposalsController < ApplicationController

  before_action :api_access, only: [:api_create]

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
    @proposal = Proposal.find_by(twitter_handle: proposal_params[:twitter_handle])
    if @proposal
      @proposal.increment(:counter).save      
      flash[:success] = "Propuesta Agregada"
      redirect_to proposals_path
    else
      @proposal = Proposal.new(proposal_params)
      if @proposal.save
         flash[:success] = "Propuesta Agregada"
         redirect_to proposals_path
      else
        render 'new'
      end
    end
    p "X"*100
    # p @proposal.send_to_codea
  end

  def api_create
    puts "JALA"*1000
    puts params
    redirect_to(root_url)
  end

  private

    def proposal_params
      params.require(:proposal).permit(:name, :avatar, :twitter_handle)
    end

    def api_access
      api_token = User.find_by_api_token(params[:api_token])
      head :unauthorized unless api_token
    end
end














