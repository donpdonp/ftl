ftl = ftl or {}
ftl.version = "0.1"

log("ftl v"..ftl.version.." loading...")
require("config")
require("ftl-wifi")

function ftl:setup()
  ftl.wifi:setup(ftl.clientconn)
end

function ftl.clientconn(conn)
  port, ip = conn:getpeer()
  log("tcp client "..ip..":"..port)
  conn:on("receive", function(conn, payload)
      if payload then
        log("R:"..payload)
      else
        log("R: nil")
      end
    end)
end
