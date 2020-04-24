# ldError

Simple wrapper for Error object.

## Usage

ldError contains an `id` field for identify what kind of error it is. to create a ldError object, simply:

 * new Error(1000);
 * new Error("custom message", 1000);
 * new Error({message: "custom message", id: 1000});
 * new Error("custom message");
   - by default, id will be 0.

valid ldError object contains a field 'name' with value 'ldError', and an id field with values listed in `src/lde.ls`. One can fetch the id from a valid ldError by accessing `id` field after verifying the `name` field, or use this handy function `ldError.id`:

    ldError.id(input)

It will return 0 for non-ldError objects or strings, and return corresponding id if input is a ldError object.


## Members

 * id - ldError deined error code.
 * message - custom error message (optional)
 * stack - stacktrace (optional)
 * code - http status code, if applicable (optional)



## License

MIT
