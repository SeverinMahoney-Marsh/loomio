class Events::MotionClosingSoon < Event
  def self.publish!(motion)
    event = create!(kind: "motion_closing_soon",
                    eventable: motion)

    motion.followers.
           email_followed_threads.each do |user|
      ThreadMailer.delay.motion_closing_soon(user, event)
    end

    motion.followers.
           dont_email_followed_threads.
           email_when_proposal_closing_soon.each do |user|
      ThreadMailer.delay.motion_closing_soon(user, event)
    end

    motion.group_members_not_following.
           email_when_proposal_closing_soon.each do |user|
      ThreadMailer.delay.motion_closing_soon(user, event)
    end

    motion.group_members.each do |member|
      event.notify!(member)
    end

	payload = { "event" => "motion_closing_soon", "motion" => motion.as_json,
				"hours_remaining" => ((motion.closing_at - Time.now) / 1.hour).round}
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
