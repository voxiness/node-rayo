(function() {
  var conn, log, rayo, rayoConfig;

  rayo = require('../rayo');

  rayoConfig = require('./config');

  log = require('node-log');

  log.setName('rayo-test');

  conn = new rayo.Connection(rayoConfig);

  conn.on('connected', function() {
    log.info('Connected!');
    return conn.on('offer', function(cmd) {
      var accept, reject;
      log.info("Incoming call...");
      accept = conn.create('accept', {
        callid: cmd.callid
      });
      reject = conn.create('reject', {
        callid: cmd.callid,
        error: {},
        header: [
          {
            "x-error-detail": "some descriptive error message"
          }
        ]
      });
      conn.send(accept);
      conn.send(reject);
      return log.info("Rejected call with error");
    });
  });

  conn.on('disconnected', function() {
    return log.info('Connection closed');
  });

  conn.on('error', function(err) {
    return log.error(err.message);
  });

  conn.connect();

}).call(this);
