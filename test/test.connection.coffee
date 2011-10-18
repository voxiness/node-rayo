>> Given a valid Rayo connection

  path = require 'path'
  rayo = require path.join process.cwd(), './src/rayo'

  conn = new rayo.Connection
    jabberId: 'contrahax@jabber.org'
    jabberPass: 'testpass'
    verbose: true


  conn.on 'error', (@err) -> console.error err.message
  conn.connect()