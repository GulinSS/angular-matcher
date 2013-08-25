angular.module('app.viewModels', [])

.factory("Matcher", [
  ->
    class Matcher
      constructor: ->

      expandHelper: (box) ->
])

.factory("Match", [
  ->
    class Match
      constructor: (@element) ->

      # Get element boundaries
      # @return object constructed by Box
      getHelperPosition: ->



])

.factory("Box", [
  ->
    # Describes element's boundaries
    # @example
    # element.getBox().top.right #x,y coords of top-right corner
    # element.getBox().right.bottom #x,y coords of right-bottom corner
    class Box
])

.factory("XY", [
  ->
    class XY
      x: null
      y: null

      # Calculates mean of x-y values
      mean: ->
])