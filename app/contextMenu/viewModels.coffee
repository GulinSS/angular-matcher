angular.module("contextMenu.viewModels", [])
.factory("Element", [
  ->
    class Element
      constructor: (dto) ->
        defaults =
          text: ""
          selected: false

        angular.extend this, defaults, dto
])