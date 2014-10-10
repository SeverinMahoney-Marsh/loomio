class API::APIGroupSubscriptionsController < API::BaseController
	def create
		if params.has_key?(:subdomain) && params.has_key?(:path)
			group = Group.find_by subdomain: params[:subdomain]

			if group
				if group.is_visible_to_public
					sub = group.api_group_subscriptions.create(tag: params[:tag], path: params[:path])
					render :json => sub
				else
					head 403 # Group is not public and you can't authenticate
				end
			else
				head 404 # The group does not exist
			end
		else
			head 409 # Conflict, must have subdomain and path
		end
	end
end
