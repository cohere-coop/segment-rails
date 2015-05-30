# Segment-Rails

Segment is an incredible layer of abstraction between your application and
analytics systems. It's major benefit is when tracking events at the user
interface side. This includes all kinds of great meta data about the user that
isn't available on the server.


In client rendered apps this isn't a problem. Do event tracking at the
JavaScript layer once the event is verified as successful! In server-side apps,
the browser doesn't have a clear way of knowing whether an action was successful
or not.

To get that oh-so-sweet client side meta-data while still maintaining the rapid
development and accessibility of server-side rendering; we enqueue user action
events in a cookie. We use JavaScript to read the queue and track the events
with Segment. Mmmm, now we get the lovely referring domain and utm data!

## Installation + Usage

1. Add `segment_rails` to your Gemfile
2. Configure `segment_rails` in your `ApplicationController`
  ```
  class ApplicationController < ActionController::Base
    include SegmentRails
    set_user_identifier ->() do
      current_user ? current_user.id : nil
    end
  end
  ```
3. Instrument your controllers with `track_event("Timmy fell down the
well", { reporter: :lassie })`
4. Profit! (Or at least, observe behaviors which you hope will lead to profit)


