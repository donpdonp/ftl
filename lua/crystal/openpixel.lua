log("*openpixel")
openpixel = {}

function openpixel.go(buff, payload)
  if payload and payload:len() > 0 then
    log("R:"..payload.." "..payload:len())
    if buff:len() < 2048 then
      buff = buff .. payload
    end
  end
  bufflen = buff:len()
  if bufflen >= 4 then
    channel, command, msglen = openpixel.header(buff)
    if bufflen-4 >= msglen then
      openpixel.dispatch(channel, command, buff:sub(5, bufflen))
    end
  end
end

function openpixel.header(buff)
  log("openpixel header "..buff:len())
  channel = buff:sub(1,1)
  command = buff:sub(2,2)
  len = (buff:sub(3,3):byte()*256) + buff:sub(4,4):byte()
  log("channel "..channel:byte())
  log("command "..command:byte())
  log("payload len "..len)
  return channel, command, len
end

function openpixel.dispatch(channel, command, buff)
  log("openpixel dispatch "..channel:byte().." "..command:byte().." "..buff:len())
end
