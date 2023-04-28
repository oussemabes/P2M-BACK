"use strict";

const express = require("express");
const app = express();
require('dotenv').config();
const cors = require('cors');
const bodyparser = require('body-parser');
const http = require("http");
app.use(cors());
const server = http.createServer(app);
const path = require("path");
app.use(express.json());
app.use(express.static(path.join(__dirname, '/public')));

// body-parser middleware use
app.use(bodyparser.json());
app.use(bodyparser.urlencoded({
  extended: true
}));

//import routes
const authRoute = require('./routes/auth');
const productRoute = require('./routes/product');
const verifyTokenRoute = require('./routes/verifyToken');
const bidRoute = require('./routes/bid');

//route middlewares 
app.use('/api/user', authRoute);
app.use('/api/auction', productRoute);
app.use('/api/verifyToken', verifyTokenRoute);
app.use('/api/bid', bidRoute);
module.exports = {
  app
};