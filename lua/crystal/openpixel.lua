log("*openpixel".." heap "..node.heap())
openpixel = {}
openpixel.headerlen = 4

function openpixel.header(buff)
  bufflen = buff:len()
  if bufflen >= openpixel.headerlen then
    channel, command, msglen = openpixel.parse(buff)
    msgpart = bufflen - openpixel.headerlen
    if msgpart >= msglen then
      return channel, command, msglen
    end
  end
end

function openpixel.parse(buff)
  local channel = buff:sub(1,1)
  local command = buff:sub(2,2)
  local len = (buff:sub(3,3):byte()*256) + buff:sub(4,4):byte()
  return channel:byte(), command:byte(), len
end
