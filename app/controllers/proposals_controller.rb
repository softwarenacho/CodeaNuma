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
    proposal = Proposal.find_by(name: params[:proposal][:name])
    if proposal == nil
      @proposal = Proposal.new(proposal_params)
      p @proposal.save
      p @proposal
      flash[:success] = "Propuesta agregada"
      redirect_to proposals_path
    else
      @proposal = proposal
      flash[:danger] = "La propuesta ya existe"
      redirect_to proposals_path
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
      tweet = "Propongo a @#{proposal_params[:twitter_handle]} como ponente de @tag_cdmx, creado desde mi app hecha con @codeacamp #TagCDMX #CodeTheFuture #BeMoreNerd"
      if @proposal
        if current_user == nil
          up = UserProposal.where(user_id: request.remote_ip, proposal_id: @proposal.id)
        else
          up = UserProposal.where(user_id: current_user.id, proposal_id: @proposal.id)
        end
        p "Esto es up" * 10
        p up
        if up.any?
          flash[:danger] = "Sólo puedes agregar la Propuesta una vez"
          redirect_to proposals_path
        else
        @proposal.increment(:counter).save      
        current_user.tweet(tweet) if current_user != nil
        flash[:success] = "Propuesta Agregada"
        redirect_to proposals_path
        end
      else
        @proposal = Proposal.new(proposal_params)
        if @proposal.save
          if current_user == nil
            UserProposal.create(user_id: request.remote_ip, proposal_id: @proposal.id)
          else
            UserProposal.create(user_id: current_user.id, proposal_id: @proposal.id)
            current_user.tweet(tweet)
          end
          flash[:success] = "Propuesta Agregada"
        else
          flash[:danger] = "Hubo un error al agregar tu Propuesta"
        end
        redirect_to proposals_path
      end
    end
end














