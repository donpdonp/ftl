
ON         = 100
PIXELS     = 360
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
  ws2812.write(RED:rep(PIXELS))
  tmr.delay(150000)
  ws2812.write(GREEN:rep(PIXELS))
  tmr.delay(150000)
  ws2812.write(WHITE:rep(PIXELS))
  handlerCount = handlerCount - 1
  if handlerCount == 0 then
    ws2812.write(BLACK:rep(PIXELS))
    ws2812.write(string.char( 0, 0, 20)..BLACK:rep(11)..string.char(5,0,0))
    tmr.stop(1)
    print("handler end. timer stopped")
  end
end

ws2812.init()
tmr.alarm(1, TIME_ALARM, 1, rainbowHandler)
print("rainbow.lua wsinit(gpio2)")
