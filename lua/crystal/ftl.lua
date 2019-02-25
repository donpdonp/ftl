ftl = ftl or {}
ftl.version = "0.1"

log("ftl v"..ftl.version.." loading...")
require("config")
require("ftl-wifi")
require("openpixel")

function ftl:setup()
  ftl.wifi:setup(ftl.clientconn)
end

function ftl.clientconn(conn)
  port, ip = conn:getpeer()
  log("tcp client "..ip..":"..port)
  buff = string.char(0):rep(2048)
  conn:on("receive", function(conn, payload)
      if payload and payload:len() > 0 then
        log("R:"..payload.." "..payload:len())
        buff = buff .. payload
      end
      if buff:len() >= 4 then
        openpixel.go(buff)
      end
    end)
end
