class API::ActiveProposalsController < API::BaseController
  def show
	group = Group.find_by subdomain: params[:id]
	if group
		if group.is_visible_to_public
			proposals = group.discussions
			proposals = proposals.inject [] { |prop, disc| 
				prop << disc.current_motion unless disc.private? || disc.current_motion.nil?
				prop}
			render :json => proposals
		else
			head 403 # Group is not public and you can't authenticate
		end
	else
		head 404 # The group does not exist
	end
  end
end
