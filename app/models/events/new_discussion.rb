class Events::NewDiscussion < Event
  def self.publish!(discussion)
    event = create!(kind: 'new_discussion',
                    eventable: discussion,
                    discussion: discussion)

    group = discussion.group
    DiscussionReader.for(discussion: discussion,
                         user: discussion.author).follow!

    discussion.followers_without_author.
               email_followed_threads.each do |user|
      ThreadMailer.delay.new_discussion(user, event)
    end

    discussion.followers_without_author.
               dont_email_followed_threads.
               email_new_discussions_for(group).uniq.each do |user|
      ThreadMailer.delay.new_discussion(user, event)
    end

    discussion.group_members_not_following.
               email_new_discussions_for(group).uniq.each do |user|
      ThreadMailer.delay.new_discussion(user, event)
    end

	payload = { "event" => "new_discussion", "group" => group.as_json,
				"discussion" => discussion.as_json, "user_name" => discussion.author.name }
	group.api_group_subscriptions.each do |subscription|
		payload["subscription"] = subscription.as_json
		send_api_subscription_notification subscription, payload
	end

    event
  end

  def discussion
    eventable
  end
end
