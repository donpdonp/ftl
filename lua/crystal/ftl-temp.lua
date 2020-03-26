log("*ftl.temp".." heap "..node.heap())
ftl.temp = {}

function ftl.temp.setup()
  local pin = ftl.config.temp.pin
  log("ftl.config.temp.pin "..ftl.config.temp.pin)
  ow.setup(pin)
  ow.reset_search(pin)
  local addr = ow.search(pin)

  if addr == nil then
    print("No ds18b20 detected.")
  else
    local crc = ow.crc8(string.sub(addr,1,7))
    if crc == addr:byte(8) then
      if (addr:byte(1) == 0x10) or (addr:byte(1) == 0x28) then
        ftl.temp.addr = addr   
	print(string.format("ds18b20 %x-%x%x%x%x%x%x%x", addr:byte(1), addr:byte(2),addr:byte(3),addr:byte(4),addr:byte(5),addr:byte(6),addr:byte(7),addr:byte(8)))
	log("ftl.temp.timer:stop() to stop temperature readings")
        ftl.temp.timer = tmr.create()
	ftl.temp.timer:alarm(2000, tmr.ALARM_AUTO, ftl.temp.read)
      else
        print("ds18b20 address CRC is not valid!")
      end
    end
  end
--  tmr.alarm(ftl.temp.alarm, 1000, 1, function()
--      ds18b20.read(ftl.temp.read,{})
--    end)
end

function ftl.temp.read()
--  print(ind,string.format("%02X:%02X:%02X:%02X:%02X:%02X:%02X:%02X",string.match(rom,"(%d+):(%d+):(%d+):(%d+):(%d+):(%d+):(%d+):(%d+)")),res,temp,tdec,par)
--  ftl.pixelbuf.tempcolor(temp)
  local pin = ftl.config.temp.pin
  ow.reset(pin)
  ow.select(pin, ftl.temp.addr)
  ow.write(pin, 0x44, 1) -- convert T command
  tmr.create():alarm(750, tmr.ALARM_SINGLE, function()
    ow.reset(pin)
    ow.select(pin, ftl.temp.addr)
    ow.write(pin,0xBE,1) -- read scratchpad command
    local data = ow.read_bytes(pin, 9)
    local crc = ow.crc8(string.sub(data,1,8))
    if crc == data:byte(9) then
      local t = (data:byte(1) + data:byte(2) * 256) * 625
      local sgn = t<0 and -1 or 1
      local tA = sgn*t
      local t1 = math.floor(tA / 1000)
      local t2 = sgn * t1 / 10.0
      --print("Temperature="..t2.."C")
      ftl.temp.last = t2
    else
      print("temp crc bad")
    end
  end)
end
