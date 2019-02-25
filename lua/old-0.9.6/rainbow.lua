
ON         = 255
PIXELS     = 60
TIME_ALARM = 16      -- 0.025 second, 40 Hz
TIME_SLOW  = 500000  -- 0.500 second,  2 Hz

RED   = string.char( 0, ON,  0)
GREEN = string.char(ON,  0,  0)
BLUE  = string.char( 0,  0, ON)
WHITE = string.char(ON, ON, ON)
BLACK = string.char( 0,  0,  0)
LEDBYTES = 3

PIXELMEMORY = WHITE:rep(PIXELS)

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
    added = BLACK:rep(missingCount)
    PIXELMEMORY = PIXELMEMORY .. added
    newmemSize = string.len(PIXELMEMORY)
    newmemSizeLeds = newmemSize/3
  end
end

function memoryReplace(position, char)
  if position < 1 then
    position = 1
  end
  positionBytes = (position-1)*LEDBYTES
  pre = PIXELMEMORY:sub(1, positionBytes)
  post = PIXELMEMORY:sub(positionBytes + char:len() + 1)

  PIXELMEMORY = pre .. char .. post
end

handlerCount = 8

function rainbowHandler()
  print("handler go.", handlerCount)
  ws2812.write(2, RED:rep(PIXELS))
  tmr.delay(150000)
  ws2812.write(2, GREEN:rep(PIXELS))
  tmr.delay(150000)
  ws2812.write(2, WHITE:rep(PIXELS))
  handlerCount = handlerCount - 1
  if handlerCount == 0 then
    tmr.stop(1)
    print("handler end. timer stopped")
  end
end

tmr.alarm(1, TIME_ALARM, 1, rainbowHandler)
print("rainbow.lua gpio4 on.")
