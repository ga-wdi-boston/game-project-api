'use strict';
var resourceWatcher = function(url, conf) {
  var token = function(conf) {
    return conf && (conf = conf.Authorization) &&
      (conf = typeof conf === 'string' &&
        conf.split('=')) &&
      Array.isArray(conf) && conf[1];
  };
  url += '?token=' + token(conf);
  url += conf.timeout ? '&timeout=' + conf.timeout : '';
  var es = new EventSource(url);
  var close = function() {
    es.close();
  };
  var makeHandler = function(handler, close) {
    return function(e) {
      if (close) {
        close();
      }
      return handler(e.data ? e.data : e);
    };
  };

  var on = function(event, handler) {
    switch (event) {
      case 'connect':
        es.onopen = makeHandler(handler);
        break;
      case 'change':
        es.onmessage = makeHandler(handler);
        break;
      case 'error':
        es.onerror = makeHandler(handler, close);
        break;
      default:
        console.error('Unknown event type:' + event);
        break;
    }
  };

  return {
    close: close,
    on: on
  };
};
