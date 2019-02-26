-- majorVer, minorVer, devVer, chipid, flashid, flashsize, flashmode, flashspeed = node.info()

-- safety check
bootcode, bootreason = node.bootreason()
if bootreason then
  print("bootreason "..bootreason)
end

if bootreason == 3 then
  print("exception reboot. ftl startup halted.")
else
  -- safety pause
  tmr.alarm(0, 2000, tmr.ALARM_SINGLE, function()
    require('util')
    log("") -- jump down from the prompt
    require('ftl')
    ftl:setup()
  end)
end
