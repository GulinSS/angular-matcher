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
        iElement.find(".last").focus()

      scope.$on "Matcher:focus", ->
        iElement.find(".last").focus()

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
      scope.$watch "filter.result", ->
        iElement.find(".value").focus()

      scope.$watch "filter.result.value", ->
        scope.$emit "Matcher:focus"

      $(".field, .value", iElement).on "click", (e) ->
        e.stopPropagation()
])