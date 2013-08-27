angular.module("contextMenu.services", [])

.factory("contextMenu", [
  '$compile'
  '$document'
  '$rootScope'
  '$q'
  'Element'
  ($compile, $document, $rootScope, $q, Element) ->
    scope = undefined

    (parameters) ->
      scope.$destroy() if scope isnt undefined

      scope = $rootScope.$new()
      deferred = $q.defer()

      parameters = angular.extend
        x: 0
        y: 0
        elements: []
      , parameters

      angular.extend scope,
        x: "#{parseInt(parameters.x)}px"
        y: "#{parseInt(parameters.y)}px"
        elements: parameters.elements.map (v) -> new Element v

        take: (v) ->
          deferred.resolve v
          scope.$destroy()

        select: (v) ->
          active = (e for e in scope.elements when e.active is true)[0]
          position = scope.elements.indexOf(active)
          scope.elements[position].active = false
          v.active = true

      scope.elements[0].active = true
      scope.$on "$destroy", ->
        deferred.reject()
        element.remove()

      element = $compile("<dropdown-menu/>")(scope)
      $document.find("body").append(element)

      scope: scope

      cancel: ->
        scope.$destroy()

      take: ->
        active = (e for e in scope.elements when e.active is true)[0]
        scope.take active

      down: ->
        active = (e for e in scope.elements when e.active is true)[0]
        position = scope.elements.indexOf(active)
        nextPosition = position + 1
        if nextPosition is scope.elements.length
          nextPosition = 0
        scope.elements[position].active = false
        scope.elements[nextPosition].active = true

      up: ->
        active = (e for e in scope.elements when e.active is true)[0]
        position = scope.elements.indexOf(active)
        nextPosition = position - 1
        if nextPosition is -1
          nextPosition = scope.elements.length-1
        scope.elements[position].active = false
        scope.elements[nextPosition].active = true

      promise: deferred.promise
])