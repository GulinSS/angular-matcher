angular.module("contextMenu", [
  "contextMenu.directives"
  "contextMenu.services"
  "app.contextMenu.templates"
])
.run [
  "$rootScope"
  "$document"
  "$compile"
  ($rootScope, $document, $compile) ->
    element = angular.element "<dropdown-menu></dropdown-menu>"
    angular.element($document.body).append element

    $compile(element)($rootScope)
]
