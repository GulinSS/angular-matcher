angular.module('angularMatcher.controllers', [])
.controller('Matcher', [
  '$scope'
  '$q'
  ($scope, $q) ->

    $scope.$watch "child", (v) ->
      if v isnt undefined
        $scope.filters.push v

      $scope.child = undefined

    angular.extend $scope,
      remove: (element) ->
        neededToDelete = $scope.filters.indexOf element
        $scope.filters.splice neededToDelete, 1

      filters: [
        text: "Body Type"
        value:
          text: "Sedan"
      ,
        text: "Manufacturer"
        value:
          text: "Mazda"
      ]


    #filters: [
    #  field: "Body Type"
    #  value: "Sedan"
    #,
    #  field: "Manufacturer"
    #  value: "Mazda"
    #,
    #  field: "Model"
    #  value: "6"
    #,
    #  field: "Year"
    #  value: "2007"
    #]

      showList: (key, text) ->
        $q.when [
          text: "#{text} 1"
        ,
          text: "#{text} 2"
        ,
          text: "#{text} 3"
        ]
])
