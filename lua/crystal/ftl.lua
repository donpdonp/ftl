ftl = ftl or {}
ftl.version = "0.1"

print("ftl loading...")
require("config")
require("wifi")

function ftl:setup()
  -- listen
  print("ssid "..ftl.config.ssid)
  ftl.wifi:setup()
end

function ftl:setupjson()
  fd = file.open("config.json", "r")
  if fd then
    json = fd:read()
    fd:close(); fd = nil
    ftl.config = sjson.decode(json)
  else
    print("missing config.json")
  end
end