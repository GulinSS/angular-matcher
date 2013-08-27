"use strict"

describe "contextMenu", ->
  describe "services", ->
    describe "contextMenu:\n", ->
      beforeEach module "contextMenu.services"
      beforeEach module "contextMenu.viewModels"

      test = (asserts) ->
        inject (contextMenu, $document, $rootScope) ->
          parameters =
            x: 10
            y: 20
            elements: [
              text: "Element 1"
            ,
              text: "Element 2"
            ,
              text: "Element 3"
            ]
          result = contextMenu parameters

          asserts.call
            $apply: $rootScope.$apply
            ctor: contextMenu
            instance: result
            parameters: parameters
            $menu: ->
              $(".dropdown-menu", $document.attr("body"))


      it "produces flyweight facade for activation dropdown-menu", test ->
        expect(angular.isFunction(@ctor)).toBeTruthy()

        angular.forEach [
          'cancel'
          'take'
          'down'
          'up'
        ], (v) =>
          expect(@instance[v]).toBeDefined("#{v}")
          expect(angular.isFunction(@instance[v])).toBeTruthy()

        expect(@instance.promise).toBeDefined("promise")
        expect(angular.isObject(@instance.promise)).toBeTruthy("promise is object")
        expect(@instance.promise.then).toBeDefined("promise.then")
        expect(angular.isFunction(@instance.promise.then)).toBeDefined("promise.then is method")

      it "appends .dropdown-menu element to DOM's body", test ->
        expect(@$menu().length).toBe 1

        expect(true).toBe false # TODO: test for x-y coords

        expect($("li", @$menu()).length).toBe @parameters.elements.length, "it must appends correct count of elements"
        @parameters.elements.forEach (v, i) =>
          expect($("a:eq(#{i})", @$menu()).val()).toBe v.text

      describe "Result object\n", ->
        it "should disappear on cancel method and reject a promise", test ->
          @instance.cancel()

          expect(@$menu().length).toBe 0
          expect(true).toBe false #TODO: test for promise rejection

        it "should select first element on init", test ->
          expect($("li.active:eq(0)", @$menu()).length).toBe 1

        it "should move .active class down at current position on down method", test ->
          $menu = @$menu()
          @instance.down()
          expect($("li.active:eq(1)", $menu).length).toBe 1

          @instance.down()
          expect($("li.active:eq(2)", $menu).length).toBe 1

          expect($("li.active", $menu).length).toBe 1

        it "should move .active class up at current position on up method", test ->
          $menu = @$menu()
          @instance.up()
          expect($("li.active:eq(2)", $menu).length).toBe 1

          @instance.up()
          expect($("li.active:eq(1)", $menu).length).toBe 1

          expect($("li.active", $menu).length).toBe 1

        it "should resolve promise on take method and hide itself", test ->
          resolve = jasmine.createSpy("on resolve")
          @instance.promise.then resolve

          @$apply =>
            @instance.take()

          expect(resolve.method.mostRecentCall.args[0].text).toBe @parameters.elements[0].text
          expect(@$menu().length).toBe 0

        it "should resolve promise on click event of element and hide itself", test ->
          resolve = jasmine.createSpy("on resolve")
          @instance.promise.then resolve

          @$apply =>
            $("li:eq(1) a", @$menu()).click()

          expect(resolve.method.mostRecentCall.args[0].text).toBe @parameters.elements[1].text
          expect(@$menu().length).toBe 0

      describe "Produced scope\n", ->
        it "should attach method take to scope, which takes first parameter and resolve promise with it", ->
          expect(true).toBe false
        it "should attach method select to scope, which takes first parameter and change field 'selected' of this parameter to true", ->
          expect(true).toBe false