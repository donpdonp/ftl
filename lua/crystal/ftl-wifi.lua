log("*ftl.wifi".." heap "..node.heap())
ftl.wifi = {}
ftl.wifi.alarm = 1

function ftl.wifi:setup(clientconn)
  -- wifi.STATION = client
  -- wifi.STATIONAP = ap + client
  wifi.setmode(wifi.STATIONAP)
  log('wifi mode='..wifi.getmode())
  log('mac address: '..wifi.sta.getmac())
  wifi.sta.config(ftl.config.wifi)
  log("tmr.stop("..ftl.wifi.alarm..") to stop wifi status checks")
  tmr.alarm(ftl.wifi.alarm, 2000, 1, function()
      ftl.wifi:watch(clientconn)
    end)
end

function ftl.wifi:watch(clientconn)
  status = wifi.sta.status()
  if status == wifi.STA_GOTIP then
    tmr.stop(ftl.wifi.alarm)
    log("wifi "..wifi.sta.getip().." "..wifi.sta.getrssi().." heap "..node.heap())
    --ftl.wifi:mdnssetup(wifi.sta.getmac())
    srv = net.createServer(net.TCP)
    srv:listen(1550, clientconn)
  else
    log("wifi "..ftl.wifi:statusout(status).." "..wifi.sta.getconfig(true).ssid)
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
  log("mdns register "..id..".local")
  mdns.register(id, { description="FTL Lights ["..id.."]",
                      service="openpixel", port=1550 })
end
