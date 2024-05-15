-- NEEDS
-- "DrawerLib.lua"
--
----------------------------------------------------------------
-- How To Use
-- Start the computer with the "Advanced Peripherals' AR Controller" and
-- the "Tinkers' Construct' Smeltery Cntroller" adjacent to each other.
----------------------------------------------------------------

function calcControllerTankCapacity(width, height, depth)
    -- Molten Metal Per Ingot
    mTPI = 90
    return width * height * depth * mTPI * 12
end

if(os.loadAPI("DrawerLib.lua"))
    tankCapacity = calcControllerTankCapacity(8, 8, 6)

    ar = peripheral.wrap(DrawerLib.getAR())
    con = peripheral.wrap(DrawerLib.getTypeSide("tconstruct:drain"))
    if(ar ~= nil and con ~= nil)
        ar.clear()

        minX = 2
        minY = 40
        maxX = 90
        maxY = 80

        DrawerLib.drawWithId("smeltyFill", minX , minY, maxX, maxY, 0xDFDFDF)
        ar.drawString("Smelty Controller", minX, minY - 20, 0xDFDFDF)
        ar.drawString("          Fill Rate", minX, minY - 10, 0xDFDFDF)
        while true do
            fluids = con.tanks()[1]
            tankAmount = 0
            if fluids ~= nil then
                for k, v in pairs(fluids) do
                    if(k == "amount") then
                        tankAmount = tankAmount + v
                    end
                end
            end
            per = (tankAmount / tankCapacity)
            fillY = maxY - (maxY - minY - 1) * per

            ar.drawRightboundStringWithId("smeltyFillPer", string.format("%06.2f", per * 100) .. "%", maxX, maxY + 2, 0x0F0F0F)
            ar.fillWithId("smeltyFillFill", minX + 1, fillY, maxX, maxY, 0x007FFF)
            sleep(.1)
        end
    else
        print("Not Found 'AR Controller' or 'Seared Drain' or both.")
else
    print("Failed to load 'DrawerLib.lua'.")
    print("Please install this.")
end