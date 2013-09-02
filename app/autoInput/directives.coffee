angular.module("autoInput.directives", [])
.directive('autoInput', [
  "contextMenu"
  "keyCodes"
  (contextMenu, keyCodes) ->
    restrict: "E"
    scope:
      result: "="
      suggestions: "&"

      #TODO: implement it as nullable
      key: "&"

    #controller: it must solve such tasks:
    # 1. on taking result execute jump focus to next autoInput
    # 2. on moving cursor to the left of left border
    #    execute jump focus to previous autoInput
    # 3. on moving cursor to the right of last symbol in input
    #    execute jump focus to next autoInput

    templateUrl: "app/autoInput/input.jade"
    replace: true

    link: ($scope, $element) ->
      menu = undefined

      if $scope.result isnt undefined
        $scope.text = $scope.result.text

      $scope.$watch "result", (v) ->
        if v is undefined
          $scope.text = ""

      buildContextMenu = (elements) =>
        menu = contextMenu
          x: $element.offset().left
          y: $element.offset().top + $element.height()
          elements: elements


        menu.promise.then (vv) =>
          interruptWatch ->
            $scope.text = vv.text
          $scope.result = vv
        , =>
          $scope.result = undefined

      triggerMenu = ->
        e = ->
          (@suggestions())(@key(), @text)
            .then buildContextMenu
            , -> menu?.cancel()

        e.call $scope

      textWatch = (v, old) ->
        return if v is ""
        return if v is null
        return if v is old

        triggerMenu()

      textWatchCancel = $scope.$watch "text", textWatch

      interruptWatch = (f) ->
        textWatchCancel()
        f()
        textWatchCancel = $scope.$watch "text", textWatch

      $element.keydown (e) ->
        return true if menu is undefined
        switch e.keyCode
          when keyCodes.upArrow   then $scope.$apply -> menu.up()
          when keyCodes.downArrow then $scope.$apply -> menu.down()
          when keyCodes.enter      then $scope.$apply -> menu.take()
          when keyCodes.escape     then $scope.$apply -> menu.cancel()
          else return true

        e.stopPropagation()
        e.preventDefault()
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

.directive('clickStopPropagation', [
  ->
    link: (scope, iElement) ->
      $(iElement).on "click", (e) ->
        e.stopPropagation()
])