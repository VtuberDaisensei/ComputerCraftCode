-- Get the side of “Advanced Peripherals' AR Controller”.
-- return: Side or nil
function getAR()
    for i , v in pairs(peripheral.getNames()) do
        if peripheral.getType(v) == "arController" then
            return v
        end
    end
    
    return nil
end

-- Get the Side in type.
-- type: Peripheral Type
-- reuturn: Side or nil
function getTypeSide(type)
    for i , v in pairs(peripheral.getNames()) do
        if peripheral.getType(v) == type then
            return v
        end
    end
    
    return nil
end

ar = peripheral.wrap(getAR())

-- Draw the Rectangle with id in AR Device.
-- id: Shape id
-- minX: Shape's Left Side Position
-- minY: Shape's Top Side Position
-- maxX: Shape's Right Side Position
-- maxY: Shape's Bottom Side Position
-- return: 'True' if draw is complete, otherwise 'False'
function drawRectangleWithId(id, minX, minY, maxX, maxY, color)
    if id ~= nil then
        ar.horizontalLineWithId(id .. "TopLine", minX, maxX, minY, color)
        ar.horizontalLineWithId(id .. "BottomLine", minX, maxX, maxY, color)
        ar.verticalLineWithId(id .. "LeftLine", minX, minY, maxY, color)
        ar.verticalLineWithId(id .. "RightLine", maxX, minY, maxY, color)
        return true
    end
    
    return false
end