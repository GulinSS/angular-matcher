'use strict'

describe "autoInput", ->
  describe "directives:", ->

    beforeEach module 'autoInput.directives'

    describe "clickStopPropagation", ->
      xit "disables propogation of click events to parent DOM elements", ->
        expect(true).toBe false

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
      beforeEach module 'autoInput.constants'
      beforeEach module 'app.autoInput.templates'

      contextMenuSpyResult =
        promise:
          then: jasmine.createSpy "contextMenu:promise.then"
        cancel: jasmine.createSpy "contextMenu:cancel"
        down: jasmine.createSpy "contextMenu:down"
        take: jasmine.createSpy "contextMenu:take"
        up: jasmine.createSpy "contextMenu:up"

      contextMenuSpy = jasmine.createSpy("contextMenu").andReturn contextMenuSpyResult
      beforeEach module ($provide) ->
        $provide.value "contextMenu", contextMenuSpy
        return

      valueStub = [
        text: "value 1"
      ,
        text: "value 2"
      ,
        text: "value 3"
      ]

      promiseMock =
        then: (f) -> f valueStub

      test = (asserts) ->
        inject ($compile, $rootScope, keyCodes) ->
          scope = $rootScope.$new()
          angular.extend scope,
            result:
              text: "abc"
            key:
              prop1: "value1"
            suggestions: jasmine.createSpy("suggestions").andReturn promiseMock


          element = $compile("<auto-input result='result' key='key' suggestions='suggestions'/>")(scope)
          scope.$apply()
          asserts.call
            keyCodes: keyCodes
            element: element
            scope: scope

      it "sets input value from result attribute if it is available", ->
        test ->
          expect(@element.val()).toBe @scope.result.text
          expect(@scope.suggestions).not.toHaveBeenCalled()

      it "does nothing on empty text in input", ->
        test ->
          @element.val ""
          @element.trigger "input"

          expect(@scope.suggestions).not.toHaveBeenCalled()

      it "does nothing on equal text in input", ->
        test ->
          @element.val @scope.result.text
          @element.trigger "input"

          expect(@scope.suggestions).not.toHaveBeenCalled()

      xit "if result becomes undefined it clear text in input", ->
        expect(true).toBe false

      describe "suggestions workflow\n", ->
        value = "lorem ipsum"

        # Used for force initialization menu
        testInner = (asserts) ->
          test ->
            @element.val value
            @element.trigger "input"

            asserts.call this

        it "executes request for suggestions on change input text and shows contextMenu", testInner ->
          ['x', 'y', 'elements'].forEach (v) ->
            expect(contextMenuSpy.mostRecentCall.args[0][v]).toBeDefined()
          expect(@scope.suggestions).toHaveBeenCalledWith(@scope.key, value)
          expect(contextMenuSpy.mostRecentCall.args[0].elements).toBe valueStub
          expect(contextMenuSpy.mostRecentCall.args.length).toBe 1

        it "should treats selected value in contextMenu as result", testInner ->
          @scope.$apply ->
            contextMenuSpyResult.promise.then.mostRecentCall.args[0](valueStub[0])

          expect(@element.val()).toBe valueStub[0].text
          expect(@scope.result).toBe valueStub[0]

        it "should change value of result to undefined on rejection of contextMenu", testInner ->
          @scope.$apply ->
            contextMenuSpyResult.promise.then.mostRecentCall.args[1]()

          expect(@scope.result).toBe undefined

        describe "for keyboard events", ->
          it "should execute down method of contextMenu on down arrow keydown", testInner ->
            @element.simulate "keydown", keyCode: @keyCodes.downArrow

            expect(contextMenuSpyResult.down).toHaveBeenCalled()

          it "should execute up method of contextMenu on up arrow keydown", testInner ->
            @element.simulate "keydown", keyCode: @keyCodes.upArrow

            expect(contextMenuSpyResult.up).toHaveBeenCalled()

          it "should execute cancel method of contextMenu on escape keydown", testInner ->
            @element.simulate "keydown", keyCode: @keyCodes.escape

            expect(contextMenuSpyResult.cancel).toHaveBeenCalled()

          it "should execute take method of contextMenu on enter keydown", testInner ->
            @element.simulate "keydown", keyCode: @keyCodes.enter

            expect(contextMenuSpyResult.take).toHaveBeenCalled()
