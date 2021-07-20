pico-8 cartridge // http://www.pico-8.com
version 32
__lua__
function _init()
	gameover=false
	make_cave()
	make_player()
	upvalue=0
end

function _update()
 update_cave()
	move_player()
end

function update_up(up)
 upvalue=up
end	

function _draw()
	cls()
	draw_cave()
 draw_player()
 print("upvalue: "..upvalue,10)
 print("playery: "..player.y,10)
	print("player.dy: "..player.dy,10)
 print("cave@64 top: "..cave[64].top)
 print("cave@64 bot: "..cave[64].btm)
end
-->8
--player tab: code for player
function make_player()
	player={} --tables
	player.x=24 
	player.y=60 
	player.dy=0
	player.rise=7 --sprite numbers
	player.fall=9
	player.deal=11
	player.speed=2 --moving right
	player.score=0
end

function draw_player()
	if (game_over) then
		spr(player.dead,player.x,player.y,2,2)
	elseif (player.dy<0) then
		spr(player.rise,player.x,player.y,2,2)
 else		
		spr(player.fall,player.x,player.y,2,2)
	end
end 

function move_player()
	gravity=0.2 --bigger means more gravity
	player.dy=player.dy+gravity --adds gravity
	
	--jump
	if (btnp(2)) then
		player.dy-=5 --jump 5 pixels
		
	end
		--move player to new position
	
	player.y=mid(0,player.y,111)
	player.y=player.y+player.dy
		
end
-->8
--cave walls
function make_cave()
	--cave={{["top"]=5,["btm"]=119}}
	--same as
	cave={{}} --2 dimensional table
	cave[1].top=5
	cave[1].btm=119

	top=45 --how low the ceiling
	btm=85 --how high the ceiling
end

function update_cave()
	--remove the back of the cave
	if (#cave>player.speed) then
		for i=1, player.speed do
			del(cave,cave[i])
		end
	end
		
	
	--add more cave
	while (#cave<128) do
		local col={}
		local up=flr(rnd(7)-3)
		local dwn=flr(rnd(7)-3)
		col.top=mid(3,cave[#cave].top+up,top)
		col.btm=mid(btm,cave[#cave].btm+dwn,124)
		add(cave,col)
		--this is updating the top and bottom as it adds the table
		update_up(up)
		end
end	

function draw_cave()
	top_color=5
	btm_color=5
	for i=1,#cave do
		line(i-1,0,i-1,cave[i].top,top_color)
		line(i-1,127,i-1,cave[i].btm,btm_color)
	end
end
__gfx__
0000000000aaaa0000aaaa00008888000088800000777000007770000000aaaaaaaa00000000aaaaaaaa00000000088888800000000000000000000000000000
000000000aaaaaa00aaaaaa008888880008880000077700000777000000aaaaaaaaaa000000aaaaaaaaaa0000008888888888000000000000000000000000000
00700700aa0aa0aaaaaaaaaa8898898880080080700700700007000000aaaaaaaaaaaa0000aaaaaaaaaaaa000088898888988800000000000000000000000000
00077000aaaaaaaaaa0aa0aa888888880888888007777770007770000aaaaaaaaaaaaaa00aaaaaaaaaaaaaa00888889889888880000000000000000000000000
00077000aa0000aaaaaaaaaa88899888000700000007000007070700aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0888888998888880000000000000000000000000
00700700aaa00aaaaaa00aaa88988988000800000007000070070070aaaa00aaaa00aaaaaaaaaaaaaaaaaaaa8888888998888888000000000000000000000000
000000000aaaaaa00aa00aa008888880000700000007000000070000aaaa04aaaa40aaaaaaaa00aaaa00aaaa8888899889988888000000000000000000000000
0000000000aaaa0000aaaa0000888800008080000070700000707000aaaaaaaaaaaaaaaaaaaa04aaaa40aaaa8888988888898888000000000000000000000000
0000000000aaaa000000000000000000000000000000000000000000aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa8888888888888888000000000000000000000000
000000000aaaaaa00000000000000000000000000000000000000000aaaa00000000aaaaaaaaaaaaaaaaaaaa8888888888888888000000000000000000000000
00000000aaaaaaaa0000000000000000000000000000000000000000aaaa00000000aaaaaaaaaa0000aaaaaa8888908888098888000000000000000000000000
00000000aaaaaaaa0000000000000000000000000000000000000000aaaaa008800aaaaa0aaaaa0880aaaaa08888998888998888000000000000000000000000
00000000aaaaaaaa00000000000000000000000000000000000000000aaaaa0000aaaaa00aaaaa0880aaaaa00888888888888880000000000000000000000000
00000000aaaaaaaa000000000000000000000000000000000000000000aaaaaaaaaaaa0000aaaa0000aaaa000088888888888800000000000000000000000000
000000000aaaaaa00000000000000000000000000000000000000000000aaaaaaaaaa000000aaaaaaaaaa0000008888888888000000000000000000000000000
0000000000aaaa0000000000000000000000000000000000000000000000aaaaaaaa000000000aaaaaa000000000888888880000000000000000000000000000
__sfx__
010200003405033050320500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010f00001c0541c0241c0541c0241d0541d0241f0541f0241c0541c0551f0001f0001d0001c0001a00018000180001a0001c0001a000180000000000000000000000000000000000000000000000000000000000
010f00001a0501a0501c050180501a0501d0501c050180501a0501d0501c0501a050180501a0501a0501c0501c0501d0501f0501f0501d0501c0501a05018050180501a0501c0501a05018050180500000000000
0110000028054280252805429024290552b0542b02500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__music__
00 01424344
00 02424344

