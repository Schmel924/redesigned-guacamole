--sheepolution preface
local launch_type = arg[2]
if launch_type == "test" or launch_type == "debug" then
    require "lldebugger"
    if launch_type == "debug" then
---@diagnostic disable-next-line: undefined-global
        lldebugger.start()
    end
end


--Actual code

function love.load()
 Rink = love.graphics.newImage("Backstage.png", nil)
 RinkX, RinkY = Rink:getDimensions()
 love.window.setMode(RinkX,RinkY,{resizable=true, vsync=false})
end

function love.update(dt)

end

function love.draw()
    love.graphics.setColor (1,1,1)
    love.graphics.draw (Rink)
    love.graphics.setColor (0,0,0)
    love.graphics.rectangle( "fill", RinkX/2, RinkY/2, 50, 50)
end



--sheepolution footer
---@diagnostic disable-next-line: undefined-field
local love_errorhandler = love.errhand
function love.errorhandler(msg)
---@diagnostic disable-next-line: undefined-global
    if lldebugger then
---@diagnostic disable-next-line: undefined-global
        lldebugger.start() -- Add this
        error(msg, 2)
    else
        return love_errorhandler(msg)
    end
end