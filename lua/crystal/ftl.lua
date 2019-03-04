ftl = ftl or {}
ftl.version = "0.2"

log("*ftl v"..ftl.version.." heap "..node.heap())
require("config")
log("*ftl post config heap "..node.heap())
require("ftl-wifi")
log("*ftl post ftl-wifi heap "..node.heap())
require("ftl-pixelbuf")
log("*ftl post ftl-pixelbuf heap "..node.heap())
require("openpixel")
log("*ftl post openpixel heap "..node.heap())

function ftl:setup()
  ftl.pixelbuf.setup()
--  ftl.buffer = ftl.pixelbuf.new(ftl.config.pixels.count, ftl.config.pixels.bytesperpixel)
  local startcolors = ftl.pixelbuf.startcolors:rep(math.floor(ftl.config.pixels.count/ftl.pixelbuf.startcolors:len()))
  ftl.pixelbuf.write(startcolors)
  ftl.wifi:setup(ftl.clientconn)
end

function ftl.clientconn(conn)
  port, ip = conn:getpeer()
  log("tcp client "..ip..":"..port.." heap "..node.heap())
  local buff = ""
  conn:on("receive", function(conn, payload)
      if node.heap() < 14000 then
        log("buff len "..buff:len().." payload len "..payload:len().." heap WARNING "..node.heap())
      end
      if buff:len() > 0 then
        log("WARNING starting buff len "..buff:len().." payload len "..payload:len().." heap "..node.heap())
      end
      if buff:len() + payload:len() > 4096 then
        log("WARNING client close before 4096 overload")
        conn:close()
        return
      end
      buff = buff .. payload
      local channel, command, msglen = openpixel.header(buff)
      while channel do
        local msg = buff:sub(openpixel.headerlen+1, openpixel.headerlen+msglen)
        response = ftl.dispatch(channel, command, msg)
        if response then
          conn:send(response)
        end
        -- setup for the next loop
        buff = buff:sub(openpixel.headerlen+msglen+1, buff:len())
        channel, command, msglen = openpixel.header(buff)
      end
    end)
end

function ftl.dispatch(channel, command, buff)
  local bufflen = buff:len()
--  log("openpixel dispatch ch#"..channel.." cmd#"..command.." bufflen#"..bufflen)
  if command == 0 then
--      if ftl.config.pixels.bytesperpixel ~= 3 then
--        buff = ftl.pixelbuf.repack(buff, ftl.config.pixels.bytesperpixel)
--      end
    if ftl.config.pixels.bytesperpixel ~= 3 then
      log("bpp mismatch warning. 3 ~= "..ftl.config.pixels.bytesperpixel)
    end
    buff = ftl.pixelbuf.trim(buff, ftl.config.pixels.count, 3)
    ftl.buffer = ftl.pixelbuf.replace(ftl.buffer, 1, buff, ftl.config.pixels.bytesperpixel)
    ftl.pixelbuf.write(ftl.buffer)
  end
  if command == 1 then
    log("set 16bit colors")
  end
  if command == 2 then -- write rgbw
    if ftl.config.pixels.bytesperpixel ~= 4 then
      log("bpp mismatch warning. 4 ~= "..ftl.config.pixels.bytesperpixel)
    end
--    buff = ftl.pixelbuf.trim(buff, ftl.config.pixels.count, 4)
--    ftl.buffer = ftl.pixelbuf.replace(ftl.buffer, 1, buff, 4)
    ftl.pixelbuf.write(buff)
  end
  if command == 3 then -- write pos,rgbw
    local pos = buff:byte(1)*256+buff:byte(2)
    buff = buff:sub(3, buff:len())
    buff = ftl.pixelbuf.replace(ftl.buffer, pos, buff, ftl.config.pixels.bytesperpixel)
    ftl.pixelbuf.write(buff)
  end
  if command == 255 then
    rssi = wifi.sta.getrssi()
    if rssi then
      log("rssi "..rssi)
      return "rssi "..rssi
    else
      log("rssi null")
    end
  end
end

