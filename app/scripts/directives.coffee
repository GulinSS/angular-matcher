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

.directive('inputTextDynamicWidth', [
  "$document"
  ($document) ->
    require: "ngModel"
    link: (scope, iElement, iAttrs) ->
      checkSize = ->
        tester = angular.element "<span id='textWidthTester'></span>"
        angular.element("body", $document).append(tester)
        tester.text(iElement.val())
        width = tester.css("width").replace /[^-\d\.]/g, ''
        width = parseInt(width) + 2
        tester.remove()
        iElement.css
          width: "#{width}px"

      checkSize()

      scope.$watch iAttrs.ngModel, (v) ->
        checkSize()
])
