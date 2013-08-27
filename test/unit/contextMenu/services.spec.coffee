"use strict"

describe "contextMenu", ->
  describe "services", ->
    describe "contextMenu:\n", ->
      beforeEach module "contextMenu"
      beforeEach ->
        $(".dropdown-menu").remove()

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
          $rootScope.$apply()

          asserts.call
            $apply: angular.bind $rootScope, $rootScope.$apply
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

        expect(@instance.scope).toBeDefined("scope")
        expect(@instance.promise).toBeDefined("promise")
        expect(angular.isObject(@instance.promise)).toBeTruthy("promise is object")
        expect(@instance.promise.then).toBeDefined("promise.then")
        expect(angular.isFunction(@instance.promise.then)).toBeDefined("promise.then is method")

      it "appends .dropdown-menu element to DOM's body", test ->
        expect(@$menu().length).toBe 1

        position = @$menu().position()

        expect("#{position.left}px").toBe @instance.scope.x, "left position"
        expect("#{position.top}px").toBe @instance.scope.y, "top position"

        expect($("li", @$menu()).length).toBe @parameters.elements.length, "it must appends correct count of elements"
        @parameters.elements.forEach (v, i) =>
          expect($("a:eq(#{i})", @$menu()).text()).toBe v.text

      describe "Result object\n", ->
        it "should disappear on cancel method and reject a promise", test ->
          resolve = ->
          reject = jasmine.createSpy("rejection")
          @instance.promise.then resolve, reject

          @$apply => @instance.cancel()

          expect(@$menu().length).toBe 0
          expect(reject).toHaveBeenCalled()

        it "should select first element on init", test ->
          expect($("li.active:eq(0)", @$menu()).length).toBe 1

        it "should move .active class down at current position on down method", test ->
          $menu = @$menu()

          @$apply => @instance.down()
          expect($("li:eq(1)", $menu).hasClass("active")).toBeTruthy 'li.active:eq(1)'

          @$apply => @instance.down()
          expect($("li:eq(2)", $menu).hasClass("active")).toBeTruthy 'li.active:eq(2)'

          @$apply => @instance.down()
          expect($("li:eq(0)", $menu).hasClass("active")).toBeTruthy 'li.active:eq(0)'

          expect($("li.active", $menu).length).toBe 1

        it "should move .active class up at current position on up method", test ->
          $menu = @$menu()

          @$apply => @instance.up()
          expect($("li:eq(2)", $menu).hasClass("active")).toBeTruthy 'li.active:eq(2)'

          @$apply => @instance.up()
          expect($("li:eq(1)", $menu).hasClass("active")).toBeTruthy 'li.active:eq(1)'

          @$apply => @instance.up()
          expect($("li:eq(0)", $menu).hasClass("active")).toBeTruthy 'li.active:eq(0)'

          @$apply => @instance.up()
          expect($("li:eq(2)", $menu).hasClass("active")).toBeTruthy 'li.active:eq(2)'

          expect($("li.active", $menu).length).toBe 1

        it "should resolve promise on take method and hide itself", test ->
          resolve = jasmine.createSpy("on resolve")
          @instance.promise.then resolve

          @$apply =>
            @instance.take()

          expect(resolve.mostRecentCall.args[0].text).toBe @parameters.elements[0].text
          expect(@$menu().length).toBe 0

        it "should resolve promise on click event of element and hide itself", test ->
          resolve = jasmine.createSpy("on resolve")
          @instance.promise.then resolve

          $("li:eq(1) a", @$menu()).click()

          expect(resolve.mostRecentCall.args[0].text).toBe @parameters.elements[1].text
          expect(@$menu().length).toBe 0

      describe "Produced scope\n", ->
        it "should attach methods 'take' and 'select' to scope", test ->
          expect(angular.isFunction(@instance.scope.take)).toBeDefined('take')
          expect(angular.isFunction(@instance.scope.select)).toBeDefined('select')

        it "should attach method take to scope, which takes first parameter and resolve promise with it", test ->
          resolve = jasmine.createSpy("on resolve")
          @instance.promise.then resolve

          @$apply =>
            @instance.scope.take @instance.scope.elements[0]

          expect(resolve.mostRecentCall.args[0].text).toBe @parameters.elements[0].text
          expect(@$menu().length).toBe 0

        it "should attach method select to scope, which takes first parameter and change field 'selected' of this parameter to true", test ->
          $menu = @$menu()

          @$apply =>
            @instance.scope.select @instance.scope.elements[1]

          expect($("li:eq(1)", $menu).hasClass("active")).toBeTruthy("li:eq(1)")
          expect($("li.active", $menu).length).toBe 1, "li.active"
          expect(@$menu().length).toBe 1
