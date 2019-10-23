# ldError

Simple wrapper for Error object.

## Usage

ldError contains an `id` field for identify what kind of error it is. to create a ldError object, simply:

 * new Error(1000);
 * new Error("custom message", 1000);
 * new Error({message: "custom message", id: 1000});
 * new Error("custom message");
   - by default, id will be 0.


## Members

 * id - ldError deined error code.
 * message - custom error message (optional)
 * stack - stacktrace (optional)
 * code - http status code, if applicable (optional)


## License

MIT
