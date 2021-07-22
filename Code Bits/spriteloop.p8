pico-8 cartridge // http://www.pico-8.com
version 32
__lua__
function _init()
	player={}
	sprite=0
	make_player("knight",8)
	--make_player("link",4)
--	make_player(pikachu,16)
--	make_player(pokemon,24)
--	make_player(simpson,20)
end

function _update()
	foreach(player,move_player)
	
end

function _draw()
	cls()
	foreach(player,draw_player)
end

function make_player(name,sprite)
	local char={}
	char.name=name
	char.sprite=sprite
	char.x=10
	char.y=10
	char.timing=.25
 add(player,char)
end

function move_player(player)
 if (btn(0)) animate_player(player,"left")
 if (btn(1)) animate_player(player,"right")
 if (btn(2)) animate_player(player,"up")
 if (btn(3)) animate_player(player,"down")
end

function animate_player(player,direction)
	if sprite > 4 then
		sprite=-1
	end
	if direction=="left" then
		player.x-=1
	elseif direction=="right" then
		player.x+=1
	elseif direction=="up" then
		player.y-=1
	else
		player.y+=1
	end
  sprite+=1
end
	 

function draw_player(player)
	--map(0,0,0,0,16,16)
	print(player.sprite+sprite)
	spr(player.sprite+sprite,player.x,player.y)
end











__gfx__
0000000001100001000000000099909000bbaa9000bbaa9000bbaa9000bbaa900766d0600766d0000766d0000766d06033333333333333333333333300000000
0000000000a90009000acca09990949007bafaa907bafaa907bafaa907bafaa90666d0600666d0600666d0600666d060333b33333b3303333333336300000000
00700700990aaaa900aaaaaa99999dd937fa0f0037fa0f0037fa0f0037fa0f000f1610600f1610600f1610600f161060b3033b3333b333b333a3333300000000
00077000990a0aa0009aa0a000449dd9070ffff0070ffff0070ffff0070ffff00ffff4420ffff0600ffff0600ffff4423330303333303b333a333b3300000000
000770000908aaa900aaaa8809aa49d807bbf30607bbf30607bbf30607bbf306fd60d5f00d60d4420d60d4420d60d5f033333333333333333033333300000000
00700700090a99900009aa8809aa498accc4943dccc4943dccc4943dccc4943d06dd50200fdd55f006fd55f00fdd50203b3333333b33033333033a3300000000
0000000009a9a9a000ccc110049a94980f3bb30d0f3bb30d0f3bb30d0f3bb30d0d65d0000d65d0200d65d0200d65d00033033003333b333333a33b3300000000
0000000000a944900cccac1979407900004002000400200000040020004002000500500000550000050050000055000033333333333333303333333300000000
01100001011000010110000101100001000000000000000000000000000000000099909000999090009990900099909000000000000000000000000000000000
00a9000900a9000900a9000900a90009000acca0000acca0000acca0000acca09990949099909490999094909990949000000000000000000000000000000000
990aaaa9090aaaa9990aaaa9090aaaa900aaaaaa00aaaaaa00aaaaaa00aaaaaa99999dd999999dd999999dd999999dd900000000000000000000000000000000
990a0aa0990a0aa0990a0aa0990a0aa0009aa0a0009aa0a0009aa0a0009aa0a000449dd900449dd900449dd900449dd900000000000000000000000000000000
0908aaa90908aaa90908aaa90908aaa900aaaa8800aaaa8800aaaa8800aaaa8809aa49d809aa49d809aa49d809aa49d800000000000000000000000000000000
090a9990090a9990090a9990090a99900009aa880009aa880009aa880009aa8809aa498a09aa498a09aa498a09aa498a00000000000000000000000000000000
09a9a9a009a9a9a009a9a9a009a9a9a000ccc110c0ccc11000ccc110c0ccc110049a9498049a9498049a9498049a949800000000000000000000000000000000
00a9449000a4994000a9449000a499400cccac190ccacc900cccac190ccacc907940790079407900794079007940790000000000000000000000000000000000
__map__
0d0d0d0e0d0d0d0d0e0e0e0e0e0e0e0d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0e0c0e0e0e0d0c0e0c0d0c0d0e0e0c0c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0d0c0e0d0c0d0d0d0d0d0e0d0e0d0e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0e0e0d0d0c0d0e0d0d0e0e0e0c0d0e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0c0c0d0e0d0e0d0d0d0e0e0d0e0e0e0e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0d0e0e0c0e0d0d0e0d0c0d0d0e0e0c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0e0d0d0e0c0c0d0c0c0c0e0c0c0e0e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0e0e0d0d0c0c0c0e0d0e0d0e0e0d0c0c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0d0d0d0d0d0d0d0c0c0d0d0d0d0c0d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000