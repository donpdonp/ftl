ftl = ftl or {}
ftl.version = "0.1"

log("*ftl v"..ftl.version)
require("config")
require("ftl-wifi")
require("openpixel")

function ftl:setup()
  ftl.wifi:setup(ftl.clientconn)
end

function ftl.clientconn(conn)
  port, ip = conn:getpeer()
  log("tcp client "..ip..":"..port)
  buff = ""
  conn:on("receive", function(conn, payload)
        openpixel.go(buff, payload)
    end)
end
