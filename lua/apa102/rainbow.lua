
ON         = 100
PIXELS     = 360
TIME_ALARM = 16      -- 0.025 second, 40 Hz
TIME_SLOW  = 500000  -- 0.500 second,  2 Hz

RED   = string.char(10, 0, ON,  0)
GREEN = string.char(10,ON,  0,  0)
BLUE  = string.char(10, 0,  0, ON)
WHITE = string.char(10,ON, ON, ON)
BLACK = string.char(10, 0,  0,  0)
LEDBYTES = 4

PIXELMEMORY = WHITE:rep(PIXELS)
DATA_PIN = 7
CLOCK_PIN = 5

function pixSet(position, code)
  print("pixOn(".. position ..")")
  memoryGrow(position)
  memoryReplace(position, code)
end

function memoryGrow(position)
  positionBytes = position*LEDBYTES
  memSize = string.len(PIXELMEMORY)
  memSizeLeds = memSize/3
  if memSize < positionBytes then
    missingCount = (positionBytes - memSize)/LEDBYTES
    print("pix memory of "..memSize.." bytes "..memSizeLeds.." leds growing by " ..missingCount.. " leds")
    added = BLACK:rep(missingCount)
    PIXELMEMORY = PIXELMEMORY .. added
    newmemSize = string.len(PIXELMEMORY)
    newmemSizeLeds = newmemSize/3
    print("pix memory now "..newmemSize.." bytes " ..newmemSizeLeds.. " leds")
  end
end

function memoryReplace(position, char)
  if position < 1 then
    position = 1
  end
  positionBytes = (position-1)*LEDBYTES
  pre = PIXELMEMORY:sub(1, positionBytes)
  post = PIXELMEMORY:sub(positionBytes + char:len() + 1)

  print("memoryReplace pre "..pre:len().." char "..char:len().." post "..post:len())
  PIXELMEMORY = pre .. char .. post
end


handlerCount = 4

function rainbowHandler()
  print("handler go.", handlerCount)
  apa102.write(DATA_PIN, CLOCK_PIN, RED:rep(PIXELS))
  tmr.delay(150000)
  apa102.write(DATA_PIN, CLOCK_PIN, GREEN:rep(PIXELS))
  tmr.delay(150000)
  apa102.write(DATA_PIN, CLOCK_PIN, BLUE:rep(PIXELS))
  handlerCount = handlerCount - 1
  if handlerCount == 0 then
    tmr.stop(1)
    print("handler end. timer stopped")
  end
end

tmr.alarm(1, TIME_ALARM, 1, rainbowHandler)
print("rainbow.lua wsinit(gpio2)")
