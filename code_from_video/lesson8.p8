pico-8 cartridge // http://www.pico-8.com
version 32
__lua__
--lesson8
function _init()
 cls()
 ball_x=30
 ball_dx=2
 ball_y=64
 ball_dy=2
 ball_r=2
 ball_dr=0.5
 col=10

 pad_x=52
 pad_y=120
 pad_dx=0
 pad_w=24
 pad_h=3
 pad_c=7
end

function _update()
	local buttpress=false
	local nextx, nexty
	
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
	
	nextx=ball_x+ball_dx
	nexty=ball_y+ball_dy
	

	
	if nextx > 127 or nextx <0 then
		nextx=mid(0,nextx,127)
		
		ball_dx=-ball_dx
		sfx(00)
	end
	if nexty > 127 or nexty <0 then
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
	end
	
	ball_x=nextx
	ball_y=nexty
end

function _draw()
	cls()
	print("x "..ball_x)
	print("y "..ball_y)
	print("pad "..pad_x)
	circfill(ball_x,ball_y,ball_r,col)
	rectfill(pad_x,pad_y,pad_x+pad_w,pad_y+pad_h,pad_c)
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
010100000707007060070500704007030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010100001837018360183501834018330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
