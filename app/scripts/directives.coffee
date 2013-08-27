'use strict'

### Directives ###

# register the module with Angular
angular.module('app.directives', [])

.directive('angularMatcher', [
  ->
    controller: "Matcher"
    restrict: "C"
    link: (scope, iElement, iAttrs, controller) ->
      iElement.on "click", (e) ->
        e.preventDefault()
        e.stopPropagation()
        iElement.children("input").focus()

      scope.$watch "filters", (v, old) ->
        return if v is undefined
        return if old is undefined
        return if v.length is old.length
        $(".value:last-child", iElement).focus()
])

.directive('angularMatcherMatch', [
  ->
    require: "^angularMatcher"
    templateUrl: "app/partials/angular-matcher-match.jade"
    link: (scope, iElement, iAttrs, controller) ->

      $(".field, .value", iElement).on "click", (e) ->
        e.preventDefault()
        e.stopPropagation()

      scope.remove = ->
        neededToDelete = scope.filters.indexOf scope.filter
        scope.filters.splice neededToDelete, 1
])