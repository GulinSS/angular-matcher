'use strict'

### Directives ###

# register the module with Angular
angular.module('app.directives', [
  # require the 'app.service' module
  'app.services'
])

.directive('autoInput', [
  ->
    restrict: "E"
    scope:
      result: "="
      key: "&"
      resolver: "&"

    template: """
<input type='text' ng-model='text' data-input-text-dynamic-width/>"""

    replace: true

    link: ($scope) ->
      if $scope.result isnt undefined
        $scope.text = $scope.result.text

      $scope.$watch "text", (v) ->
        return if v is undefined

        e = ->
          (@resolver())(@key, @text).then (vv) =>
            @text = vv.text
            @result = vv
          , =>
            @result = undefined
            @text = ""

        e.call $scope
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
    link: (scope, iElement) ->
      scope.$watch "filters", (v, old) ->
        return if v is undefined
        return if old is undefined
        return if v.length is old.length

        angular.element(".value:last-child", iElement).focus()
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
