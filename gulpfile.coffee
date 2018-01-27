'use strict'
gulp = require('gulp')
plugins = require('gulp-load-plugins')({
  rename: {
    'gulp-gh-pages': 'github',
    'gulp-minify-css': 'mincss',
    'gulp-mustache-plus': 'mustache'
  }
})
exec = require('child_process').exec
nib = require('nib')
webpack = require('webpack-stream')
watch = plugins.watch

# options
options = require './options'
editJSON = require 'edit-json-file'
configFile = editJSON './options.json'
options.prefixUrl = 'http://'+options.website.host
if options.website.port isnt ''
  options.prefixUrl += ':' + options.website.port

# --- Tasks --- #
gulp.task 'init', (cb) ->
  gulp.src('options.json').pipe prompt.confirm {
      type: 'input'
      name: 'projectname'
      message: 'Please enter project name'
    }, (res) ->
      console.log 'response: ', res
  exec 'rm -rf .git'
  exec 'git init'
  exec 'rm README.md'
  exec 'touch README.md'
  exec 'npm install', (err, stdout, stderr) ->
    console.log stdout
    console.log stderr

# Lint coffeescript for errors
gulp.task 'lint', ->
  gulp.src("./src/coffee/*.coffee")
  .pipe plugins.coffeelint()
  .pipe plugins.coffeelint.reporter()

# Compile coffeescript
gulp.task 'coffee', gulp.series 'lint', ->
  gulp.src("./src/coffee/*.coffee")
  .pipe plugins.coffee(bare: true).on('error', plugins.util.log)
  .pipe plugins.filesize()
  .pipe gulp.dest("./build/")

# Create webpack bundle
gulp.task "webpack", gulp.series 'coffee', ->
  gulp.src("./build/app.js")
  .pipe webpack( require('./webpack.config.js') )
  .pipe gulp.dest("./build/")

# Compile stylus to CSS
gulp.task "stylus", ->
  gulp.src("./src/styl/style.styl")
  .pipe plugins.stylus(use: [nib()])
  .pipe plugins.mincss(keepBreaks: true)
  .pipe plugins.filesize()
  .pipe gulp.dest("./build/")

# Compile mustache partials to HTML
gulp.task "mustache", ->
  gulp.src(["./src/tmpl/*.mustache"])
  .pipe(plugins.mustache(options, {},
    header: "./src/tmpl/partials/header.mustache"
    body: "./src/tmpl/partials/body.mustache"
    footer: "./src/tmpl/partials/footer.mustache"
  ))
  .pipe(plugins.rename(extname: ".html"))
  .pipe(plugins.htmlmin(
    collapseWhitespace: true
    collapseBooleanAttributes: true
    removeAttributeQuotes: true
    removeScriptTypeAttributes: true
    removeStyleLinkTypeAttributes: true
  ))
  .pipe gulp.dest("./build/")

# Copy data files (CSV & JSON) from /data/ to /build/data/
gulp.task "data", ->
  gulp.src([
    "./src/data/*.csv",
    "./src/data/*.json"
  ])
  .pipe plugins.filesize()
  .pipe gulp.dest("./build/data/")

# Copy raster images from /img/ to /build/img/
gulp.task "img", ->
  gulp.src([
    "./src/img/*.png",
    "./src/img/*.gif",
    "./src/img/*.jpg"])
  .pipe plugins.filesize()
  .pipe gulp.dest("./build/img/")

# Copy svg from /img/ to /build/img/
gulp.task "svg", ->
  gulp.src(["./source/img/*.svg"])
  .pipe plugins.filesize()
  .pipe gulp.dest("./build/img/")

# Publish to gh-pages
gulp.task 'github', ->
  gulp.src('./build/**/*')
    .pipe plugins.github()

# Start a local webserver for development
gulp.task "webserver", ->
  gulp.src("./build/")
  .pipe plugins.webserver(
    host: options.website.host
    port: options.website.port
    fallback: "build/index.html"
    livereload: true
    directoryListing: false
  )

# Watch files for changes and livereload when detected
# gulp.task "watch", ->
#   watch "src/coffee/*.coffee", {name: 'App'}, (events, done) -> gulp.task "webpack"
#   watch "src/styl/*.styl", {name: 'Stylus'}, (events, done) -> gulp.task "stylus"
#   watch [ "src/tmpl/*", "src/tmpl/partials/*" ], {name: 'Mustache'}, (events, done) -> gulp.task "mustache"
#   watch "src/data/*", {name: 'Data'}, (events, done) -> gulp.task "data"
#   watch "src/img/*", {name: 'Images'}, (events, done) -> gulp.task "img"

gulp.watch 'src/coffee/*.coffee', gulp.series 'coffee', 'webpack'
gulp.watch 'src/styl/*.styl', gulp.parallel 'stylus'
gulp.watch ['src/tmpl/*', 'src/tmpl/partials/*'], gulp.parallel 'mustache'
gulp.watch 'src/data/*', gulp.parallel 'data'
gulp.watch 'src/img/*', gulp.parallel 'img'


# gulp.task "default", gulp.series("webpack", "stylus", "mustache", "data", "img", "watch", "webserver"), -> gulp

gulp.task "default", gulp.series [
  "webpack"
  "stylus"
  "mustache"
  "data"
  "img"
  "webserver"
], -> gulp

gulp.task "build", gulp.series [
  "webpack"
  "stylus"
  "mustache"
  "data"
  "img"
], -> gulp
