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
      valueMock =
        text: "mock"

      promiseMock =
        then: (f) -> f valueMock

      test = (asserts) ->
        inject ($compile, $rootScope) ->
          scope = $rootScope.$new()
          angular.extend scope,
            result:
              text: "abc"
            key:
              prop1: "value1"
            resolver: jasmine.createSpy("resolver").andReturn promiseMock


          element = $compile("<auto-input result='result' key='key' resolver='resolver'/>")(scope)
          scope.$apply()
          asserts.call
            element: element
            scope: scope

      it "sets input value from result attribute if it is available", ->
        test ->
          expect(@element.val()).toBe @scope.result.text
          expect(@scope.resolver).not.toHaveBeenCalled()

      it "does nothing on empty text in input", ->
        test ->
          @element.val ""
          @element.trigger "input"

          expect(@scope.resolver).not.toHaveBeenCalled()

      it "does nothing on equal text in input", ->
        test ->
          @element.val @scope.result.text
          @element.trigger "input"

          expect(@scope.resolver).not.toHaveBeenCalled()

      it "execute resolver on change input text and treats its value as result", ->
        test ->
          value = "lorem ipsum"
          @element.val value
          @element.trigger "input"

          expect(@scope.resolver).toHaveBeenCalledWith(@scope.key, value)
          expect(@scope.result).toBe valueMock
          expect(@element.val()).toBe valueMock.text