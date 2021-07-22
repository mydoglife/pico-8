pico-8 cartridge // http://www.pico-8.com
version 32
__lua__
function _init()
	bullets={}
	gun_x=20
	gun_y=20
end

function add_new_bullet(_x,_y,_x2,_y2)
	add(bullets, {
	x=_x,
	y=_y,
	dx=_x2,
	dy=_y2,
--	dx=2,
--	dy=0,
--	
	life=20,
	draw=function(self)
		pset(self.x,self.y,6)
	end,
	update=function(self)
		self.x+=self.dx
		self.y+=self.dy
		
		self.life-=1
		if self.life<0 then
			del(bullets,self) 
		end
	end
	})
end

function _update()
	if (btn(4)) or (btn(5)) then 
		add_new_bullet(gun_x+8,gun_y,(rnd(5)+3),(rnd(3)-2)) 
		--add_new_bullet(gun_x+8,gun_y,gun_x,gun_y) 
		sfx(0)
	end
 
 if (btn(2)) gun_y-=2
 if (btn(3)) gun_y+=2
 if (btn(0)) gun_x-=2
 if (btn(1)) gun_x+=2
  
 

	for b in all(bullets) do
		b:update()
	end
	
	
end

function _draw()
 cls()
 print("press 🅾️ or ❎")
	print("number of bullets: "..#bullets)
	
	spr(1,gun_x,gun_y)

	
	for b in all(bullets) do
		b:draw()
	end
	end

__gfx__
00000000550005500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000056655dd70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700004555500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000770000447d5000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000044005000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0070070004d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100002b65023650216500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
