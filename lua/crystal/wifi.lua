print("*ftl.wifi")
ftl.wifi = {}

function ftl.wifi:setup()
  wifi.setmode(wifi.STATION)
  print('set mode=STATION (mode='..wifi.getmode()..')\n')
  print('MAC Address: ',wifi.sta.getmac())
  print('Chip ID: ',node.chipid())
  print('Heap Size: ',node.heap(),'\n')
  wifi.sta.config(ftl.config.wifi)
end
