'use strict'

describe "autoInput", ->
  describe "directives:", ->

    beforeEach module "autoInput"

    describe "dynamicWidth\n", ->
      test = (asserts) ->
        inject ($compile, $rootScope) ->
          scope = $rootScope.$new()
          element = $compile("<input type='text' ng-model='text' data-dynamic-width/>")(scope)
          asserts.call
            element: element
            scope: scope

      it "has 2px width with empty content", test ->
        expect(@element.width()).toBe 2

      it "expands input's width to display the entire text string", test ->
        @scope.$apply =>
          @scope.text = "aa"
        width_aa = @element.width()
        expect(width_aa > 2).toBe true

        @scope.$apply =>
          @scope.text = "aaa"
        expect(@element.width() > width_aa).toBe true

        @scope.$apply =>
          @scope.text = "aa"
        expect(@element.width() is width_aa).toBe true

    describe "autoInput\n", ->
      it "sets input value from result attribute if it is available", ->
        inject ($compile, $rootScope) ->
          scope = $rootScope.$new()
          angular.extend scope,
            result:
              text: "abc"
            key:
              prop1: "value1"
            resolver: jasmine.createSpy("resolver")

          element = $compile("<auto-input result='result' key='key' resolver='resolver'/>")(scope)
          scope.$apply()

          expect(element.val()).toBe scope.result.text


