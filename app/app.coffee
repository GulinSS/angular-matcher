'use strict'

# Declare app level module which depends on filters, and services
App = angular.module('app', [
  'app.controllers'
  'app.templates'

  'angularMatcher'
])

App.config([
  '$routeProvider'
  '$locationProvider'

($routeProvider, $locationProvider, config) ->

  $routeProvider

    .when('/sandbox', {
      templateUrl: 'app/partials/sandbox.jade'
      controller: 'Sandbox'
    })

    # Catch all
    .otherwise({redirectTo: '/sandbox'})

  # Without server side support html5 must be disabled.
  $locationProvider.html5Mode(false)
])
