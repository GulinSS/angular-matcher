angular.module("contextMenu.viewModels", [])
.factory("Element", [
  ->
    class Element
      constructor: (dto) ->
        defaults =
          text: ""
          active: false

        angular.extend this, defaults, dto
])