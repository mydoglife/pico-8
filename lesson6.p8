pico-8 cartridge // http://www.pico-8.com
version 32
__lua__
ball_x=30
ball_dx=3
ball_y=64
ball_dy=1
ball_r=2
ball_dr=0.5
col=10

pad_x=52
pad_y=120
pad_dx=0
pad_w=20
pad_h=3

function _init()
 cls()
end

function _update()
	buttpress=false
	if btn(0) then
		--left
		pad_dx=-5
		buttpress=false
		--pad_x-=5
	end
	if btn(1) then
		--right
		pad_dx=5
		buttpress=false
		--pad_x+=5
	end
	--slow down
	if not(buttpress) then
		pad_dx=pad_dx/1.7
	end
	
	pad_x+=pad_dx
	
	ball_x+=ball_dx
	ball_y+=ball_dy
	
	if ball_x > 127 or ball_x <0 then
		ball_dx=-ball_dx
		sfx(001)
	end
	if ball_y > 127 or ball_y <0 then
		ball_dy=-ball_dy  
		sfx(001)
	end	
end

function _draw()
	cls()
	print("x "..ball_x)
	print("y "..ball_y)
	print("pad "..pad_x)
	circfill(ball_x,ball_y,ball_r,col)
	rectfill(pad_x,pad_y,pad_x+pad_w,pad_y+pad_h,7)
end



__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100002235025350293502c3502e350000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000200000905008050080500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
