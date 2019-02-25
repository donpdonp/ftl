wifi.setmode(wifi.STATION)
print('set mode=STATION (mode='..wifi.getmode()..')\n')
print('MAC Address: ',wifi.sta.getmac())
print('Chip ID: ',node.chipid())
print('Heap Size: ',node.heap(),'\n')
wifi.sta.config({ssid="Name", pwd="Pass"})
--print('enduser_setup.start() AP: SetupGadget_xxxxxx')
--enduser_setup.start()
-- Use this to reset the configured AP data
--wifi.setmode(wifi.STATION)
--wifi.sta.config("foo","") 

print("wifi status poll on timer 0. tmr.stop(0) to stop")
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
  print("pixel memory", string.len(PIXELMEMORY))
  id="ftl-"..string.sub(wifi.sta.getmac(), 13,14)..string.sub(wifi.sta.getmac(), 16,17)
  print("mdns register " .. id)
  mdns.register(id, { description="FTL Lights ["..id.."]", service="rgbled", port=1550, location='Bed Room' })
--  http.get("http://donp.org/ftl", nil, function(code, data)
--      if (code < 0) then
--        print("HTTP request failed")
--      else
--        print(code, data)
--      end
--    end)
  srv=net.createServer(net.TCP)
  srv:listen(1550,function(conn)
    conn:send("pixHello.\n")
    print("tcp client connected")
    conn:on("receive",function(conn,payload)
      print(payload)
      payload = string.gsub(payload, "\n", "")
      led, color = payload:match("([0-9]+):([^:]+)")
      if led then
        ledId = tonumber(led)
        print("parsed: led " .. led .. " ledId ".. ledId.. " color ", color)
        if color == "on" then
          colorCode = WHITE
        end
        if color == "off" then
          colorCode = BLACK
        end
        cr,cg,cb = color:match("([0-9]+),([0-9]+),([0-9]+)")
        if cr then
          colorCode = string.char(tonumber(cg), tonumber(cr), tonumber(cb))
        end
        pixSet(ledId, colorCode)
        ws2812.write(PIXELMEMORY)
        conn:send("#"..led .. " <- " .. " OK\n")
      end
      if payload == "off" then
        conn:send("all "..PIXELS.." off...\n")
        PIXELMEMORY = BLACK:rep(PIXELS)
        ws2812.write(PIXELMEMORY)
      end
      if payload == "on" then
        conn:send("all "..PIXELS.." on...\n")
        PIXELMEMORY = WHITE:rep(PIXELS)
        ws2812.write(PIXELMEMORY)
      end
      if payload == "reboot" then
        conn:send("rebooting")
        node.restart()
      end
      conn:send("pixReady.\n")
    end)
    --conn:on("sent",function(conn) conn:close() end)
  end)
end
