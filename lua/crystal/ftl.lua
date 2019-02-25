ftl = ftl or {}
ftl.version = "0.1"

log("ftl v"..ftl.version.." loading...")
require("config")
require("ftl-wifi")

function ftl:setup()
  -- listen
  log("ssid "..ftl.config.wifi.ssid)
  ftl.wifi:setup()
end

function ftl:setupjson()
  fd = file.open("config.json", "r")
  if fd then
    json = fd:read()
    fd:close(); fd = nil
    ftl.config = sjson.decode(json)
  else
    log("missing config.json")
  end
end