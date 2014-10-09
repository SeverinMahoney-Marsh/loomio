class API::ProposalsController < API::BaseController
  def show
	proposal = Motion.find_by key: params[:id]
	if proposal
		if proposal.discussion.public?
			render :json => proposal
		else
			head 403 # Group is not public and you can't authenticate
		end
	else
		head 404 # The proposal does not exist
	end
  end
end
