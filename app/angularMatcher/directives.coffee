angular.module('angularMatcher.directives', [])
.directive('angularMatcher', [
  ->
    controller: "Matcher"
    replace: true
    scope:
      matches: "="
      suggestions: "&"
    restrict: "E"
    templateUrl: 'app/angularMatcher/matcher.jade'
    link: (scope, iElement, iAttrs, controller) ->
      iElement.on "click", (e) ->
        e.preventDefault()
        e.stopPropagation()
        iElement.find(".last").focus()
])
