PlayerA = {}
PlayerA.x = 1000
PlayerA.y = 150
PlayerA.size = 50
PlayerA.dx = 0
PlayerA.dy = 0
PlayerA.Puck = false
PlayerB = {}
PlayerB.x = 400
PlayerB.y = 450
PlayerB.size = 50
PlayerB.dx = 0
PlayerB.dy = 0
PlayerB.Puck = false
Players = {PlayerA, PlayerB}

function  LaunchPuck(pl)
    Puck.x = pl.x - 25
    Puck.dx,Puck.dy = GetVector (pl.x,pl.y,LeftGate.center.x,LeftGate.center.y)
end


function UpdatePlayers(dt)
for i,v in ipairs(Players) do
    v.x = v.x + v.dx*dt
    v.y = v.y + v.dy*dt
    if v.Puck == true then 
        LaunchPuck (v)
        v.Puck = false
    else
    CatchPuck (v)
    end
end
end
function CatchPuck(pl)
    if math.abs(pl.x - Puck.x) < 25 and math.abs( pl.y-Puck.y) < 25 then
        Puck.color = {1,0,0}
        Puck.dx = 0
        Puck.dy = 0
        Puck.x = pl.x
        Puck.y = pl.y
        pl.Puck = true
    end
end


function DrawPlayers()
for i,v in ipairs(Players) do
    love.graphics.setColor (1,0,0)
    love.graphics.rectangle( 'fill', v.x, v.y, v.size, v.size, 0, 0, 3)
end
end