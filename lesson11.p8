pico-8 cartridge // http://www.pico-8.com
version 32
__lua__
--lesson10
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
 brick_w=10
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
 for i=1,10 do
		add(brick_x,5+(i-1)*(brick_w+2)) 
		add(brick_y,20) 
		add(brick_v,true) 
 end
end


function serveball()
	ball_x=5
 ball_y=33
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
	local nextx, nexty
	
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
		else
			ball_dy=-ball_dy
		end 
		sfx(01)
		points+=1
	end
	
 for i=1,#brick_x do
	--check if ball it brick
		if brick_v[i] and ball_box(nextx, nexty,brick_x[i],brick_y[i],brick_w,brick_h) then
		--deal with collision
		--find out in which direction to deflect
			if deflx_ball_box(ball_x,ball_y,ball_dx,ball_dy,brick_x[i],brick_y[i],brick_w,brick_h) then
				ball_dx=-ball_dx
			else
				ball_dy=-ball_dy
			end 
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
 -- calculate wether to deflect the ball
 -- horizontally or vertically when it hits a box
 if bdx == 0 then
  -- moving vertically
  return false
 elseif bdy == 0 then
  -- moving horizontally
  return true
 else
  -- moving diagonally
  -- calculate slope
  local slp = bdy / bdx
  local cx, cy
  -- check variants
  if slp > 0 and bdx > 0 then
   -- moving down right
   debug1="q1"
   cx = tx-bx
   cy = ty-by
   if cx<=0 then
    return false
   elseif cy/cx < slp then
    return true
   else
    return false
   end
  elseif slp < 0 and bdx > 0 then
   debug1="q2"
   -- moving up right
   cx = tx-bx
   cy = ty+th-by
   if cx<=0 then
    return false
   elseif cy/cx < slp then
    return false
   else
    return true
   end
  elseif slp > 0 and bdx < 0 then
   debug1="q3"
   -- moving left up
   cx = tx+tw-bx
   cy = ty+th-by
   if cx>=0 then
    return false
   elseif cy/cx > slp then
    return false
   else
    return true
   end
  else
   -- moving left down
   debug1="q4"
   cx = tx+tw-bx
   cy = ty-by
   if cx>=0 then
    return false
   elseif cy/cx < slp then
    return false
   else
    return true
   end
		end
	end
	return false
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
