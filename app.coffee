koa = require 'koa'
app = koa()
 
# Traditional Node-style callback async pattern (neither a promise nor a thunk)
getSquareValueAsync = (num, callback) -> setTimeout (-> callback null, num * num), 0
# Wrap the async operation in a 'thunk' so that Koa understands it
getSquareValueThunk = (num) -> return (callback) -> getSquareValueAsync num, callback

app.use -->
  # Here is the important bit of application logic for this example.
  # We make use of a series of async operations without callbacks.
  square = yield getSquareValueThunk 16
  @body = "Square of 16 is #{square}."
 
app.listen 8080
