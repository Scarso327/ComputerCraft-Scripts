term.clear()
term.setCursorPos(1,1)

print("Power Management System v1")

redstone.setAnalogOutput("right", 0)

local timer = 1

while true do
    os.sleep(1)
    
    term.setCursorPos(1,2)
    term.clearLine()
    
    if redstone.getAnalogInput("bottom") > 0 then
        if redstone.getAnalogOutput("right") == 0 then
            print("Power Dropped, Starting Backup...")
            redstone.setAnalogOutput("right", 15)
        end
    else
        if redstone.getAnalogOutput("right") > 0 then
            print("Power Back, Stopping Backup...")
            break
        else
            print("No incidents for " .. timer .. "s")
            timer = timer + 1
        end
    end
end

os.reboot()
