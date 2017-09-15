const WebSocket = require('ws');
const uuid = require('node-uuid');

const clients = [];

const wss = new WebSocket.Server({
  port: 5555,
  path: '/websocket'
});

wss.broadcastAll = function broadcast(data) {
  wss.clients.forEach(function each(client) {
    if (client.readyState === WebSocket.OPEN) {
      client.send(data);
    }
  });
};

wss.broadcast = function broadcast(data, ws) {
  wss.clients.forEach(function each(client) {
    if (client !== ws && client.readyState === WebSocket.OPEN) {
      client.send(data);
    }
  });
};

wss.on('connection', function connection(ws, req) {
  //console.log(req.url);
  ws.on('message', function incoming(message) {
    console.log('received:', message);
    wss.broadcast(message, ws);
  });

  ws.send('connection ~~~');
});
