ftl = ftl or {}
ftl.version = "0.2"

log("*ftl v"..ftl.version)
require("config")
require("ftl-wifi")
require("ftl-pixelbuf")
require("openpixel")

function ftl:setup()
  RED   = string.char(15,0,0,50, 5,1,5,1)
  apa102.write(ftl.config.pixels.datapin, ftl.config.pixels.clockpin, RED:rep(20))
  ftl.buffer = ftl.pixelbuf.new(ftl.config.pixels.count, ftl.config.pixels.bytesperpixel)
  ftl.wifi:setup(ftl.clientconn)
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
        log("buff remaining len "..buff:len().." heap "..node.heap())
        response = ftl.dispatch(channel, command, msg)
        if response then
          conn:send(response)
        end
      else
        log("buff in progress len "..buff:len().." added payload "..payload:len().." heap "..node.heap())
      end
    end)
end

function ftl.dispatch(channel, command, buff)
  bufflen = buff:len()
  log("openpixel dispatch "..channel.." "..command.." "..bufflen)
  if command == 0 then
    if bufflen > 0 then
      ftl.buffer = ftl.pixelbuf.replace(ftl.buffer, 1, buff, ftl.config.pixels.bytesperpixel)
      ftl.pixelbuf.write(ftl.buffer)
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

