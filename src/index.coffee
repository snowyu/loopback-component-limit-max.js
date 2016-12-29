'use strict'
debug = require('debug')('loopback:component:limit:max')
maxLimit = require './max-limit'

module.exports = (app, options) ->
  debug 'initializing component'
  loopback = app.loopback
  loopbackMajor = loopback and loopback.version and loopback.version.split('.')[0] or 1
  if loopbackMajor < 2
    throw new Error('loopback-component-limit-max requires loopback 2.0 or newer')

  if !options or options.enabled isnt false
    maxLimit(app, options)
  else
    debug 'component not enabled'
