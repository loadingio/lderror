# Change Logs

## v2.0.0

 - add 1024 `limited by throttling`
 - add 998 `skipped`
 - add 1025 `runtime error`
 - upgrade modules
 - release with compact directory structure
 - add `browser` field in `package.json`.
 - further minimize generated js file with mangling and compression



## v1.1.5

 - also support pattern like `lderror(1000, "message")`


## v1.1.4

 - return unknown lderror with unrecognized id.
 - add 1023 `lderror testing` error


## v1.1.3

 - support constructing via function invocation.


## v1.1.2

 - prevent potential prototype pollution issue
 - unwrap in code, instead wrap with compiler
 - no print livescript header


## v1.1.1

 - fix bug: main file should point to `index.js`, instead of `lde.js` now.


## v1.1.0

 - rename `lde.js` to `index.js`


## v1.0.1

 - overwrite `message` not only if it's undefined but also if it's empty
 - populate in window only if module is not defined.


## v1.0.0

 - rename to `lderror`.


## v0.0.5

 - add 1021 email not verified
