isArray     = require 'util-ex/lib/is/type/array'
isObject    = require 'util-ex/lib/is/type/object'
isNumber    = require 'util-ex/lib/is/type/number'
isFunction  = require 'util-ex/lib/is/type/function'
extend      = require 'util-ex/lib/_extend'
debug       = require('debug')('loopback:component:limit:max')

module.exports = (aApp, aOptions) ->
  loopback = aApp.loopback
  maxLimit = aOptions and aOptions.limit

  vModels = (aOptions and aOptions.models)
  vModels = [] if vModels is false
  if isArray vModels
    vResult = {}
    for vName in vModels
      Model = aApp.models[vName]
      vResult[vName] = Model if Model
    vModels = vResult
  else
    vModels = aApp.models

   for vName, Model of vModels
    vScope = Model.definition.settings.scope
    continue if isFunction vScope
    vLimit = vScope?.limit || maxLimit
    continue unless isNumber vLimit
    Model.defaultScope = ((aScope, aLimit)->
      (target, inst)->
        result = aScope
        if target and not target.id?
          debug "%s target %o", this.modelName, target
          result = extend {}, aScope
          result.limit = if target.limit < aLimit then target.limit else aLimit
          debug "%s old scope=%o, new scope=%o", this.modelName, aScope, result
        result
    )(vScope, vLimit)
  return
