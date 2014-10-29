express = require 'express'
app = express()
http = require('http').Server(app)


app.get '/', (req, res) ->
	res.send('<h1>Hello world!</h1>')

http.listen(3000)