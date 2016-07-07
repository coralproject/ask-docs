# Introduction

[Cay](https://github.com/coralproject/cay) is the front-end application for Coral.

It's made up of a series of [React](https://facebook.github.io/react/) components, compiled into modules with [webpack](http://webpack.github.io/).

The webpack build process results in a `bundle.js` file, which contains all Javascript and CSS for Cay. Common issues like CSS cross-browser issues, ES6 transpilation, and minification are all handled by webpack. `bundle.js` lives in-memory until build time (`npm run build`).

The meat of the application lives in the `/src` folder. Components are grouped into subdirectories based on their "domain": for instance, everything that has to do with creating, viewing and editing searches lives in the `search` folder. Similarly, everything having to do with tags lives in the `tags` folder.

The reducers are combined in `/src/app/MainReducer.js`.
