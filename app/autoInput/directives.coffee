angular.module("autoInput.directives", [])
.directive('autoInput', [
  ->
    restrict: "E"
    scope:
      result: "="
      key: "&"
      resolver: "&"

    templateUrl: "app/autoInput/input.jade"
    replace: true

    link: ($scope) ->
      if $scope.result isnt undefined
        $scope.text = $scope.result.text

      $scope.$watch "text", (v, old) ->
        return if v is ""
        return if v is null
        return if v is old

        e = ->
          (@resolver())(@key(), @text).then (vv) =>
            @text = vv.text
            @result = vv
          , =>
            @result = undefined
            @text = ""

        e.call $scope
])

.directive('dynamicWidth', [
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
