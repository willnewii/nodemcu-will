local ws = websocket.createClient()
ws:on("connection", function(ws)
  print('got ws connection')
  ws:send('hello! server,i am nodemcu') 
end)
ws:on("receive", function(_, msg, opcode)
  print('got message:', msg, opcode) -- opcode is 1 for text message, 2 for binary
end)
ws:on("close", function(_, status)
  print('connection closed', status) 
  ws = nil -- required to lua gc the websocket client
end)
ws:connect('ws://192.168.11.63:5555')