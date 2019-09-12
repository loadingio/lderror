# ldError

Simple wrapper for Error object.

## Usage

ldError contains an `id` field for identify what kind of error it is. to create a ldError object, simply:

 * new Error(100);
 * new Error("custom message", 100);
 * new Error({message: "custom message", id: 100});
 * new Error("custom message");
   - by default, id will be 0.


## License

MIT
