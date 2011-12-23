rayo = require '../rayo'
rayoConfig = require './config'
log = require 'node-log'
log.setName 'rayo-test'

# Create a connection object
conn = new rayo.Connection rayoConfig

conn.on 'connected', ->
  log.info 'Connected!'
  
  conn.send conn.create 'wat', {wat: 'wat'}
  # Listen for offer command
  conn.on 'offer', (cmd) ->
    log.info "Incoming call..."
    answer = rayo.create 'answer', {callid: cmd.callid}

# Set up connection related event handlers
conn.on 'disconnected', -> log.info 'Connection closed'
conn.on 'error', (err) -> log.error err.message

conn.connect()
