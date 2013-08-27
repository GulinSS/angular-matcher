"use strict"

describe "contextMenu", ->
  describe "viewModels", ->
    describe "Element:\n", ->
      beforeEach module "contextMenu.viewModels"

      test = (asserts) ->
        inject (Element) ->
          element = new Element
            text: "element 1"

          asserts.call
            instance: element

      it "exists", inject (Element) ->
        expect(angular.isFunction(Element)).toBe true

      it "is a class and accepts dto as parameter", test ->
        expect(@instance.text).toBe "element 1"
        expect(@instance.active).toBeDefined()
