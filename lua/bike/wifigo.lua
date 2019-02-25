-- bike lights wifi

wifi.setmode(wifi.STATION)
print('wifi mode=STATION (mode='..wifi.getmode()..')\n')
wifi.sta.config("Lighthouse","fresnel0")
wifi.sta.connect()

-- wait for connection
tmr.alarm(0, 2000, 1, function()
   if wifi.sta.getip() == nil then
      print("Checking for connection...\n")
   else
      ip, nm, gw=wifi.sta.getip()
      print("IP Info: \nIP Address: ",ip)
      print("Netmask: ",nm)
      print("Gateway Addr: ",gw,'\n')
      tcpListen()
      tmr.stop(0)
   end
end)

function tcpListen()
  id="bike"
  print("mdns register " .. id)
  mdns.register(id, { description="FTL Lights ["..id.."]", service="rgbled", port=1550, location='bicycle' })
end

--print ("wifi config essid bike-lights")
--cfg={}
--cfg.ssid="bike-lights"
--wifi.ap.config(cfg)

