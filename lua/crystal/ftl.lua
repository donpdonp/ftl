ftl = ftl or {}
ftl.version = "0.2"

log("*ftl v"..ftl.version)
require("config")
require("ftl-wifi")
require("ftl-pixelbuf")
require("openpixel")

function ftl:setup()
  log(sjson.encode(ftl.config))
  ftl.wifi:setup(ftl.clientconn)
  ftl.buffer = ftl.pixelbuf.new(ftl.config.pixels.count, ftl.config.pixels.bytes)
end

function ftl.clientconn(conn)
  port, ip = conn:getpeer()
  log("tcp client "..ip..":"..port)
  buff = ""
  conn:on("receive", function(conn, payload)
      buff = buff .. payload
      channel, command, msg = openpixel.go(buff, payload)
      if channel then
        buff = buff:sub(4+msg:len()+1, buff:len())
        response = ftl.dispatch(channel, command, msg)
        if response then
          conn:send(response)
        end
      end
      log("buff at len "..buff:len().." payload "..payload:len())
    end)
end

function ftl.dispatch(channel, command, buff)
  bufflen = buff:len()
  log("openpixel dispatch "..channel.." "..command.." "..bufflen)
  if command == 0 then
    if bufflen > 0 then
      if bufflen % 3 == 0 then
        log("set 8bit colors. msg 3bpp. pixelbuf "..(ftl.buffer:len() % 3).."bpp")
--      openpixel.setrgb(buff)
        return "8bpp"
      end
      if bufflen % 4 == 0 then
        log("set 8bit colors. msg 4bpp. pixelbuf "..(ftl.buffer:len() % 4).."bpp")
--      openpixel.setrgbw(buff)
      end
    end
  end
  if command == 1 then
    log("set 16bit colors")
  end
  if command == 255 then
    rssi = wifi.sta.getrssi()
    if rssi then
      log("rssi "..rssi)
      return "rssi "..rssi
    else
      log("rssi null")
    end
  end
end

