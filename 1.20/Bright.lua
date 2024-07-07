/* 
 * Program Using Glimmer Crystal for Each Specified Space
 * This program assumes the use of items “Advanced Peripherals” and the "like Glimmer Crystal from Embers Rekindled”.
 * While the template program uses Embers Rekindled’s Glimmer Crystal, you can adapt it for other similar items by modifying the wantedItem’s id and displayName (probably).
 * Since it operates based on each space, you can adjust the sensation by changing the space value. 
 * Additionally, by providing the pitch as an argument during program execution, you can specify the upward and downward directions:
 * - Upside = -90
 * - Downside = 90
 */
automata = peripheral.wrap("right")
isItemPutted = false
wantedItem = { id = "embers:glimmer_crystal", displayName = "Glimmer Crystal" }

space = 6
put = space

args = {...}

function printCursorPos(str, col, row)
    term.setCursorPos(col, row)
    print(str)
end

function printCursorLine(str, row)
    term.setCursorPos(1, row)
    print(str)
end

function getInfo()
    while true do
        cooldown = automata.getOperationCooldown("useOnBlock")
        term.setCursorPos(1, 3)
        term.clearLine()
        printCursorLine("CooldownTime: " .. cooldown, 3)
        
        item = turtle.getItemDetail(1)
        isItemPutted = not(item == nil or item.name ~= wantedItem.id)
        term.setCursorPos(1, 2)
        term.clearLine()
        printCursorLine(wantedItem.displayName .. " is putted: ".. tostring(isItemPutted), 2)
        sleep(.1)
    end
end

function main()
    while true do
        while not isItemPutted do
            sleep(.1)
        end
        if put == space then
            while automata.getOperationCooldown("useOnBlock") > 0 do
                sleep(.1)
            end
            automata.useOnBlock(pitchArg)
            put = 0
        end
        if turtle.detect() then
            break
        end
        turtle.forward()
        put = put + 1
    end
end

term.clear()
if #args >= 1 then
    p = tonumber(args[1])
    if p ~= nil then
        pitchArg = { pitch = p }
    else
        pitchArg = { pitch = 90 }
    end
else
    pitchArg = { pitch = 90 }
end

printCursorLine("Use On Block Pitch: " .. pitchArg.pitch, 1)

parallel.waitForAny(main, getInfo)
term.clear()
printCursorLine("End of Bright", 1)