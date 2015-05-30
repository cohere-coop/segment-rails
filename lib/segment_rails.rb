require 'segment_rails/version'

module SegmentRails
  module Rails
    class Engine < ::Rails::Engine
    end
  end

  def track_event(event_name, properties={})
    analytics = cookies[:analytics] ? JSON.parse(cookies[:analytics]) : {}
    analytics[:uuid] = current_user.uuid  if current_user
    analytics[:events] ||= []
    analytics[:events].push({ name: event_name, properties:  properties})
    cookies[:analytics] = JSON.dump(analytics)
  end
end
