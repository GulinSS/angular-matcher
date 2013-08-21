'use strict'

### Directives ###

# register the module with Angular
angular.module('app.directives', [
  # require the 'app.service' module
  'app.services'
])

.directive('angularMatcher', [
  ->
    controller: "Matcher"
    restrict: "CA"
    link: (scope, iElement, iAttrs, controller) ->
      iElement.on "click", (e) ->
        e.preventDefault()
        e.stopPropagation()

        iElement.children("input").focus()
])

.directive('angularMatcherFilter', [
  ->
    require: "^angularMatcher"
    link: (scope, iElement, iAttrs, controller) ->
      iElement.on "click", (e) ->
        e.preventDefault()
        e.stopPropagation()

        angular.element("input", iElement).focus()
])

.directive('angularMatcherMatch', [
  ->
    require: "^angularMatcher"
    link: (scope, iElement, iAttrs, controller) ->

      angular.element(".field", iElement).on "click", (e) ->
        e.preventDefault()
        e.stopPropagation()

      angular.element(".value", iElement).on "click", (e) ->
        e.preventDefault()
        e.stopPropagation()

      angular.element(".close", iElement).on "click", (e) ->
        e.preventDefault()
        e.stopPropagation()

        scope.$apply ->
          neededToDelete = scope.filters.indexOf scope.filter
          scope.filters.splice neededToDelete, 1
])

