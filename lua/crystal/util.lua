function log(msg)
  msgtype = type(msg)
  if msgtype == "string" or msgtype == "number" then
    uart.write(0, msg)
    uart.write(0, "\n")
  else
    uart.write(0, "_"..msgtype.."_\n")
  end
end
