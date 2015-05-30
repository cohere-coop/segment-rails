require_relative 'minitest_helper'
require 'segment_rails'

class TestSegmentRails < Minitest::Test
  class FakeApp
    include SegmentRails
    set_user_identifier ->() { 1 }
    def cookies
      @cookies ||= {}
    end
  end

  def test_setting_the_an_identifier_callback
    n = FakeApp.new
    assert_equal 1, n.user_identifier
  end

  def test_tracking_an_event
    n = FakeApp.new
    n.track_event("Going to the moon", { rocket: "Apollo 11" })
    analytics = JSON.parse(n.cookies[:analytics])
    assert_equal 1, analytics["uuid"]
    assert_equal({ "name" => "Going to the moon", "properties" => { "rocket" => "Apollo 11" } },
                 analytics["events"][0])
  end
end
