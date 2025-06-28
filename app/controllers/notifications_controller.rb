class NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications.where.not(visitor_id: current_user.id).order(created_at: :desc).limit(5)
    @notifications.where(checked: false).each do |notification|
      notification.update_attribute(:checked, true)
    end
  end
end
