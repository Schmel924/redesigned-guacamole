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
    love.graphics.circle('fill', Puck.x, Puck.y, Puck.radius)
    love.graphics.setColor (1,1,1)
    love.graphics.line (Puck.x, Puck.y, Puck.x+Puck.dirx*50, Puck.y+Puck.diry*50)
end

function PuckDirect()
    local len = math.sqrt(Puck.dx^2+Puck.dy^2)
    Puck.dirx = Puck.dx/len
    Puck.diry = Puck.dy/len
end

function  ResetPuck ()
    Puck = {dx = love.math.random( -500, 500 ), dy = love.math.random( -500, 500 ), x = RinkX/2, y = RinkY/2, radius = 50} 
    PuckDirect()
end
function UpdatePuck (dt)
    local x = false
    local y = false
    if (Puck.x+(Puck.dx*dt)-Puck.radius < 0) 
    then 
        Puck.x = Puck.radius --because center of circle will be exactly radius away from zero
        Puck.dx = -Puck.dx PuckDirect()     
        x = true    
    end
    if (Puck.y+Puck.dy*dt-Puck.radius < 0) 
    then 
        Puck.y = Puck.radius
        Puck.dy = -Puck.dy PuckDirect() 
        y = true
    end
    if (Puck.x+Puck.radius+Puck.dx*dt > RinkX) 
    then 
        Puck.x = RinkX - Puck.radius
        Puck.dx = -Puck.dx PuckDirect() 
        x = true
    end
    if (Puck.y+Puck.radius+Puck.dy*dt > RinkY) 
    then 
        Puck.y = RinkY - Puck.radius
        Puck.dy = -Puck.dy PuckDirect() 
        y = true
    end
    --Now the question is should we update position after this? If we do, Puck gets reflected by invisible force inch before the wall
    -- now we update x and y only once in a frame, either touchnig the wall, or moving freely
    if (not x) then Puck.x = Puck.x+Puck.dx*dt end
    if (not y) then Puck.y = Puck.y+Puck.dy*dt end
end


function love.load()
 Rink = love.graphics.newImage("Backstage.png", nil)
 RinkX, RinkY = Rink:getDimensions()
 love.window.setMode(RinkX,RinkY,{resizable=true, vsync=false})
 ResetPuck ()
end

function love.update(dt)
    UpdatePuck (dt)
    if love.mouse.isDown(1)
    then 
       local x,y = love.mouse.getPosition()
        Puck.dx = x - Puck.x
        Puck.dy = y - Puck.y
        PuckDirect()
    end    
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