ws2812.init(ws2812.DUAL_MODE)
gbuf = ws2812.newBuffer(5, 3)
gbuf:fill(0,50,0)
rbuf = ws2812.newBuffer(5, 3)
rbuf:fill(50,0,0)

function writew()
 ws2812.write(nil, gbuf)
end
function writez()
 ws2812.write(nil, rbuf)
end
print("uart ws2812 write in 3 seconds")
tmr.alarm(0,3000,1,writew)
tmr.alarm(1,4000,1,writez)
print("tmr.stop(0) to stop")
