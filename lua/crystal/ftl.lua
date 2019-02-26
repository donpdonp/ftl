ftl = ftl or {}
ftl.version = "0.2"

log("*ftl v"..ftl.version)
require("config")
require("ftl-wifi")
require("openpixel")

function ftl:setup()
  log(sjson.encode(ftl.config))
  ftl.wifi:setup(ftl.clientconn)
  ftl.pixelbuf = ws2812.newBuffer(ftl.config.pixels.count, ftl.config.pixels.bytes)
end

function ftl.clientconn(conn)
  port, ip = conn:getpeer()
  log("tcp client "..ip..":"..port)
  buff = ""
  conn:on("receive", function(conn, payload)
        openpixel.go(buff, payload)
    end)
end
