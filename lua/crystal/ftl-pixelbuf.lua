log("*ftl.pixelbuf-apa102".." heap "..node.heap())
ftl.pixelbuf = {}

function ftl.pixelbuf.setup()
  ftl.pixelbuf.startcolors = string.char(5,0,0,50, 5,1,5,1)
  --ftl.pixelbuf.startcolors = string.char(0,0,50, 1,5,1)
  --ws2812.init()
end

function ftl.pixelbuf.write(buffer)
  apa102.write(ftl.config.pixels.datapin, ftl.config.pixels.clockpin, buffer)
  --ws2812.write(buffer)
  ftl.buffer = buffer
end

function ftl.pixelbuf.tempcolor(temp)
  adjt = temp*5
  log("tempcolor "..temp.."temp "..adjt.."adjt ".." heap "..node.heap())
  colors = string.char(adjt,0,0)
  ftl.buffer = ftl.pixelbuf.replace(ftl.buffer, 1, colors, ftl.config.pixels.bytesperpixel)
  colors = string.char(0,adjt,0)
  ftl.buffer = ftl.pixelbuf.replace(ftl.buffer, 8, colors, ftl.config.pixels.bytesperpixel)
  colors = string.char(0,0,adjt)
  ftl.buffer = ftl.pixelbuf.replace(ftl.buffer, 9, colors, ftl.config.pixels.bytesperpixel)
  ftl.pixelbuf.write(ftl.buffer)
end

function ftl.pixelbuf.new(count, bpp)
  return ftl.pixelbuf.grow("", count, bpp)
end

function ftl.pixelbuf.grow(PIXELMEMORY, position, LEDBYTES)
  local positionBytes = position*LEDBYTES
  local memSize = PIXELMEMORY:len()
  local memSizeLeds = memSize/LEDBYTES
  if memSize < positionBytes then
    missingCount = positionBytes - memSize
--    log("pix memory of "..memSize.." bytes "..memSizeLeds.." leds growing by " ..missingCount.. " bytes")
    local added = string.char(0):rep(missingCount)
    PIXELMEMORY = PIXELMEMORY .. added
    newmemSize = PIXELMEMORY:len()
    newmemSizeLeds = newmemSize/LEDBYTES
    log("pixel memory now "..newmemSize.." bytes " ..newmemSizeLeds.. " leds heap "..node.heap())
  end
  return PIXELMEMORY
end

function ftl.pixelbuf.replace(PIXELMEMORY, position, char, LEDBYTES)
  prelen = PIXELMEMORY:len()
  if position < 1 then
    position = 1
  end
  positionBytes = (position-1)*LEDBYTES
  local pre = PIXELMEMORY:sub(1, positionBytes)
  local post = PIXELMEMORY:sub(positionBytes + char:len() + 1)

  PIXELMEMORY = pre .. char .. post
  postlen = PIXELMEMORY:len()
  if prelen ~= postlen then
    log("WARNING: replace op grew pixel memory from "..prelen.." to "..postlen.." position "..position.." charlen "..char:len().." ledbytes "..LEDBYTES)
  end
  return PIXELMEMORY
end

function ftl.pixelbuf.repack(buffer, bpp)
  log("repack buffer "..buffer:len().." heap "..node.heap())
  local newbuff = ""
--  buffer:gsub("...", function(c)
--    newbuff = newbuff .. string.char(5) .. c
--  end)
  for i = 1, #buffer do
    if i%3 == 0 then
      local rgb = buffer:sub(i-2,i)
      newbuff = newbuff .. string.char(5) .. rgb
      log("repack i "..i.." rgblen "..rgb:len().." newbuff "..newbuff:len().." heap "..node.heap())
      if node.heap() < 16300 then
        log("mem abort "..node.heap())
        newbuff = buffer
        break
      end
    end
  end
  log("repack post buffer "..newbuff:len().." "..node.heap())
  return newbuff
end

function ftl.pixelbuf.trim(buffer, pixcount, bytesperpix)
  local bufpixlen = buffer:len()/bytesperpix
  if bufpixlen > pixcount then
    local trimlen = pixcount*bytesperpix
    buffer = buffer:sub(1, trimlen)
  end
  return buffer
end
