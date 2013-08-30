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

    .when('/view1', {templateUrl: 'app/partials/partial1.jade'})

    # Catch all
    .otherwise({redirectTo: '/view1'})

  # Without server side support html5 must be disabled.
  $locationProvider.html5Mode(false)
])
