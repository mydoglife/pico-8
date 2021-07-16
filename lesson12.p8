pico-8 cartridge // http://www.pico-8.com
version 32
__lua__
--lesson12
--goals
--1. sticky paddle
--2. angle control
--3. combos
--4. levels
--5. different bricks
--6. power ups
--7. juicyness (particles & screen shake)
--8. high score

function _init()
 cls()
 mode ="start"
end

function _update60()
	if mode =="game" then
 	update_game()
 elseif mode=="start" then
 	update_start()
 elseif mode=="gameover" then
 	update_gameover()	
	end
end

function update_start()
 if btn(5) or btn(4) then
 	startgame()
 end 
end

function startgame()
 mode="game"
 ball_r=2
 ball_dr=0.5
 col=10

 pad_x=52
 pad_y=120
 pad_dx=0
 pad_w=24
 pad_h=3
 pad_c=7
 
 --brick_y=20
 brick_w=9
 brick_h=4

 buildbricks()

  
 lives=3
 points=0
 serveball()
end

function buildbricks()
	local i
	brick_x={} 
 brick_y={}
 brick_v={}
 
 --brick_x={5,16,27,38,49,60,71,82,93,104,115}
  --add(brick_x,5+(i-1)*(brick_w+2)) 
 for i=1,66 do
		add(brick_x,4+((i-1)%11)*(brick_w+2)) 
		add(brick_y,20+flr((i-1)/11)*(brick_h+2))
		add(brick_v,true) 
 end
end


function serveball()
	ball_x=5
 ball_y=70
 ball_dx=1
 ball_dy=1
end

function gameover()
	mode="gameover"
end


function update_gameover()
	if btn(4) or btn(5) then
		startgame()
	end
end


function update_game()	
	local buttpress=false
	local nextx, nexty, brickhit
	
	if btn(0) then
		--left
		pad_dx=-2.5
		buttpress=false
		--pad_x-=5
	end
	if btn(1) then
		--right
		pad_dx=2.5
		buttpress=false
		--pad_x+=5
	end
	--slow down
	if not(buttpress) then
		pad_dx=pad_dx/1.3
	end

	pad_x+=pad_dx
	--makes sure pad stays in the screen
	pad_x=mid(0,pad_x,127-pad_w) --retruns the middle value
	
	nextx=ball_x+ball_dx
	nexty=ball_y+ball_dy
	
	if nextx > 124 or nextx < 3 then
		nextx=mid(0,nextx,127)
		
		ball_dx=-ball_dx
		sfx(00)
	end
	if nexty < 10  then
		nexty=mid(0,nexty,127)
				ball_dy=-ball_dy  
		sfx(00)
	end	
 
 
	pad_c=7
 --check if ball it pad
	if ball_box(nextx, nexty,pad_x,pad_y,pad_w,pad_h) then
		--deal with collision
		--find out in which direction to deflect
		if deflx_ball_box(ball_x,ball_y,ball_dx,ball_dy,pad_x,pad_y,pad_w,pad_h) then
			ball_dx=-ball_dx
			if ball_x < pad_x+pad_w/2 then
				nextx=pad_x-ball_r
			else
				nextx=pad_x+pad_w+ball_r
			end
		else
			ball_dy=-ball_dy
			if ball_y > pad_y then
				nexty=pad_y+pad_h+ball_r
			else
				nexty=pad_y-ball_r --take out stuck ball
		end 
		sfx(01)
		points+=1
	end
	
	brickhit=false
 for i=1,#brick_x do
	--check if ball it brick
		if brick_v[i] and ball_box(nextx, nexty,brick_x[i],brick_y[i],brick_w,brick_h) then
		--deal with collision
			if not(brickhit) then
				if deflx_ball_box(ball_x,ball_y,ball_dx,ball_dy,brick_x[i],brick_y[i],brick_w,brick_h) then
					ball_dx=-ball_dx
				else
					ball_dy=-ball_dy
				end 
			end
			brickhit=true
	 	sfx(03)
			brick_v[i]=false
			points+=10
		end
	end
	
	
	ball_x=nextx
	ball_y=nexty
	
	if nexty > 127 then
  sfx(02)
  lives+=-1
  if lives < 0 then
  	gameover()
  else
  	serveball()
  end
	end
end

function _draw()
 if mode =="game" then
 	draw_game()
 elseif mode=="start" then
 	draw_start()
 elseif mode=="gameover" then
 	draw_gameover()	
	end
end

function draw_start()
	print("pico hero breakout",30,40,7)
 print("press ❎ to start",32,80,11)
end

function draw_gameover()
 rectfill(0,60,128,76,0)
 print("game over!",46,62,7)
 print("press ❎ to restart",27,70,6)	
end


function draw_game()
 local i
	cls(1)
	--print("x "..ball_x)
	--print("y "..ball_y)
	--print("pad "..pad_x)
	circfill(ball_x,ball_y,ball_r,col)
	rectfill(pad_x,pad_y,pad_x+pad_w,pad_y+pad_h,pad_c)
	--draw bricks

 for i=1,#brick_x do
		if brick_v[i] then
			rectfill(brick_x[i],brick_y[i],brick_x[i]+brick_w,brick_y[i]+brick_h,14)
		end
	end
	--
	rectfill(0,0,128,6,0)
	print("lives:"..lives,1,1,7)
 print("score:"..points,40,1,7)
end

function ball_box(bx,by,box_x,box_y,box_w,box_h)
	--checks for a collision of the ball with a rectangle
 if by-ball_r > box_y+box_h then return false end          		
 if by+ball_r < box_y then return false end  		
 if bx-ball_r > box_x+box_w then return false end
 if bx+ball_r < box_x then return false end  		
	return true
end

function deflx_ball_box(bx,by,bdx,bdy,tx,ty,tw,th)
	local slp = bdy / bdx
	local cx, cy
	if bdx == 0 then
		return false
	elseif bdy == 0 then
		return true
	elseif slp > 0 and bdx > 0 then
		cx = tx - bx
		cy = ty - by
		return cx > 0 and cy/cx < slp
	elseif slp < 0 and bdx > 0 then
		cx = tx - bx
		cy = ty + th - by
		return cx > 0 and cy/cx >= slp
	elseif slp > 0 and bdx < 0 then
		cx = tx + tw - bx
		cy = ty + th - by
		return cx < 0 and cy/cx <= slp
	else
		cx = tx + tw - bx
		cy = ty - by
		return cx < 0 and cy/cx >= slp
	end
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100000707007060070500704007030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000100001837018360183501834018330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0005000025450204501b45017450104500c4500645003450000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000100003807037060370503704037030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000300003a0503a0503a0503905039050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
