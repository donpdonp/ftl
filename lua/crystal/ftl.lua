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
        ftl.dispatch(channel, command, msg)
      end
      log("buff at len "..buff:len().." payload "..payload:len())
    end)
end

function ftl.dispatch(channel, command, buff)
  bufflen = buff:len()
  log("openpixel dispatch "..channel.." "..command.." "..bufflen)
  if command == 0 then
    log("set 8bit colors")
    if bufflen % 3 == 0 then
--      openpixel.setrgb(buff)
    end
    if bufflen % 4 == 0 then
--      openpixel.setrgbw(buff)
    end
  end
  if command == 1 then
    log("set 16bit colors")
  end
end

