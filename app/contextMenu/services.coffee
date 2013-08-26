angular.module("contextMenu.services", [])

.factory("contextMenu", [
  ->
    menu = null

    (instance) ->
      if instance isnt undefined
        menu = instance
        return

      menu
])