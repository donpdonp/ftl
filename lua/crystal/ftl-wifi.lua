log("*ftl.wifi")
ftl.wifi = {}

function ftl.wifi:setup()
  -- wifi.STATION = client
  -- wifi.STATIONAP = ap + client
  wifi.setmode(wifi.STATIONAP)
  log('wifi mode='..wifi.getmode())
  log('MAC Address: '..wifi.sta.getmac())
  log('Chip ID: #'..node.chipid())
  wifi.sta.config(ftl.config.wifi)
  log('connecting to '..wifi.sta.getconfig(true).ssid)
  print("wifi status poll on timer 0. tmr.stop(0) to stop")
  tmr.alarm(0, 2000, 1, ftl.wifi.watch)
end

function ftl.wifi:watch()
  status = wifi.sta.status()
  print("wifi "..ftl.wifi:statusout(status))
  if status == wifi.STA_GOTIP then
    tmr.stop(0)
  end
end

function ftl.wifi:statusout(code)
  if code == wifi.STA_IDLE then
    return "idle"
  end
  if code == wifi.STA_CONNECTING then
    return "connecting"
  end
  if code == wifi.STA_WRONGPWD then
    return "wrong password"
  end
  if code == wifi.STA_APNOTFOUND then
    return "AP not found"
  end
  if code == wifi.STA_FAIL then
    return "unknown failure"
  end
  if code == wifi.STA_GOTIP then
    return "got IP"
  end
end