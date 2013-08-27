'use strict'

### Controllers ###

angular.module('app.controllers', [])

.controller('AppCtrl', [
  '$scope'
  '$location'
  '$resource'
  '$rootScope'

($scope, $location, $resource, $rootScope) ->

  # Uses the url to determine if the selected
  # menu item should have the class active.
  $scope.$location = $location
  $scope.$watch('$location.path()', (path) ->
    $scope.activeNavId = path || '/'
  )

  # getClass compares the current url with the id.
  # If the current url starts with the id it returns 'active'
  # otherwise it will return '' an empty string. E.g.
  #
  #   # current url = '/products/1'
  #   getClass('/products') # returns 'active'
  #   getClass('/orders') # returns ''
  #
  $scope.getClass = (id) ->
    if $scope.activeNavId.substring(0, id.length) == id
      return 'active'
    else
      return ''
])

.controller('Matcher', [
  '$scope'
  '$q'
  'contextMenu'
  ($scope, $q, contextMenu) ->

    contextMenu
      elements: [
        text: "1"
      ]


    angular.extend $scope,
      filters: [
        key: #TODO: class A
          name: "Body Type"
          parent: null
          child: "Manufacturer"

        result:
          text: "Body Type"

          key: #TODO: class B
            resultFor: "Body Type"

          value:
            id: 1
            text: "Sedan"
      ]

      # TODO: list of available filter fields
      fields: [

      ]

      #filters: [
      #  field: "Body Type"
      #  value: "Sedan"
      #,
      #  field: "Manufacturer"
      #  value: "Mazda"
      #,
      #  field: "Model"
      #  value: "6"
      #,
      #  field: "Year"
      #  value: "2007"
      #]

      # TODO: add coords to parameters
      showList: (key, text) ->
        deferred = $q.defer()

        deferred.resolve
          text: text

        deferred.promise
])
