# Change Logs

## v2.4.5 (upcoming)

 - add 1043 `additional token required` 
 - add 1044 `unsupported encoding`


## v2.4.4

 - add 1041 `resource possibly blocked by client`
 - add 1042 `3rd party service error`
 - fix bug: lderror.id didn't check argument for existence before accessing its property


## v2.4.3

 - add 1036 `reused passwords not allowed`
 - add 1037 `offline`
 - add 1038 `file too large`
 - add 1039 `payment rejected` for suspicious user
 - add 1040 `registration closed`


## v2.4.2

 - update payload only if given parameter is an object


## v2.4.1

 - remove unused log


## v2.4.0

 - add 1034 `user not found`
 - add 1035 `payment rejected`
 - support payload as parameter, passed along with error object


## v2.3.3

 - add 1033 `view failed to render`
 - fix bug: exception in unhandled rejection handler should be thrown within `setTimeout` for error to be triggered.


## v2.3.2

 - add 1030 `password mismatched`, 1031 `weak password`.
 - add 1032 `credential scheme mismatched`
 - for better exception logging, still throw error in error handler if no id for the given error


## v2.3.1

 - add 1029 `session data corrupted`


## v2.3.0

 - add 1028 `resource unavailable`
 - keep an original error object in `error`
 - add event handler for taking care lderror in `error` and `unhandledrejection` events


## v2.2.0

 - add 1027 `missing config`
 - add api `message` for getting message corresponding to given id


## v2.1.2

 - add 1026 `not applicable`


## v2.1.1

 - fix bug: id is gone when wrap lderror twice ( lderror(lderror(404)) )


## v2.1.0

 - fix typo in 1010 error ( `recaptcha` to `captcha` )
 - add `lderror.handler` for error handling
 - update id reserved range for http code from 400 ~ 599 to 100 ~ 599
 - upgrade cached-path-relative for vulnerability fixing


## v2.0.1

 - include `id` in dummy message if message is not found for specific id.


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
