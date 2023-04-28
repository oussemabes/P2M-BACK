"use strict";

const {
  app
} = require('./app');
const http = require('http');
require('dotenv').config();
const {
  Server
} = require("socket.io");
const server = http.createServer(app);
const mysql = require('mysql');
const db = require('./config');
db.connect(function (err) {
  if (err) throw err;
  console.log("Connected!");
});
const io = new Server(server, {
  cors: {
    origin: `http://139-144-162-115.ip.linodeusercontent.com`,
    methods: ["GET", "POST"]
  }
});
io.on('connection', socket => {
  socket.on('newBid', bid => {
    console.log('New bid received:', bid);
    io.emit("send bid", bid);
  });
});
async function createTables() {
  await db.query("CREATE TABLE IF NOT EXISTS categories (id INT(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,category VARCHAR(255),options VARCHAR(255),categoryImage VARCHAR(255));", function (err) {
    if (err) throw err;
    console.log("Categories TABLE created.");
  });
  await db.query("CREATE TABLE IF NOT EXISTS users (id INT(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,name VARCHAR(30),email VARCHAR(30),password VARCHAR(255),balance FLOAT);", function (err) {
    if (err) throw err;
    console.log("Products TABLE created.");
  });
  await db.query("CREATE TABLE IF NOT EXISTS products (id INT(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,owner_id INT(11) UNSIGNED,productName VARCHAR(27),category_id INT(11) UNSIGNED,productDescription VARCHAR(255),productImage VARCHAR(255),date DATETIME,FOREIGN KEY (category_id) REFERENCES categories(id));", function (err) {
    if (err) throw err;
    console.log("Products TABLE created.");
  });
  await db.query("CREATE TABLE IF NOT EXISTS bids (id INT(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,product_id INT(11) UNSIGNED ,user_id INT(11) UNSIGNED,bidAmount FLOAT,date DATETIME,FOREIGN KEY (product_id) REFERENCES products(id),FOREIGN KEY (user_id) REFERENCES users(id));", function (err) {
    if (err) throw err;
    console.log("Bids TABLE created.");
  });
}
createTables();
server.listen(process.env.SERVER_PORT, console.log("server is running at port http://localhost:3001"));
module.exports = server;