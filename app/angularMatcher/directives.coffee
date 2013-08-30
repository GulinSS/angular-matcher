angular.module('angularMatcher.directives', [])
.directive('angularMatcher', [
  ->
    controller: "Matcher"
    replace: true
    restrict: "E"
    templateUrl: 'app/angularMatcher/matcher.jade'
    link: (scope, iElement, iAttrs, controller) ->
      iElement.on "click", (e) ->
        e.preventDefault()
        e.stopPropagation()
        iElement.find(".last").focus()

      scope.$watch "filters", (v, old) ->
        return if v is undefined
        return if old is undefined
        return if v.length is old.length
        $(".value:last-child", iElement).focus()
])