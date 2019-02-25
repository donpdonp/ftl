function log(msg)
  if msg then
    uart.write(0, msg)
    uart.write(0, "\n")
  end
end
