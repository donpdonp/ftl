-- safety check
bootcode, bootreason = node.bootreason()
print("bootreason "..bootreason)

if bootreason == 3 then
  print("exception reboot. ftl startup halted.")
else
  -- safety pause
  tmr.alarm(0, 2000, tmr.ALARM_SINGLE, function()
    require('util')
    require('ftl')
    print("time stop")
    ftl:setup()
  end)
end
