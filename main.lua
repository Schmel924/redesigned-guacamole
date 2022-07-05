--sheepolution preface
local launch_type = arg[2]
if launch_type == "test" or launch_type == "debug" then
    require "lldebugger"
    if launch_type == "debug" then
---@diagnostic disable-next-line: undefined-global
        lldebugger.start()
    end
end

require "vectars"
require "daman"

--[[function GetVector (x1,y1,x2,y2)
    local x = x2-x1
    local y = y2-y1
    return x,y
end--]] -- куда её использовал?

function PuckInGoal ()
    --{50, RinkY/3, 200, RinkY/3, 200, RinkY*2/3, 50, RinkY*2/3}
 if Puck.c.x > LeftGate[1]  and Puck.c.x < LeftGate[3] and Puck.c.y > LeftGate[2] and Puck.c.y < LeftGate[6]  then Score("Left") end
 if Puck.c.x > RightGate[1] and Puck.c.x < RightGate[3] and Puck.c.y > RightGate[2] and Puck.c.y < RightGate[6]  then Score("Right") end
end -- Puck.x вот за этим придется вернуться

function Score(s)
    love.graphics.print (s, 20, 10)
if s == "Left" then LeftScore = LeftScore +1 ResetPuck () end
if s == "Right" then RightScore = RightScore +1 ResetPuck () end
end

--Actual code
Puck = {}
function DrawPuck ()
    local r, g, b, a = love.graphics.getColor( )
    love.graphics.setColor (Puck.color)
    love.graphics.circle('fill', Puck.c.x, Puck.c.y, Puck.radius) -- и здесь
    love.graphics.setColor (r,g,b,a)
  --[[  love.graphics.setColor (1,1,1)
    love.graphics.line (Puck.x, Puck.y, Puck.x+Puck.dirx*50, Puck.y+Puck.diry*50)
    ]]
end

--[[function PuckDirect() -- вот отличный кандидат на замену!
    local len = math.sqrt(Puck.dx^2+Puck.dy^2)
    Puck.dirx = Puck.dx/len
    Puck.diry = Puck.dy/len
end--]]

function  ResetPuck () --приехали
    Puck = {radius = 20 , color = {0,0,0}}
    local c = {x = RinkX/2, y = RinkY/2}
    local d = {x = love.math.random( -500, 500 ), y = love.math.random( -500, 500 )}
    local dir  = norm (d) --  PuckDirect()
    Puck.c = c
    Puck.d = d
    Puck.dir = dir
end

function UpdatePuck (dt)
    local x = false
    local y = false
    if (Puck.c.x+(Puck.d.x*dt)-Puck.radius < 0)
    then
        Puck.c.x = Puck.radius --because center of circle will be exactly radius away from zero
        Puck.d.x = -Puck.d.x 
        x = true
    end
    if (Puck.c.y+Puck.d.y*dt-Puck.radius < 0)
    then
        Puck.c.y = Puck.radius
        Puck.d.y = -Puck.d.y
        y = true
    end
    if (Puck.c.x+Puck.radius+Puck.d.x*dt > RinkX)
    then
        Puck.c.x = RinkX - Puck.radius
        Puck.d.x = -Puck.d.x
        x = true
    end
    if (Puck.c.y+Puck.radius+Puck.d.y*dt > RinkY)
    then
        Puck.c.y = RinkY - Puck.radius
        Puck.d.y = -Puck.d.y
        y = true
    end
    --Now the question is should we update position after this? If we do, Puck gets reflected by invisible force inch before the wall
    -- now we update x and y only once in a frame, either touchnig the wall, or moving freely
    Puck.dir = norm (Puck.d)
    PuckInGoal ()
    if (not x) then Puck.c.x = Puck.c.x+Puck.d.x*dt end
    if (not y) then Puck.c.y = Puck.c.y+Puck.d.y*dt end
end


function love.load()
 Rink = love.graphics.newImage("Backstage.png", nil)
 RinkX, RinkY = Rink:getDimensions()
 LeftGate = {50, RinkY/3, 200, RinkY/3, 200, RinkY*2/3, 50, RinkY*2/3, center = {x=125,y=RinkY/2} }
 RightGate = {RinkX-200, RinkY/3,RinkX-50, RinkY/3, RinkX-50,RinkY*2/3, RinkX-200, RinkY*2/3, center = {x=RinkX-125,y=RinkY/2}}
 LeftScore = 0
 RightScore = 0
 love.window.setMode(RinkX,RinkY,{resizable=true, vsync=false})
 ResetPuck ()
end




function love.update(dt)
   if love.mouse.isDown(1)
    then
       local x,y = love.mouse.getPosition()
         local v = {x,y}
         Puck.d = path(Puck.c.v)
    end
    UpdatePuck (dt)
    UpdatePlayers (dt)
end

function love.draw()
    love.graphics.setColor (1,1,1)
    love.graphics.draw (Rink)
    love.graphics.setColor (0,1,0)
    love.graphics.polygon("fill", LeftGate)
    love.graphics.setColor (0,0,1)
    love.graphics.polygon("fill", RightGate)
    DrawPlayers()
    DrawPuck ()
    love.graphics.setColor (0,0,0)
    love.graphics.print ("L"..LeftScore.."-R"..RightScore, (RinkX/2)-60, 10,0,4,4)
   
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