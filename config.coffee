exports.config =
  # See docs at http://brunch.readthedocs.org/en/latest/config.html.
  conventions:
    ignored: ///^(
        vendor.*\.less    # exclude vendor less files, cause them must be css already
        |.+node_modules.+ # exclude all entities from node_modules
        |.+_.+\..+)$      # exclude all entities with '_' before file extension
      ///
  modules:
    definition: false
    wrapper: false
  paths:
    public: '_public'
  files:
    javascripts:
      joinTo:
        'js/app.js': /^app/
        'js/vendor.js': /^vendor/
        'test/scenarios.js': /^test(\/|\\)e2e/
      order:
        before: [
          'vendor/console-polyfill/index.js'
          'vendor/jquery/jquery.js'
          'vendor/angularjs-bower/angular.js'                  
          'vendor/bootstrap/docs/assets/js/bootstrap.js'
        ]

    stylesheets:
      joinTo:
        'css/app.css': /^(app|vendor)/

    templates:
      joinTo: 
        'js/dontUseMe' : /^app/ # dirty hack for Jade compiling.

  plugins:
    jade:
      pretty: yes # Adds pretty-indentation whitespaces to output (false by default)
    jade_angular:
      modules_folder: 'partials'
      locals: {}

    bower:
      extend:
        "bootstrap" : 'vendor/bootstrap/docs/assets/js/bootstrap.js'
        "angularjs-bower": [
          'vendor/angularjs-bower/angular.js'
          'vendor/angularjs-bower/angular-loader.js'
          'vendor/angularjs-bower/angular-resource.js'
          'vendor/angularjs-bower/angular-sanitize.js'
          'vendor/angularjs-bower/angular-mocks.js'
        ]
        "styles": []
      asserts:
        "img" : /bootstrap(\\|\/)img/
        "font": /font-awesome(\\|\/)font/


  # Enable or disable minifying of result js / css files.
  # optimize: true
