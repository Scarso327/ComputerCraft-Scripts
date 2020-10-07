function clearScreen()
    term.clear()
    term.setCursorPos(1,1)
end

clearScreen()

monitor = peripheral.wrap("left")
chest = peripheral.wrap("right")

function writeMonitor(string)
    monitor.clear()
    monitor.setCursorPos(3,3)
    monitor.write(string)
end

secondsPerSale = 120
price = 1
values = {
    ["minecraft:iron_ingot"] = 0.1,
    ["minecraft:gold_ingot"] = 0.12,
    ["minecraft:diamond"] = 1.5
}

function getTotalValue()
    local items = chest.list()
    local val = 0
    
    for key, value in pairs(items) do
        if values[value["name"]] ~= nil then
            val = val + values[value["name"]] * value["count"]
        else
            print(value["name"] .. " has no value...")
            os.sleep(3)
            os.reboot()
        end
    end
    
    return val            
end

if chest == nil then
    print("There isn't a chest available")
end

redstone.setAnalogOutput("front", 15)
redstone.setAnalogOutput("back", 0)

while true do
    local curVal = getTotalValue();
    writeMonitor("£" .. getTotalValue())
    
    if (curVal >= price) then
        redstone.setAnalogOutput("front", 0)
        redstone.setAnalogOutput("back", 15)
        
        local totalTime = math.floor(secondsPerSale * (curVal / price))
        
        while totalTime > 0 do
            writeMonitor(totalTime .. "s")
            totalTime = totalTime - 1
            os.sleep(1)
        end
        
        redstone.setAnalogOutput("front", 15)
        os.sleep(3)
        redstone.setAnalogOutput("back", 0)
        break
    end
end

os.reboot()
