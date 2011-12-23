RayoCommand = require '../../commands/models/RayoCommand'

sendRayoMessage = (xmpp, cmd, callback) ->
  return null unless cmd instanceof RayoCommand
  xmpp.once cmd.msgid, callback if callback? and typeof callback is 'function'
  xmpp.send cmd.getElement(xmpp)

module.exports = sendRayoMessage
