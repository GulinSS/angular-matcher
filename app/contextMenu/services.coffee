angular.module("contextMenu.services", [])

.factory("contextMenu", [
  '$document'
  '$rootScope'
  '$q'
  'Element'
  ($document, $rootScope, $q, Element) ->
    (parameters) ->
      scope = $rootScope.$new()
      deferred = $q.defer()
      take = (v) ->
        deferred.resolve v

      parameters = angular.extend
        x: 0
        y: 0
        elements: []
      , parameters

      angular.extend scope,
        x: "#{parseInt(parameters.x)}px"
        y: "#{parseInt(parameters.y)}px"
        elements: parameters.elements.map (v) -> new Element v
        take: take

      cancel: ->

      take: ->
        scope.element.forEach (v) ->
          if v.selected is true
            return take v

      down: ->
      up: ->
      promise: deferred.promise
])