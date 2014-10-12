class Events::MotionClosed < Event
  def self.publish!(motion)
    event = create!(kind: 'motion_closed',
                    eventable: motion)

    motion.followers.email_followed_threads.each do |user|
      ThreadMailer.delay.motion_closed(user, event)
    end

	payload = { "event" => "motion_closed", "motion" => motion.as_json }
	motion.group.api_group_subscriptions.each do |subscription|
		payload["subscription"] = subscription.as_json
		send_api_subscription_notification subscription, payload
	end

    event.notify! motion.author
    event
  end

  def motion
    eventable
  end
end
