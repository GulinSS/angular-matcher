angular.module('contextMenu.directives', [])
.directive('dropdownMenu', [
  ->
    restrict: "E"
    replace: true
    scope: true
    templateUrl: "app/contextMenu/menu.jade"
    link: ($scope) ->

])

