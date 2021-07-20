function _init()

end

function _update()
	if (btn(⬆️)) y-=2
	if (btn(⬇️)) y+=2
	if (btn(⬅️)) x-=2
	if (btn(➡️)) x+=2
	
	y=mid(0,y,120) -this is the limit for 8x8 sprites
	x=mid(0,x,120)

end

function _draw()
	cls(15)
	spr(1,x,y)
end
