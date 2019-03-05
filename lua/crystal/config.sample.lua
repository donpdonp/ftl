log("*ftl.config")
ftl.config = {}

-- wifi settings
ftl.config.wifi = { ssid = "myap",
                    pwd = "pass" }

ftl.config.pixels = { count = 360,
                      chip = "ws2812",
                      bytesperpixel = 4,
                      datapin = 7,
                      clockpin = 5 }