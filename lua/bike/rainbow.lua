-- Copyright (c) 2015 by Geekscape Pty. Ltd.  Licence LGPL V3.
--
-- http://www.esp8266.com/viewtopic.php?f=21&t=1143

BRIGHT     = 0.1
ON         = BRIGHT * 255
BUTTON_PIN = 3       -- GPIO0
-- LED_PIN    = 5       -- GPIO14/ESP-FTL
LED_PIN    = 2       -- GPIO4/ESP-Squart-vA
PIXELS     = 30
TIME_ALARM = 16      -- 0.025 second, 40 Hz
TIME_SLOW  = 500000  -- 0.500 second,  2 Hz

RED   = string.char( 0, ON,  0)
GREEN = string.char(ON,  0,  0)
BLUE  = string.char( 0,  0, ON)
WHITE = string.char(ON, ON, ON)
BLACK = string.char( 0,  0,  0)

gpio.mode(BUTTON_PIN, gpio.INPUT, gpio.PULLUP)


function rainbowHandler()
  ws2812.write(LED_PIN, RED:rep(PIXELS))
  tmr.delay(TIME_SLOW)
  ws2812.write(LED_PIN, GREEN:rep(PIXELS))
  tmr.delay(TIME_SLOW)
  ws2812.write(LED_PIN, BLUE:rep(PIXELS))
  tmr.delay(TIME_SLOW)
  ws2812.write(LED_PIN, WHITE:rep(PIXELS))
  tmr.delay(TIME_SLOW)
  ws2812.write(LED_PIN, BLACK:rep(PIXELS))
  tmr.stop(1)
end

tmr.alarm(1, TIME_SLOW*10, 1, rainbowHandler)
print("rainbow.lua gpio4 on.")