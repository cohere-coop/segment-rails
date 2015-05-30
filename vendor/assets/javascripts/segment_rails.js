(function() {
  var monster = (function() {
    /*!
     * cookie-monster - a simple cookie library
     * v0.3.0
     * https://github.com/jgallen23/cookie-monster
     * copyright Greg Allen 2014
     * MIT License
     */
    return {
      set: function(name, value, days, path, secure) {
        var date = new Date(),
        expires = '',
        type = typeof(value),
          valueToUse = '',
          secureFlag = '';
        path = path || "/";
        if (days) {
          date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
          expires = "; expires=" + date.toUTCString();
        }
        if (type === "object"  && type !== "undefined") {
          if(!("JSON" in window)) throw "Bummer, your browser doesn't support JSON parsing.";
          valueToUse = encodeURIComponent(JSON.stringify({v:value}));
        } else {
          valueToUse = encodeURIComponent(value);
        }
        if (secure){
          secureFlag = "; secure";
        }

        document.cookie = name + "=" + valueToUse + expires + "; path=" + path + secureFlag;
      },
      get: function(name) {
        var nameEQ = name + "=",
        ca = document.cookie.split(';'),
        value = '',
          firstChar = '',
          parsed={};
        for (var i = 0; i < ca.length; i++) {
          var c = ca[i];
          while (c.charAt(0) == ' ') c = c.substring(1, c.length);
          if (c.indexOf(nameEQ) === 0) {
            value = decodeURIComponent(c.substring(nameEQ.length, c.length));
            firstChar = value.substring(0, 1);
            if(firstChar=="{"){
              try {
                parsed = JSON.parse(value);
                if("v" in parsed) return parsed.v;
              } catch(e) {
                return value;
              }
            }
            if (value=="undefined") return undefined;
            return value;
          }
        }
        return null;
      },
      remove: function(name) {
        this.set(name, "", -1);
      },
      increment: function(name, days) {
        var value = this.get(name) || 0;
        this.set(name, (parseInt(value, 10) + 1), days);
      },
      decrement: function(name, days) {
        var value = this.get(name) || 0;
        this.set(name, (parseInt(value, 10) - 1), days);
      }
    };
  })();

  function enableDebugMode() {
    var options = window.location.search.substring(1);
    if (options.match(/debug/i)) {
      console.log(analytics.debug);
      analytics.debug();
    } else {
      analytics.debug(false);
    }
  }

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

  analytics.ready(function() {
    enableDebugMode();
    trackEvents();
  });
})();
