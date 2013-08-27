angular.module('contextMenu.directives', [])
.directive('dropdownMenu', [
  ->
    restrict: "E"
    replace: true
    templateUrl: "app/contextMenu/menu.jade"
    link: (scope) ->
      angular.extend scope,
        style:
          top  : scope.y
          left : scope.x
])

