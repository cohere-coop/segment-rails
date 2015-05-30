require 'json'
module SegmentRails
  if const_defined? :Rails
    module Rails
      class Engine < ::Rails::Engine
      end
    end
  end

  module ClassMethods
    def set_user_identifier(callback)
      @user_identifier = callback
    end

    def user_identifier
      @user_identifier ? @user_identifier.call() : nil
    end
  end

  def self.included(klazz)
    klazz.extend(ClassMethods)
  end

  def user_identifier
    self.class.user_identifier
  end

  def track_event(event_name, properties={})
    analytics = cookies[:analytics] ? JSON.parse(cookies[:analytics]) : {}
    analytics[:uuid] = user_identifier if user_identifier
    analytics[:events] ||= []
    analytics[:events].push({ name: event_name, properties:  properties})
    cookies[:analytics] = JSON.dump(analytics)
  end
end
