PlayerA = {}
PlayerA.c = {}
PlayerA.c.x = 1000
PlayerA.c.y = 150
PlayerA.size = 50
PlayerA.speed = 30
PlayerA.force = 800
PlayerA.d = {}
PlayerA.d.x = 0
PlayerA.d.y = 0
PlayerA.state = "hunt"
PlayerA.time = 0
PlayerB = {}
PlayerB.c = {}
PlayerB.d = {}
PlayerB.c.x = 400
PlayerB.c.y = 450
PlayerB.size = 50
PlayerB.d.x = 0
PlayerB.d.y = 0
PlayerB.state = "hunt"
PlayerB.speed = 30
PlayerB.force = 800
PlayerB.time = 0
Players = {PlayerA, PlayerB}
Gamestate = "draw"

function  LaunchPuck(pl)
    Gamestate = "shot"
    Puck.c.x = pl.c.x - 25
    Puck.d = scale(dir (pl.c,LeftGate.center),pl.force)
end


function UpdatePlayers(dt)
for i,p in ipairs(Players) do
    if (p.state ~= "wait") then
    p.c.x = p.c.x + p.d.x*dt
    p.c.y = p.c.y + p.d.y*dt
    end
    if p.state == "attack" and love.timer.getTime() - p.time > 1 then 
        p.time = 0
        LaunchPuck (p)
        p.state = "wait"
    end
    if p.state == "hunt" then
    p.d = scale(dir (p.c,Puck.c),p.speed)
        if CatchPuck (p) then
        p.time = love.timer.getTime()    
        p.state = "attack" 
        p.d = scale (p.d,0)
        Gamestate = "attack"
        end
    end
end
end

function CatchPuck(pl)
    if dist (pl.c,Puck.c) < 24 then
       -- Puck.color = {1,0,0}
        Puck.d = scale (Puck.d,0) -- какой я вумный
        Puck.c.x = pl.c.x
        Puck.c.y = pl.c.y
        return true
    end
    return false
end


function DrawPlayers()
    local r, g, b, a = love.graphics.getColor( )
for i,v in ipairs(Players) do
    love.graphics.setColor (1,0,0)
    love.graphics.rectangle( 'fill', v.c.x-v.size/2, v.c.y-v.size/2, v.size, v.size, 0, 0, 3)
    love.graphics.setColor (1,1,1,1)
    love.graphics.line(v.c.x,v.c.y, v.c.x+v.d.x, v.c.y+v.d.y)
   
    if v.state == "attack" then
        local d = dir (v.c,LeftGate.center)
        love.graphics.setColor (1,0,0)
        width = love.graphics.getLineWidth()
        love.graphics.setLineWidth((love.timer.getTime()- v.time)*10 )
        love.graphics.line (v.c.x,v.c.y, v.c.x+d.x *50,(v.c.y)+d.y*50)
        love.graphics.setLineWidth( width)
    end
end
 love.graphics.setColor (r,g,b,a)
end