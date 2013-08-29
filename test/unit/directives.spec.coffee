'use strict'

# jasmine specs for directives go here
describe "directives", ->

  beforeEach(module "app.directives")

  xdescribe "angularMatcherMatch\n", ->
    it "exists", ->
      expect(true).toBe false

    describe "parameters in the scope", ->
      it "expects 'suggestion' function for retrieve content of available filters and values", ->
        expect(true).toBe false

      it "expects 'filter' field as result of user interaction", ->
        expect(true).toBe false

      it "'filter' object must be instance of Filter viewModel class", ->
        expect(true).toBe false

    it "emits event 'angularMatcherMatch:selected' on result as first parameter", ->
      expect(true).toBe false

    describe "look and feel", ->
      it "moves cursor to a next input after correct selection on previous", ->
        expect(true).toBe false

      it "disables propogation of click events to parent DOM elements", ->
        expect(true).toBe false

  xdescribe "angularMatcher\n", ->
    it "exists", ->
      expect(true).toBe false

    describe "parameters in the scope", ->
      it "expects 'result' field as result of user interaction", ->
        expect(true).toBe false

      it "expects 'filter'", ->


  xit "should print current version", ->
    module ($provide) ->
      $provide.value "version", "TEST_VER"
      return

    inject ($compile, $rootScope) ->
      element = $compile("<span app-version></span>")($rootScope)
      expect(element.text()).toEqual "TEST_VER"


