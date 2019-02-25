-- http://www.esp8266.com/viewtopic.php?f=21&t=1143
ON         = 128
PIXELS     = 24
TIME_ALARM =  16000      -- 0.025 second, 40 Hz
TIME_SLOW  = 300000  -- 0.300 second,  2 Hz

RED    = string.char( 0, ON,  0)
GREEN  = string.char(ON,  0,  0)
BLUE   = string.char( 0,  0, ON)
YELLOW = string.char(ON, ON,  0)
WHITE  = string.char(ON, ON, ON)
BLACK  = string.char( 0,  0,  0)


function rainbowHandler()
--  while true do
    print("headlight blink.")
    STRING = BLUE:rep(1) .. WHITE:rep(6) .. BLUE:rep(1) .. RED:rep(1) .. YELLOW:rep(2) .. RED:rep(1)
    ws2812.write(STRING)
    tmr.delay(TIME_SLOW)
    STRING = BLACK:rep(1) .. WHITE:rep(6) .. BLACK:rep(1) .. BLACK:rep(1) .. YELLOW:rep(2) .. BLACK:rep(1)
    ws2812.write(STRING)
    tmr.delay(TIME_SLOW)
--  end
end

print("headlight initing. tmr.stop(1)")
ws2812.init()
tmr.alarm(1, 1000, tmr.ALARM_AUTO, rainbowHandler)
