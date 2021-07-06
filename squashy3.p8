pico-8 cartridge // http://www.pico-8.com
version 32
__lua__

--paddle
padx=52
pady=122
padw=24
padh=4

--ball
ballx=64
bally=64
ballsize=3
ballxdir=5   -- is it too fast, how wuould you slow it donw?
ballydir=-3

score=0

function movepaddle()
 if btn(0) then --button zero is left, see the pico cheat sheet
  padx-=3 --this is the same as padx=padx-3
 elseif btn(1) then
  padx+=3 --this is the same as padx=padx+3
 end
end

function moveball()
 ballx+=ballxdir
 bally+=ballydir
end

function bounceball()
 --left
 if ballx<ballsize then
  ballxdir=-ballxdir
  sfx(0)
 end

--right
 if ballx>128-ballsize then
  ballxdir=-ballxdir
  sfx(0)
 end

 --top
 if bally<ballsize then
  ballydir=-ballydir
  sfx(0)
 end
end

--bounce ball off the paddle
function bouncepaddle()
 if ballx>=padx and ballx<padx+padw and bally>pady then
  sfx(0)
  score+=10 -- increase the score on hit!
  ballydir=-ballydir
 end
end

function losedeadball()
 if bally>128 then
  sfx(3)
  bally=24
 end
end




function _update()
 movepaddle()
 bounceball()
 moveball()
 bouncepaddle()
 losedeadball()
end

function _draw()
-- clear the screen
 rectfill(0,0, 128, 128, 3)

 --draw the score
 print(score,12,6,15)

--draw the paddle
 rectfill(padx,pady,padx+padw, pady+padh, 15)

--draw the ball
 circfill(ballx,bally,ballsize,15)

end

