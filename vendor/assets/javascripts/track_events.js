(function() {
  function trackEvents() {
    var to_track = JSON.parse(monster.get("analytics"));
    if (!to_track) { return; }

    if (to_track.uuid) {
      analytics.identify(to_track.uuid);
    }
    if (to_track.events) {
      to_track.events.forEach(function(evnt) {
        analytics.track(evnt.name.replace(/\+/g, " "), evnt.properties);
      });
    }
    monster.remove("analytics");
  }

  trackEvents();
})();
