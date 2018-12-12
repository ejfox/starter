const UglifyJSPlugin = require('uglifyjs-webpack-plugin')
const webpack = require('webpack')
const HardSourceWebpackPlugin = require('hard-source-webpack-plugin');

module.exports = {
    entry: './build/app.js'
    ,watch: false
    ,mode: 'development'
    ,output: {
        path: '/build',
        filename: 'app.bundle.js'
    }
    ,plugins: [
      // new HardSourceWebpackPlugin()
      // new UglifyJSPlugin()
      new webpack.ProvidePlugin({
        d3: 'd3'
      })
    ]
};
