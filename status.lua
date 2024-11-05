local mqtt = require("mqtt")
local json = require("json")

local client = mqtt.client("mqtt://your_mqtt_server:1883")

client:setonconnect(function()
  print("MQTT contected")
 client:subscribe("evse/cmd")
end)

client:setonmessage(function(topic, data)
  if topic ==  "evse/cmd" then
    local msg = json.decode(data)
    if msg.method == "setCurrent" then
      print("MQTT set current")
      evse.setchargingcurrent(msg.param)
      send()
    end
    if msg.method == "charger_enable" then
      print("MQTT charger on/off")
      evse.setenabled(msg.param)
      send()
    end
  end
end)

client:connect()

function send()
  local payload = {}
  local state = evse.getstate()
  payload["session"] = (state >= evse.STATEB1 and state <= evse.STATED2) and 1 or 0
  payload["charging"] = (state == evse.STATEC2 or state == evse.STATED2) and 1 or 0
  payload["enabled"] = evse.getenabled() and 1 or 0
  payload["power"]  = evse.getpower()
  payload["current_configured"] = evse.getchargingcurrent()
  payload["consumption"] = evse.getconsumption()
  payload["voltageL1"], payload["voltageL2"], payload["voltageL3"] = evse.getvoltage()
  payload["currentL1"], payload["currentL2"], payload["currentL3"] = evse.getcurrent()
  payload["temperature"] = evse.gethightemperature()
  payload["session_time"] = evse.getsessiontime()
  payload["uptime"] = os.clock()

  client:publish("evse/status", json.encode(payload))
end

local counter = 0

return {
  every1s = function ()
    if counter == 10 then
      send()
      counter = 0
    end
    counter = counter + 1
  end
}
