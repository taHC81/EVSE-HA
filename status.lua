local evse = require("evse")
local mqtt = require("mqtt")
local json = require("json")

return {
    id = "homeassistant",
    name = "Home Assistant",
    description = "Home Assistant MQTT connector",
    params = {
        broker = { type = "string", name = "MQTT broker url" }
    },
    start = function(params)
        print("starting homeassistant connector...")

        if not params.broker then
            error("require broker")
        end

        local client = mqtt.client(params.broker)

        return coroutine.create(function()
            repeat
                print("connecting...")
            until client:connect()
            print("conected!")

            function send()
                local payload = {}
                local state = evse.getstate()
                payload["session"] = state >= evse.STATEB1 and state <= evse.STATED2
                payload["charging"] = state == evse.STATEC2 or state == evse.STATED2
                payload["enabled"] = evse.getenabled()
                payload["available"] = evse.getavailable()
                payload["error"] = evse.geterror() > 0
                payload["consumption"] = evse.getconsumption()
                payload["power"] = evse.getpower()
                payload["current_configured"] = evse.getchargingcurrent()
                payload["temperature"] = evse.gethightemperature()
                payload["uptime"] = os.clock()
                payload["currentL1"], payload["currentL2"], payload["currentL3"] = evse.getcurrent()
                payload["voltageL1"], payload["voltageL3"], payload["voltageL3"] = evse.getvoltage()

                client:publish("evse/status", json.encode(payload))
            end

            client:subscribe("evse/cmd", function(topic, data)
                local payload = json.decode(data)

                local methods = {
                    ["setCurrent"] = function(param)
                        evse.setchargingcurrent(param)
                        send()
                    end,
                    ["charger_enable"] = function(param)
                        evse.setenabled(param)
                        send()
                    end
                }

                if methods[payload.method] ~= nil then
                    methods[payload.method](payload.param)
                end
            end)

            while true do
                send()
                coroutine.yield(10000)
            end
        end)
    end
}
