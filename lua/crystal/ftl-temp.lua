log("*ftl.temp".." heap "..node.heap())
ftl.temp = {}
ftl.temp.alarm = 2

function ftl.temp.setup()
  ds18b20.setup(ftl.config.temp.pin)
  log("ftl.config.temp.pin "..ftl.config.temp.pin)
--  tmr.alarm(ftl.temp.alarm, 1000, 1, function()
--      ds18b20.read(ftl.temp.read,{})
--    end)
end

function ftl.temp.read(ind,rom,res,temp,tdec,par)
--  print(ind,string.format("%02X:%02X:%02X:%02X:%02X:%02X:%02X:%02X",string.match(rom,"(%d+):(%d+):(%d+):(%d+):(%d+):(%d+):(%d+):(%d+)")),res,temp,tdec,par)
  ftl.pixelbuf.tempcolor(temp)
end
