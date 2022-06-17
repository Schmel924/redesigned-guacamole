--sheepolution preface
local launch_type = arg[2]
if launch_type == "test" or launch_type == "debug" then
    require "lldebugger"
    if launch_type == "debug" then
---@diagnostic disable-next-line: undefined-global
        lldebugger.start()
    end
end

require "daman"

function GetVector (x1,y1,x2,y2)
local x = x2-x1
local y = y2-y1
return x,y
end

function PuckInGoal ()
    --{50, RinkY/3, 200, RinkY/3, 200, RinkY*2/3, 50, RinkY*2/3}
 if Puck.x > LeftGate[1] and Puck.x < LeftGate[3] and Puck.y > LeftGate[2] and Puck.y < LeftGate[6]  then Score("Left") end
 if Puck.x > RightGate[1] and Puck.x < RightGate[3] and Puck.y > RightGate[2] and Puck.y < RightGate[6]  then Score("Right") end
end

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
    love.graphics.circle('fill', Puck.x, Puck.y, Puck.radius)
    love.graphics.setColor (r,g,b,a)
  --[[  love.graphics.setColor (1,1,1)
    love.graphics.line (Puck.x, Puck.y, Puck.x+Puck.dirx*50, Puck.y+Puck.diry*50)
    ]]
end

function PuckDirect()
    local len = math.sqrt(Puck.dx^2+Puck.dy^2)
    Puck.dirx = Puck.dx/len
    Puck.diry = Puck.dy/len
end

function  ResetPuck ()
    Puck = {dx = love.math.random( -500, 500 ), dy = love.math.random( -500, 500 ), x = RinkX/2, y = RinkY/2, radius = 20 , color = {0,0,0}}
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
    PuckInGoal ()
    if (not x) then Puck.x = Puck.x+Puck.dx*dt end
    if (not y) then Puck.y = Puck.y+Puck.dy*dt end
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
    UpdatePuck (dt)
    UpdatePlayers (dt)
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
