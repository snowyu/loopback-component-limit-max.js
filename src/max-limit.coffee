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
    continue unless vScope? or maxLimit?
    Model.definition.settings.scope = ((aScope)->
      (target, inst)->
        result = aScope
        result = aScope.call(this, target, inst) if isFunction aScope

        vLimit = result.limit if result?
        vLimit = maxLimit unless vLimit?
        if target and not target.id? and vLimit?
          debug "%s target %o", @modelName, target
          result = extend {}, result
          result.limit = if target.limit < vLimit then target.limit else vLimit
          debug "%s old scope=%o, new scope=%o", @modelName, aScope, result
        result
    )(vScope)
  return
