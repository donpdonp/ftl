print("*ftl.wifi")
ftl.wifi = {}

function ftl.wifi:setup()
  -- wifi.STATION = client
  -- wifi.STATIONAP = ap + client
  wifi.setmode(wifi.STATIONAP)
  print('wifi mode='..wifi.getmode())
  print('MAC Address: '..wifi.sta.getmac())
  print('Chip ID: #'..node.chipid())
  wifi.sta.config(ftl.config.wifi)
end
