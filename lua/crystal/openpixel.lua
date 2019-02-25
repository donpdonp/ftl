log("*openpixel")
openpixel = {}

function openpixel.go(buff, payload, pixelbuf)
  if payload and payload:len() > 0 then
    if buff:len() < 2048 then
      buff = buff .. payload
    end
  end
  bufflen = buff:len()
  headerlen = 4
  if bufflen >= headerlen then
    channel, command, msglen = openpixel.header(buff)
    if bufflen-headerlen >= msglen then
      openpixel.dispatch(channel, command, buff:sub(headerlen+1, headerlen+msglen))
      buff = buff:sub(headerlen+msglen+1, bufflen)
    end
  end
end

function openpixel.header(buff)
  log("openpixel header "..buff:len())
  channel = buff:sub(1,1)
  command = buff:sub(2,2)
  len = (buff:sub(3,3):byte()*256) + buff:sub(4,4):byte()
  return channel:byte(), command:byte(), len
end

function openpixel.dispatch(channel, command, buff)
  bufflen = buff:len()
  log("openpixel dispatch "..channel.." "..command.." "..bufflen)
  if command == 0 then
    log("set 8bit colors")
    if bufflen % 3 == 0 then
      openpixel.setrgb(buff)
    end
    if bufflen % 4 == 0 then
      openpixel.setrgbw(buff)
    end
  end
  if command == 1 then
    log("set 16bit colors")
  end
end

function openpixel.setrgb(buff)
end