class API::SearchGroupsController < API::BaseController
  def show
	group = Group.find_by subdomain: params[:id]
	if group
		if group.is_visible_to_public
			render :json => group
		else
			head 403 # Group is not public and you can't authenticate
		end
	else
		head 404 # The group does not exist
	end
  end
end
