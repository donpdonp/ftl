-- rainbow.lua

LEDBYTES = 4
PIXELS = 60
TIME_ALARM = 16      -- 0.025 second, 40 Hz
PIXELMEMORY = ""
DIM = 16 -- 0-31
INIT = string.char(0,0,0,0)
OFF = string.char(224,0,0,0)
RED = string.char(224+DIM,0,0,255)
GREEN = string.char(224+DIM,0,255,0)
BLUE = string.char(224+DIM,255,0,0)
WHITE = string.char(224+DIM,255,255,255)

function memSet(position, code)
  memoryGrow(position)
  memoryReplace(position, code)
end

function pixSet(colors)
  spi.send(1, INIT, colors, INIT)
end

function memoryGrow(position)
  positionBytes = position*LEDBYTES
  memSize = string.len(PIXELMEMORY)
  if memSize < positionBytes then
    missingCount = (positionBytes - memSize)/LEDBYTES
    print("pix memory "..memSize.." growing by " ..missingCount.. " leds")
    added = OFF:rep(missingCount)
    PIXELMEMORY = PIXELMEMORY .. added
  end
end

function memoryReplace(position, chars)
  positionBytes = position*LEDBYTES
  pre = ""
  if positionBytes > LEDBYTES then
    pre = PIXELMEMORY:sub(0, (positionBytes - LEDBYTES))
  end

  post = ""
  if positionBytes < PIXELMEMORY:len() - (LEDBYTES*2) then
    post = PIXELMEMORY:sub(positionBytes + LEDBYTES)
  end

  print("memoryReplace pre "..pre:len().." chars "..chars:len().." post "..post:len())
  PIXELMEMORY = pre .. chars .. post
end


handlerCount = 2

function rainbowHandler()
  print("handler go.", handlerCount)
  pixSet(RED:rep(PIXELS))
  tmr.delay(150000)
  pixSet(GREEN:rep(PIXELS))
  tmr.delay(150000)
  pixSet(BLUE:rep(PIXELS))
  tmr.delay(150000)
  pixSet(OFF:rep(PIXELS))
  handlerCount = handlerCount - 1
  if handlerCount == 0 then
    tmr.stop(1)
    print("handler end. timer stopped")
  end
end

spi.setup(1, spi.MASTER, spi.CPOL_LOW, spi.CPHA_LOW, 8,10)
tmr.alarm(1, TIME_ALARM, 1, rainbowHandler)
print("rainbow.lua SPI on.")
