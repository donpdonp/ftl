log("*openpixel")
openpixel = {}
openpixel.headerlen = 4

function openpixel.go(buff, payload)
  bufflen = buff:len()
  if bufflen >= openpixel.headerlen then
    channel, command, msglen = openpixel.header(buff)
    buffleft = bufflen - openpixel.headerlen
    if buffleft >= msglen then
      msg = buff:sub(openpixel.headerlen+1, openpixel.headerlen+msglen)
      return channel, command, msg
    end
  end
end

function openpixel.header(buff)
  channel = buff:sub(1,1)
  command = buff:sub(2,2)
  len = (buff:sub(3,3):byte()*256) + buff:sub(4,4):byte()
  return channel:byte(), command:byte(), len
end
