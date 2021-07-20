pico-8 cartridge // http://www.pico-8.com
version 32
__lua__
function _init()
cave={{["top"]=5,["btm"]=119}}
top=45
btm=85
end

function _update()
	while (#cave<3) do
		local col={}
		local up=flr(rnd(7)-3)
		local dwn=flr(rnd(7)-3)
		col.top =mid(3,cave[#cave].top+up,top)
		col.btm =mid(btm,cave[#cave].btm+dwn,124)
		add(cave,col)
	end
end

function _draw()
	cls()
 print("")
	print("")
	print("")
	for i=1,#cave do
		line(i-1,0,i-1,cave[i].top,5)
	 print(i.." "..cave[i].top.." "..cave[i].btm,10)
	end
print(#cave,12)
end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
