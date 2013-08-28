module.exports = function(config) {
  config.set({
    basePath: '../',
    files: [
      '_public/js/vendor.js',
      '_public/js/*.js',

      'vendor/jquery-simulate/jquery.simulate.js',

      // Specs
      // 'test/tools/*.coffee',
      // 'test/jquery.simulate.js',
      'test/unit/**/*.spec.coffee'
    ],
    frameworks: ['jasmine'],
    exclude: [],
    reporters: ['dots'],
    port: 3334,
    runnerPort: 9100,
    logLevel: 'karma.LOG_ERROR',
    autoWatch: true,

    // Start these browsers, currently available:
    // - Chrome
    // - ChromeCanary
    // - Firefox
    // - Opera
    // - Safari
    // - PhantomJS
    browsers: ['PhantomJS'],
    plugins: [
      'karma-jasmine',
      'karma-phantomjs-launcher',
      'karma-coffee-preprocessor'
    ],

    // Continuous Integration mode
    // if true, it capture browsers, run tests and exit
    singleRun: false
  });
};