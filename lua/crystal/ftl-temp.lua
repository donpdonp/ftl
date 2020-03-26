log("*ftl.temp".." heap "..node.heap())
ftl.temp = {}
ftl.temp.alarm = 2

function ftl.temp.setup()
  ow.setup(ftl.config.temp.pin)
  log("ftl.config.temp.pin "..ftl.config.temp.pin)
--  tmr.alarm(ftl.temp.alarm, 1000, 1, function()
--      ds18b20.read(ftl.temp.read,{})
--    end)
end

function ftl.temp.read(ind,rom,res,temp,tdec,par)
--  print(ind,string.format("%02X:%02X:%02X:%02X:%02X:%02X:%02X:%02X",string.match(rom,"(%d+):(%d+):(%d+):(%d+):(%d+):(%d+):(%d+):(%d+)")),res,temp,tdec,par)
  ftl.pixelbuf.tempcolor(temp)
end

function dcheck()
  local pin = ftl.config.temp.pin
  ow.reset_search(pin)
  local addr = ow.search(pin)

  if addr == nil then
    print("No ds18b20 detected.")
  else
    local crc = ow.crc8(string.sub(addr,1,7))
    if crc == addr:byte(8) then
      if (addr:byte(1) == 0x10) or (addr:byte(1) == 0x28) then
	print(string.format("ds18b20 %x-%x:%x:%x:%x:%x:%x:%x", addr:byte(1), addr:byte(2),addr:byte(3),addr:byte(4),addr:byte(5),addr:byte(6),addr:byte(7),addr:byte(8)))
        ftl.temp.timer = tmr.create()
	ftl.temp.timer:alarm(1000, tmr.ALARM_AUTO, function()
          ow.reset(pin)
          ow.select(pin, addr)
          ow.write(pin, 0x44, 1) -- convert T command
          tmr.create():alarm(750, tmr.ALARM_SINGLE, function()
            ow.reset(pin)
            ow.select(pin, addr)
            ow.write(pin,0xBE,1) -- read scratchpad command
            local data = ow.read_bytes(pin, 9)
            local crc = ow.crc8(string.sub(data,1,8))
            if crc == data:byte(9) then
              local t = (data:byte(1) + data:byte(2) * 256) * 625
              local sgn = t<0 and -1 or 1
              local tA = sgn*t
              local t1 = math.floor(tA / 10000)
              local t2 = tA % 10000
              print("Temperature="..(sgn<0 and "-" or "")..t1.."."..t2.." Centigrade")
	    else
		    print("temp crc bad")
            end
          end)
        end)
      else
        print("Device family is not recognized.")
      end
    else
      print("address CRC is not valid!")
    end
  end
end
