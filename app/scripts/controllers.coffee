'use strict'

### Controllers ###

angular.module('app.controllers', [])

.controller('AppCtrl', [
  '$scope'
  '$location'
  '$rootScope'
($scope, $location, $rootScope) ->

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

.controller('Sandbox', [
  '$scope'
  '$q'
  ($scope, $q) ->

    angular.extend $scope,
      filters: [
        text: "Body Type"
        value:
          text: "Sedan"
      ,
        text: "Manufacturer"
        value:
          text: "Mazda"
      ]

      suggestions: (key, text) ->
        $q.when [
          text: "#{text} 1"
        ,
          text: "#{text} 2"
        ,
          text: "#{text} 3"
        ]
])

