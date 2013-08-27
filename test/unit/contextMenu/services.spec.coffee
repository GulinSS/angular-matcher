"use strict"

describe "contextMenu", ->
  describe "services", ->
    describe "contextMenu:\n", ->
      beforeEach module "contextMenu.services"
      beforeEach module "contextMenu.viewModels"

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

      it "produces flyweight facade for activation dropdown-menu", inject (contextMenu) ->
        expect(angular.isFunction(contextMenu)).toBeTruthy()

        result = contextMenu parameters

        angular.forEach [
          'cancel'
          'take'
          'down'
          'up'
        ], (v) ->
          expect(result[v]).toBeDefined("#{v}")
          expect(angular.isFunction(result[v])).toBeTruthy()

        expect(result.promise).toBeDefined("promise")
        expect(angular.isObject(result.promise)).toBeTruthy("promise is object")
        expect(result.promise.then).toBeDefined("promise.then")
        expect(angular.isFunction(result.promise.then)).toBeDefined("promise.then is method")

      it "appends .dropdown-menu element to DOM's body", inject (contextMenu, $document) ->
        contextMenu parameters

        $menu = $(".dropdown-menu", $document.attr("body"))

        expect($menu.length).toBe 1
        expect($("li", $menu).length).toBe 3, "it must appends correct count of elements"



      describe "Result object\n", ->
        it "should disappear on cancel method and reject a promise", inject (contextMenu) ->
          result = contextMenu parameters
          result.cancel()

          expect($(".dropdown-menu").length).toBe 0
          expect(true).toBe false #TODO: test for promise rejection

        it "should move .active class down at current position on down method", ->
          expect(true).toBe false
        it "should move .active class up at current position on up method", ->
          expect(true).toBe false
        it "should resolve promise on select method", ->
          expect(true).toBe false
        it "should resolve promise on click event of element", ->
          expect(true).toBe false

      describe "Produced scope\n", ->
        it "should attach method take to scope, which takes first parameter and resolve promise with it", ->
          expect(true).toBe false
        it "should attach method select to scope, which takes first parameter and change field 'selected' of this parameter to true", ->
          expect(true).toBe false