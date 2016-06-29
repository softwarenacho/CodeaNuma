class ProposalsController < ApplicationController

  skip_before_filter :verify_authenticity_token, :only => [:api_create, :api_counter]
  before_action :api_access, only: [:api_create, :api_counter]

  def index
    @proposal  = Proposal.new
    @proposals = Proposal.all.order(counter: :desc)
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
    create_from_twitter
    # @proposal.send_to_codea
  end

  def api_create
    create_from_twitter
  end

  def api_counter
    @counter = Proposal.find_by(twitter_handle: proposal_params[:twitter_handle]).counter
    render plain: @counter
  end

  private

    def proposal_params
      params.require(:proposal).permit(:name, :avatar, :twitter_handle)
    end

    def api_access     
      api_token = User.find_by_api_token("#{params[:api_token]}")     
      head :unauthorized unless api_token
    end

    def create_from_twitter
      @proposal = Proposal.find_by(twitter_handle: proposal_params[:twitter_handle])
      tweet = "Quiero ver a @#{proposal_params[:twitter_handle]} en \#TagCDMX \#BeMoreNerd \#CodeTheFuture @codeacamp @tag_cdmx"
      if @proposal
        @proposal.increment(:counter).save      
        flash[:success] = "Propuesta Agregada"
        current_user.tweet(tweet)
        redirect_to proposals_path
      else
        @proposal = Proposal.new(proposal_params)
        if @proposal.save
            flash[:success] = "Propuesta Agregada"
            if current_user
            current_user.tweet(tweet)
            end
            redirect_to proposals_path
        else
          render 'new'
        end
      end
    end
end














