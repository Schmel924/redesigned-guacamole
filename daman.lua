Players = {}
Gamestate = "draw"

function generate_player(team)
    t={}
    t.c = {}
    t.c.x = 0
    t.c.y = 0
    t.size = 50
    t.speed = 30
    t.force = 800
    t.d = {}
    t.d.x = 0
    t.d.y = 0
    t.state = "hunt"
    t.time = 0
    t.team = team
    return t
end

function generatePlayers()
    for i=1,10,1 do
        if i < 6 then Players[i] = generate_player('L')
        else Players[i] = generate_player('R')
        end
    end
end


function  LaunchPuck(pl)
    Gamestate = "shot"
    Puck.c.x = pl.c.x - 25
    local d = nil
    if pl.team == 'L' then  d = scale(dir (pl.c,RightGate.center),pl.force) end
    if pl.team == 'R' then  d = scale(dir (pl.c,LeftGate.center),pl.force) end
    Puck.d = d    
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
    if v.team == 'L' then love.graphics.setColor (0,1,0) end
    if v.team == 'R' then love.graphics.setColor (0,1,1) end
    love.graphics.rectangle( 'fill', v.c.x-v.size/2, v.c.y-v.size/2, v.size, v.size, 0, 0, 3)
    love.graphics.setColor (1,1,1,1)
    love.graphics.line(v.c.x,v.c.y, v.c.x+v.d.x, v.c.y+v.d.y)
   
    if v.state == "attack" then
        local d = nil
         if v.team == 'R' then  d = dir (v.c,LeftGate.center) end
         if v.team == 'L' then  d = dir (v.c,RightGate.center) end
        love.graphics.setColor (1,0,0)
        width = love.graphics.getLineWidth()
        love.graphics.setLineWidth((love.timer.getTime()- v.time)*10 )
        love.graphics.line (v.c.x,v.c.y, v.c.x+d.x *50,(v.c.y)+d.y*50)
        love.graphics.setLineWidth( width)
    end
end
 love.graphics.setColor (r,g,b,a)
end
