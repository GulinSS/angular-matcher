angular.module('angularMatcher.controllers', [])
.controller('Matcher', [
  '$scope'
  '$element'
  ($scope, $element) ->
    $scope.$watch "child", (v) ->
      if v isnt undefined
        watch = $scope.$watchCollection "matches", ->
          #TODO solve this hack
          setTimeout ->
            $(".value:last-child", $element).focus()
          , 0
          watch()
        $scope.matches.push v

      $scope.child = undefined

    # Strange Angular behavior with passing argument to scope
    $scope.suggestions = $scope.suggestions()

    $scope.remove = (element) ->
      neededToDelete = $scope.matches.indexOf element
      $scope.matches.splice neededToDelete, 1


])
