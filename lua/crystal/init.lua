-- safety check
bootcode, bootreason = node.bootreason()
if bootreason and bootreason ~= 4 then
  print("bootreason "..bootreason)
end

if bootreason == 3 then
  print("exception reboot. ftl startup halted.")
else
  -- safety pause
  tmr.alarm(0, 2000, tmr.ALARM_SINGLE, function()
    print()
    require('util')
    require('ftl')
    ftl:setup()
  end)
end
