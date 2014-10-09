class API::SubdomainsController < API::BaseController
  def update
	group = Group.find_by name: params[:id]
	if group
			group.subdomain = params[:subdomain]
			group.save
			render :json => group
	else
		head 404 # The group does not exist
	end
  end
end
