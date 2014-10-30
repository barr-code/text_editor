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
	console.log('Here are your files, mate.')

app.get '/edit', (req, res) ->
	fileName = req.query.file
	codeMirrorDisabled = (process.env.NODE_ENV == 'test')

	fs.readFile('code/' + fileName, (err, data) ->
		if err
			res.render 'error'
		else
			lang = { rb: 'ruby', js: 'javascript'}[fileName.slice(-2)]
			res.render 'edit', { fileName: fileName, fileContents: data, language: lang,
			codeMirrorDisabled: codeMirrorDisabled })

app.post '/files', (req, res) ->
	fileName = req.query.file
	console.log(req.body.content)
	fs.writeFile(('code/' + fileName), req.body.content.trim)
	fs.readdir 'code', (err, files) ->
		res.render('index', { files: files })

http.listen(3000)