const UglifyJSPlugin = require('uglifyjs-webpack-plugin')
module.exports = {
    entry: './build/app.js',
    output: {
        path: '/build',
        filename: 'app.bundle.js'
    },
    module: {
      loaders: [{
        test: /\.js$/,
        exclude: /node_modules/,
        loader: 'babel-loader'
      }]
    },
    resolve: {
      mainFields: [
        "webpack",
        "module",
        "browser",
        "web",
        "browserify",
        ["jam", "main"],
        "main"
      ],
      alias: {
          d3: 'd3/index.js'
      }
    },
    // ,plugins: [
    //   new UglifyJSPlugin()
    // ]
};
