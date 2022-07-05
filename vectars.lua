function mag (v)
	return math.sqrt(v.x^2 + v.y^2)
end

function norm (v)
	local m = mag (v)
	local z = {x=0,y=o}
	if (m ~= 0) then z.x=v.x/m z.y=v.y/m end 
	return z
end

function dist (s,f)
	local v = {}
	v.x = f.x - s.x
	v.y = f.y - s.y
	return mag (v)
end

function dir (s,f)
	local v = {}
	v.x = f.x - s.x
	v.y = f.y - s.y
	return norm (v)
end

function scale (v,s)
	local z = {}
	z.x=v.x*s
	z.y=v.y*s
	return z
end

function dot(s,f)
    return s.x * f.x + s.y * f.y
end

function path (s,f)
	local v = {}
	v.x = f.x-s.x
	v.y = f.y-s.y
	return v
end