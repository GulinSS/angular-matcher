angular.module("autoInput.directives", [])
.directive('autoInput', [
  "contextMenu"
  "keyCodes"
  (contextMenu, keyCodes) ->
    restrict: "E"
    scope:
      result: "="
      key: "&"
      suggestions: "&"

    templateUrl: "app/autoInput/input.jade"
    replace: true

    link: ($scope, $element) ->
      menu = undefined

      if $scope.result isnt undefined
        $scope.text = $scope.result.text

      $element.keydown (e) ->
        return true if menu is undefined
        switch e.keyCode
          when keyCodes.upArrow   then menu.up()
          when keyCodes.downArrow then menu.down()
          when keyCodes.enter      then menu.take()
          when keyCodes.escape     then menu.cancel()
          else return true

        e.stopPropagation()
        e.preventDefault()

      buildContextMenu = (elements) =>
        menu = contextMenu
          x: $element.offset().left
          y: $element.offset().top + $element.height()
          elements: elements

        menu.promise.then (vv) =>
          $scope.text = vv.text
          $scope.result = elements
        , =>
          $scope.result = undefined

      $scope.$watch "text", (v, old) ->
        return if v is ""
        return if v is null
        return if v is old

        e = ->
          (@suggestions())(@key(), @text)
            .then buildContextMenu
            , -> menu?.cancel()

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
