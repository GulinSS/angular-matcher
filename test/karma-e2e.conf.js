basePath = '../';

frameworks = ["requirejs"];

files = [
  'test/e2e/**/*.js',
  'test/e2e/**/*.coffee'
];

autoWatch = false;

browsers = ['PhantomJS'];

singleRun = true;

urlRoot = '/__testacular/';

proxies = {
  '/': 'http://localhost:3333/'
};

// compile coffee scripts
preprocessors = {
  '**/*.coffee': 'coffee'
};

plugins = [
  'karma-coffee-preprocessor',
  'karma-requirejs',
  'karma-phantomjs-launcher'
]