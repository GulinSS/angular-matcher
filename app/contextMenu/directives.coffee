angular.module('contextMenu.directives', [])
.directive('dropdownMenu', [
  "contextMenu"
  (contextMenu) ->
    restrict: "E"
    replace: true
    scope: true
    templateUrl: "app/contextMenu/menu.jade"
    link: ($scope) ->
      contextMenu
        show: (elements, xy) ->
          # TODO: elements -- promise with array of result
          # TODO: element from elements must have field "text"
          # TODO: control menu via promises:
          # 1. set active to upper element
          # 2. set active to downer element
          # 3. get active element and hide

        cancel: ->
])

