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
Puck = {}
function DrawPuck ()
    love.graphics.setColor (0,0,0)
    love.graphics.circle('fill', Puck.x, Puck.y, 50)
end

function  ResetPuck ()
    Puck = {dx = love.math.random( -10, 10 ), dy = love.math.random( -10, 10 ), x = RinkX/2, y = RinkY/2}
end

function love.load()
 Rink = love.graphics.newImage("Backstage.png", nil)
 RinkX, RinkY = Rink:getDimensions()
 love.window.setMode(RinkX,RinkY,{resizable=true, vsync=false})
 ResetPuck ()
end

function love.update(dt)
    Puck.x = Puck.x+Puck.dx
    Puck.y = Puck.y+Puck.dy
end

function love.draw()
    love.graphics.setColor (1,1,1)
    love.graphics.draw (Rink)
    DrawPuck ()
end

--input
function love.keypressed(key)
    if key == "escape" then
       love.event.quit()
    end
    if key == "space" then
        ResetPuck ()
    end
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