# ldError

Simple wrapper for Error object.

## Usage

ldError contains an `id` field for identify what kind of error it is. to create a ldError object, simply:

 * new ldError(1000);
 * new ldError("custom message", 1000);
 * new ldError({message: "custom message", id: 1000});
 * new ldError("custom message");
   - by default, id will be 0.

valid ldError object contains a field 'name' with value 'ldError', and an id field with values listed in `src/lde.ls`. Following demonstrates how to make a ldError-compatible error object with id 1000:

    new Error! <<< {id: 1000, name: "ldError"}

or

    Object.assign(new Error(), {id: 1000, name: "ldError"});


## Members

 * id - ldError deined error code.
 * message - custom error message (optional)
 * stack - stacktrace (optional)
 * code - http status code, if applicable (optional)


## Helper Functions

ldError exports several help functions for making use ldError easier:

 * `ldError.id(input)`
   - One can fetch the id from a valid ldError by accessing `id` field after verifying the `name` field, or use this handy function `ldError.id`:

         ldError.id(input)

     It will return 0 for non-ldError objects or strings, and return corresponding id if input is a ldError object.
 * `ldError.reject(...)`
   - For a shorthand of `Promise.reject(new ldError(...))`, one can use `ldError.reject(...)`.


## License

MIT
