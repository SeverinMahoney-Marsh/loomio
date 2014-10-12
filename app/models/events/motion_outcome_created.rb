class Events::MotionOutcomeCreated < Event
  after_create :notify_users!

  def self.publish!(motion, user)
    create!(kind: "motion_outcome_created",
            eventable: motion,
            discussion: motion.discussion,
            user: user)
	
	payload = { "event" => "motion_outcome_posted", "motion" => motion.as_json,
				"user_name" => user.name }
	motion.group.api_group_subscriptions.each do |subscription|
		payload["subscription"] = subscription.as_json
		send_api_subscription_notification subscription, payload
	end
  end

  def motion
    eventable
  end

  private

  def notify_users!
    motion.followers_without_outcome_author.
           email_followed_threads.each do |user|
      ThreadMailer.delay.motion_outcome_created(user, self)
    end

    motion.group_members_without_outcome_author.each do |user|
      notify!(user)
    end
  end

  handle_asynchronously :notify_users!
end
