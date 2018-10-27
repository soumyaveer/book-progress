const path = require('path');
const MiniCssExtractPlugin = require("mini-css-extract-plugin");

module.exports = {
  entry: [
    path.join(__dirname, 'app', 'js', 'App.js'),
    path.join(__dirname, 'app', 'css', 'styles.scss')
  ],

  plugins: [
    new MiniCssExtractPlugin({
      filename: '[name].css',
    })
  ],

  module: {
    rules: [
      {
        test: /\.jsx?$/,
        exclude: /node_modules/,
        use: 'babel-loader'
      },
      {
        test: /\.(sa|sc|c)ss$/,
        use: [
          MiniCssExtractPlugin.loader,
          'css-loader',
          'sass-loader'
        ]
      }
    ]
  },

  output: {
    path: path.join(__dirname, 'public', 'dist'),
    filename: '[name].js'
  }
};