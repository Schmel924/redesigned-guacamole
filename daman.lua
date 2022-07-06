PlayerA = {}
PlayerA.c = {}
PlayerA.c.x = 1000
PlayerA.c.y = 150
PlayerA.size = 50
PlayerA.speed = 15
PlayerA.d = {}
PlayerA.d.x = 0
PlayerA.d.y = 0
PlayerA.state = "hunt"
PlayerB = {}
PlayerB.c = {}
PlayerB.d = {}
PlayerB.c.x = 400
PlayerB.c.y = 450
PlayerB.size = 50
PlayerB.d.x = 0
PlayerB.d.y = 0
PlayerB.state = "hunt"
PlayerB.speed = 15
Players = {PlayerA, PlayerB}
Gamestate = "draw"

function  LaunchPuck(pl)
    Gamestate = "shot"
    Puck.c.x = pl.c.x - 25
    Puck.d = path (pl.c,LeftGate.center)
end


function UpdatePlayers(dt)
for i,p in ipairs(Players) do
    p.c.x = p.c.x + p.d.x*dt
    p.c.y = p.c.y + p.d.y*dt
    if p.state == "attack" then 
        LaunchPuck (p)
        p.state = "wait"
    else
    p.d = scale(dir (p.c,Puck.c),p.speed)
    CatchPuck (p)
    end
end
end

function CatchPuck(pl)
    if dist (pl.c,Puck.c) < 24 then
        Puck.color = {1,0,0}
        Puck.d = scale (Puck.d,0) -- какой я вумный
        Puck.c.x = pl.c.x
        Puck.c.y = pl.c.y
        pl.state = "attack" Gamestate = "attack"
    end
end


function DrawPlayers()
for i,v in ipairs(Players) do
    love.graphics.setColor (1,0,0)
    love.graphics.rectangle( 'fill', v.c.x, v.c.y, v.size, v.size, 0, 0, 3)
end
end