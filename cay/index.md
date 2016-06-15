# Introduction

[Cay](https://github.com/coralproject/cay) is the front-end application for the Coral Community Tools.

## Structure and development

The app is a series of React components compiled into modules with [webpack](http://webpack.github.io/).

The basic idea is that the build process results in a `bundle.js` file containing all javascript and css. CSS cross-browser issues, ES6 transpilation, minification, etc, is all handled by webpack. `bundle.js` lives in-memory until build time (`npm run build`).

The meat of the application lives in the `/src` folder. Components are grouped into domains. For instance, everything that has to do with creating, viewing and editing Searches lives in the `search` folder. This includes redux reducers and action files for that domain.

Note: the reducers are combined in `/src/app/MainReducer.js`.
