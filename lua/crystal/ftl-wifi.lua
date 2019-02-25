log("*ftl.wifi")
ftl.wifi = {}
ftl.wifi.alarm = 1

function ftl.wifi:setup(clientconn)
  -- wifi.STATION = client
  -- wifi.STATIONAP = ap + client
  wifi.setmode(wifi.STATIONAP)
  log('wifi mode='..wifi.getmode())
  log('MAC Address: '..wifi.sta.getmac())
  log('Chip ID: #'..node.chipid())
  wifi.sta.config(ftl.config.wifi)
  log('connecting to '..wifi.sta.getconfig(true).ssid)
  log("tmr.stop("..ftl.wifi.alarm..") to stop wifi status checks")
  tmr.alarm(ftl.wifi.alarm, 2000, 1, function()
      ftl.wifi:watch(clientconn)
    end)
end

function ftl.wifi:watch(clientconn)
  status = wifi.sta.status()
  log("wifi "..ftl.wifi:statusout(status))
  if status == wifi.STA_GOTIP then
    tmr.stop(ftl.wifi.alarm)
    log(wifi.sta.getip())
    ftl.wifi:mdnssetup(wifi.sta.getmac())
    srv = net.createServer(net.TCP)
    srv:listen(1550, clientconn)
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

function ftl.wifi:mdnssetup(mac)
  id="ftl-"..string.sub(mac, 13,14)..string.sub(mac, 16,17)
  log("mdns register " .. id)
  mdns.register(id, { description="FTL Lights ["..id.."]",
                      service="rgbled", port=1550 })
end
