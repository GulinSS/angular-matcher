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
    restrict: "C"
    link: (scope, iElement, iAttrs, controller) ->
      iElement.on "click", (e) ->
        e.preventDefault()
        e.stopPropagation()

        # TODO: extract to viewModel
        iElement.children("input").focus()
])

.directive('angularMatcherFilter', [
  ->
    require: "^angularMatcher"
    link: (scope, iElement) ->
      scope.$watch "filters", (v, old) ->
        return if v is undefined
        return if old is undefined
        return if v.length is old.length

        # TODO: extract to viewModel
        angular.element(".value:last-child", iElement).focus()
])

.directive('angularMatcherMatch', [
  ->
    require: "^angularMatcher"
    link: (scope, iElement, iAttrs, controller) ->

      angular.element(".field, .value", iElement).on "click", (e) ->
        e.preventDefault()
        e.stopPropagation()

      angular.element(".close", iElement).on "click", (e) ->
        e.preventDefault()
        e.stopPropagation()

        scope.$apply ->

          # TODO: extract to viewModel
          neededToDelete = scope.filters.indexOf scope.filter
          scope.filters.splice neededToDelete, 1
])