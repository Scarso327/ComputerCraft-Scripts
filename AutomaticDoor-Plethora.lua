term.clear()
term.setCursorPos(1,1)

print("Automatic Secuirty Door v1")
print("Waiting For Player...")

function PrintStatus(string)
    term.setCursorPos(1,2)
    term.clearLine()
    
    print(string)
end

local scanner = peripheral.wrap("left")

local doorMinX = 0
local doorMaxX = -3
local doorMinZ = 1
local doorMaxZ = -5
local doorMinY = 0
local doorMaxY = 4

redstone.setAnalogOutput("back", 15)

if scanner.hasModule then
    while true do
        local me = scanner.getMetaByName("ScarsoLP")
    
        if me ~= nil then
            if (me.x >= doorMaxX and me.x <= doorMinX) and (me.z >= doorMaxZ and me.z <= doorMinZ) and (me.y >= doorMinY and me.y <= doorMaxY) then 
                redstone.setAnalogOutput("back", 0)
                PrintStatus("Player Found. Door Open")
            else
                redstone.setAnalogOutput("back",15)
                PrintStatus("Player Not Found, Door Closed")
            end
        end
    end
else
    print("No Module...")
end
