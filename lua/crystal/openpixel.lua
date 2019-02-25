log("*openpixel")
openpixel = {}

function openpixel.go(buff, payload)
  if payload and payload:len() > 0 then
    log("R:"..payload.." "..payload:len())
    if buff:len() < 2048 then
      buff = buff .. payload
    end
  end
  if buff:len() >= 4 then
    openpixel.packet(buff)
  end
end

function openpixel.packet(buff)
  log("openpixel buff "..buff:len())
  channel = buff:sub(1,1)
  command = buff:sub(2,2)
  len = (buff:sub(3,3):byte()*256) + buff:sub(4,4):byte()
  log("channel "..channel:byte())
  log("command "..command:byte())
  log("payload len "..len)
end