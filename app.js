const {app}=require("./index")
const http=require("http")
const server = http.createServer(app);

const {Server} = require("socket.io");
const db=require('./src/config')

const io = new Server(server, {
    cors: {
      origin: "http://localhost:3000",
      methods:["GET","POST"]
  
    },
  });
  
  io.on('connection', (socket) => {
    socket.on('newBid', bid => {
    console.log('New bid received:', bid);
    io.emit("send bid", bid);
    });
  });
server.listen(
    3001,
  );