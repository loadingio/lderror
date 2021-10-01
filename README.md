# lderror

Simple wrapper for Error object.

## Usage

lderror contains an `id` field for identify what kind of error it is. to create a lderror object, simply:

    new lderror(1000);
    new lderror("custom message", 1000);
    new lderror({message: "custom message", id: 1000});
    lderror(1000); /* auto new upon invocation */
    lderror("custom message"); /* by default, id will be 0 */

valid lderror object contains a field 'name' with value 'lderror', and an id field with values listed in `src/lde.ls`. Following demonstrates how to make a lderror-compatible error object with id 1000 by duck typing:

    new Error! <<< {id: 1000, name: "lderror"}

or

    Object.assign(new Error(), {id: 1000, name: "lderror"});


## Members

 * id - lderror deined error code.
 * message - custom error message (optional)
 * stack - stacktrace (optional)
 * code - http status code, if applicable (optional)


## Helper Functions

lderror exports several help functions for making use lderror easier:

 * `lderror.id(input)`
   - One can fetch the id from a valid lderror by accessing `id` field after verifying the `name` field, or use this handy function `lderror.id`:

         lderror.id(input)

     It will return 0 for non-lderror objects or strings, and return corresponding id if input is a lderror object.
 * `lderror.reject(...)`
   - For a shorthand of `Promise.reject(new lderror(...))`, one can use `lderror.reject(...)`.


## Customized information

Additional information can be added if needed:

 - redirect - instruct a redirect url in order to proper take care of this error. 


## License

MIT
