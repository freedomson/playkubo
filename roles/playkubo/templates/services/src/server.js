const express = require("express");
const pu = require("pug");
const app = express()

app.use(express.static(__dirname + '/public'));
app.set('view engine', 'pug');

app.get('/', (req, res) => {
    res.render('index')
})

app.listen(8080, () => {
    console.log('http://localhost:8080')
})