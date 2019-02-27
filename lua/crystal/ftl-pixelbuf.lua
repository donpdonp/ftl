log("*ftl.pixelbuf-apa102")
ftl.pixelbuf = {}

function ftl.pixelbuf.new(count, bpp)
  return ftl.pixelbuf.grow("", count, bpp)
end

function ftl.pixelbuf.grow(PIXELMEMORY, position, LEDBYTES)
  positionBytes = position*LEDBYTES
  memSize = PIXELMEMORY:len()
  memSizeLeds = memSize/LEDBYTES
  if memSize < positionBytes then
    missingCount = positionBytes - memSize
--    log("pix memory of "..memSize.." bytes "..memSizeLeds.." leds growing by " ..missingCount.. " bytes")
    added = string.char(0):rep(missingCount)
    PIXELMEMORY = PIXELMEMORY .. added
    newmemSize = PIXELMEMORY:len()
    newmemSizeLeds = newmemSize/LEDBYTES
--    log("pix memory now "..newmemSize.." bytes " ..newmemSizeLeds.. " leds")
  end
  return PIXELMEMORY
end

function ftl.pixelbuf.replace(PIXELMEMORY, position, char, LEDBYTES)
  if position < 1 then
    position = 1
  end
  positionBytes = (position-1)*LEDBYTES
  pre = PIXELMEMORY:sub(1, positionBytes)
  post = PIXELMEMORY:sub(positionBytes + char:len() + 1)

  PIXELMEMORY = pre .. char .. post
  return PIXELMEMORY
end

function ftl.pixelbuf.write(buffer)
--  log("writing datapin "..ftl.config.pixels.datapin.." clockpin "..ftl.config.pixels.clockpin.." "..buffer:len().." bytes")
  apa102.write(ftl.config.pixels.datapin, ftl.config.pixels.clockpin, buffer)
end
