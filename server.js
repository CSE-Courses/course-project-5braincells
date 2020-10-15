const express = require('express');
const app = express();
const bodyParser = require('body-parser')

app.use(bodyParser.json())

require('./routes/user')(app);
require('./routes/rating')(app);
require('./routes/listing')(app);


module.exports = app;
