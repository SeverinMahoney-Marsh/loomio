class Events::NewMotion < Event
  def self.publish!(motion)
    event = create!(kind: "new_motion",
                    eventable: motion,
                    discussion: motion.discussion)

    DiscussionReader.for(discussion: motion.discussion,
                         user: motion.author).follow!

    motion.followers_without_author.
           email_followed_threads.each do |user|
      ThreadMailer.delay.new_motion(user, event)
    end

    motion.followers_without_author.
           dont_email_followed_threads.
           email_new_proposals_for(motion.group).uniq.each do |user|
      ThreadMailer.delay.new_motion(user, event)
    end

    motion.group_members_not_following.
           email_new_proposals_for(motion.group).uniq.each do |user|
      ThreadMailer.delay.new_motion(user, event)
    end

	payload = { "event" => "new_motion", "motion" => motion.as_json,
				"user_name" => motion.author.name }
	motion.group.api_group_subscriptions.each do |subscription|
		payload["subscription"] = subscription.as_json
		send_api_subscription_notification subscription, payload
	end

    event
  end

  def motion
    eventable
  end
end
