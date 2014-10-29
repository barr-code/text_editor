express = require 'express'
app = express()
http = require('http').Server(app)
fs = require 'fs'
io = require 'socket.io'

bodyParser = require 'body-parser'
app.use(bodyParser.urlencoded({ extended: false }))
app.use(require 'express-ejs-layouts')
app.set('view engine', 'ejs')

app.get '/', (req, res) ->
	fs.readdir 'code', (err, files) ->
		res.render('index', { files: files })

http.listen(3000)