--##########################################################
--All Rights Reserved unless otherwise explicitly stated.
--You are not allowed to use any content of the .lua files from DAoCBuff without the permission of the authors.
--##########################################################

local encfuncs={}
local decfuncs={}
local strcompress

local n2b={"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","0","1","2","3","4","5","6","7","8","9","+","/"}
local b2n={[61]=0}
for i,k in ipairs(n2b)do b2n[k:byte()]=i-1 end
local ref={"glass","maxBuffCount","Frames","combathide","icon","isHex","isDebuff","trackerPriority","y","font","test","horizontal","scale","isBuff","ismine","buffTargetType","notresult","delete","permabuffs","bufforder","lists","longtimehide","showborder","borderC","FA","update","anchor","filters","iconNum","growup","effectText","x","isAilment","isDamaging","version","DAoC_new_qm","abilityId","All","buffRowStride","inCombat","divide","castByPlayer","active","Stickname","isHealing","isCurse","addPrefs","external","item","GameData","duration","staticcondense","permanentUntilDispelled","ccolor","condense","type","growleft","Tables","hpte","buffsbelow","name","enda","Player","longtoperma","rowcount","useand","conditions","killbuffs","classtable","Frame","Filter","List"}
local fer={}
for i,k in ipairs(ref)do fer[k]=i end

local function encode(item)
	local tmp=encfuncs[type(item)]
	if(tmp~=nil)then return tmp(item)
	else return nil end
end

local function getstrings()
	local ret=""
	local tmp={}
	local str,ti
	local x=0
	for i,k in pairs(strcompress)
	do
		ti=type(i)
		if(ti=="string")
		then
			str=stringenc(i)
			tmp[k]="s:"..tostring(str:len())..":"..str
			x=x+1
		else
			if(ti=="wstring")
			then
				str=wstringenc(i)
				tmp[k]="w:"..tostring(str:len())..":"..str
				x=x+1
			end
		end
	end
	for i=1,x
	do
		ret=ret..tmp[i]
	end
	return "c:"..x..":"..ret
end

function DAoCBuff.Encode(item)
	if(item~=nil)
	then
		strcompress={0}
		local tmp=encode(item)
		tmp=getstrings()..tmp
		strcompress=nil
		return tmp
	else
		return nil
	end
end

local function decode(str)
	local _,_,i,rest=string.find(str,"(.):(.*)")
	local tmp=decfuncs[i]
	if(tmp~=nil)then return tmp(rest)
	else return nil end
end

function DAoCBuff.Decode(str,tmpl)
	if(str~=nil and type(str)=="string")
	then
		local tmp,rest=decode(str:gsub("%s",""))
		if(tmp=="_decompressed_")
		then
			tmp=decode(rest)
		end
		strcompress=nil
		return tmp
	else
		return nil
	end
end

function encfuncs.table(item)
	local ret=""
	local x=0
	for i,k in pairs(item)
	do
		ret=ret..encode(i)..encode(k)
		x=x+1
	end
	return "t:"..x..":"..ret
end

function encfuncs.string(item)
	local tmp=fer[item]
	if(tmp~=nil)
	then
		return "f:"..tmp
	else
		tmp=strcompress[item]
		if(tmp~=nil)
		then
			return "r:"..tmp
		else
			strcompress[1]=strcompress[1]+1
			strcompress[item]=strcompress[1]
			return "r:"..strcompress[1]
		end
	end
end
encfuncs.wstring=encfuncs.string

function encfuncs.number(item)
	return "n:"..tostring(item)
end

function encfuncs.boolean(item)
	if(item)
	then
		return "b:t"
	else
		return "b:f"
	end
end

encfuncs["function"]=function (item)
	return ""
end

function decfuncs.t(str)
	local t={}
	local x=0
	local _,_,idx,rest=string.find(str,"(%d+):(.*)")
	local num=tonumber(idx)
	if(num==nil)then return nil end
	while(x<num and rest~="")
	do
		idx,rest=decode(rest)
		t[idx],rest=decode(rest)
		x=x+1
	end
	return t,rest
end

function decfuncs.c(str)
	strcompress={}
	local x=0
	local _,_,str,rest=string.find(str,"(%d+):(.*)")
	local num=tonumber(str)
	if(num==nil)then return nil end
	while(x<num and rest~="")
	do
		str,rest=decode(rest)
		table.insert(strcompress,str)
		x=x+1
	end
	return "_decompressed_",rest
end

function decfuncs.b(str)
	if(str:sub(1,1)=="t")then return true,str:sub(2)
	else return false,str:sub(2) end
end

function decfuncs.n(str)
	local _,_,n,rest=string.find(str,"([%d.]+)(.*)")
	return tonumber(n),rest
end

function decfuncs.f(str)
	local _,_,i,rest=string.find(str,"(%d+)(.*)")
	return ref[tonumber(i)],rest
end

function decfuncs.r(str)
	local _,_,i,rest=string.find(str,"(%d+)(.*)")
	return strcompress[tonumber(i)],rest
end

function decfuncs.s(str)
	local _,_,n,rest=string.find(str,"(%d+):(.+)")
	return stringdec(rest:sub(1,n)),rest:sub(n+1)
end

function decfuncs.w(str)
	local  _,_,n,rest=string.find(str,"(%d+):(.+)")
	return wstringdec(rest:sub(1,n)),rest:sub(n+1)
end

local function blockenc(t)
	local len=#t
	local tmp=math.floor(t[1]/4)
	t[1]=t[1]-tmp*4
	local ret=n2b[tmp+1]
	if(t[2]~=nil)
	then
		tmp=math.floor(t[2]/16)
		t[2]=t[2]-tmp*16
	else
		tmp=0
	end
	ret=ret..n2b[tmp+t[1]*16+1]
	if(len>1)
	then
		if(t[3]~=nil)
		then
			tmp=math.floor(t[3]/64)
			t[3]=t[3]-tmp*64
		else
			tmp=0
		end
		ret=ret..n2b[tmp+t[2]*4+1]
		if(len>2)
		then
			ret=ret..n2b[t[3]+1]
		else
			ret=ret.."="
		end
	else
		ret=ret.."=="
	end
	return ret
end

function stringenc(str)
	local ret=""
	while(str:len()>0)
	do
		ret=ret..blockenc({str:byte(1,3)})
		str=str:sub(4)
	end
	return ret
end

function wstringenc(str)
	local ret=""
	local tmp={}
	while(str:len()>0)
	do
		if(str:len()>2)
		then
			tmp[1]=str:byte(1,1)
			tmp[2]=math.floor(tmp[1]/256)
			tmp[3]=str:byte(2,2)
			tmp[4]=math.floor(tmp[3]/256)
			ret=ret..blockenc({tmp[1]-tmp[2]*256,tmp[2],tmp[3]-tmp[4]*256})
			tmp[1]=str:byte(3,3)
			tmp[2]=math.floor(tmp[1]/256)
			ret=ret..blockenc({tmp[4],tmp[1]-tmp[2]*256,tmp[2]})
			str=str:sub(4)
		else
			tmp[1]=str:byte(1,1)
			tmp[2]=math.floor(tmp[1]/256)
			ret=ret..blockenc({tmp[1]-tmp[2]*256,tmp[2]})
			str=str:sub(2)
		end
	end
	return ret
end

local function blockdec(t)
	local ret={0,0,0}
	local tmp1=b2n[t[2]]
	local tmp2=math.floor(tmp1/16)
	ret[1]=b2n[t[1]]*4+tmp2
	local tmp3=b2n[t[3]]
	local tmp4=math.floor(tmp3/4)
	ret[2]=(tmp1-tmp2*16)*16+tmp4
	ret[3]=(tmp3-tmp4*4)*64+b2n[t[4]]
	if(ret[2]==0 and t[4]==61 and t[3]==61)then ret[2]=nil end
	if(ret[3]==0 and t[4]==61)then ret[3]=nil end
	return ret
end

function stringdec(str)
	local ret=""
	while(str:len()>0)
	do
		ret=ret..string.char(unpack(blockdec({str:byte(1,4)})))
		str=str:sub(5)
	end
	return ret
end

function wstringdec(str)
	local ret=L""
	local tmp
	local strc
	while(str:len()>0)
	do
		tmp=blockdec({str:byte(1,4)})
		strc={}
		strc[1]=tmp[1]+tmp[2]*256
		if(tmp[3]~=nil)
		then
			strc[2]=tmp[3]
			tmp=blockdec({str:byte(5,8)})
			strc[2]=strc[2]+tmp[1]*256
			strc[3]=tmp[2]+tmp[3]*256
			str=str:sub(9)
		else
			str=str:sub(5)
		end
		ret=ret..wstring.char(unpack(strc))
	end
	return ret
end

local function verify(item,tmpl)
	local new={}
	local pass=true
	if(tmpl.normal~=nil)
	then
		for i,k in pairs(tmpl.normal)
		do
			if(type(k)=="table")
			then
				new[i],pass=verify(item[i],k)
				item[i]=nil
				if(not pass)then break end
			elseif(type(item[i])==k or k=="skip")
			then
				new[i]=item[i]
				item[i]=nil
			else
				pass=false
				break
			end
		end
	end
	if(pass)
	then
		local hit
		for i,k in pairs(item)
		do
			if(type(k)=="table")
			then
				hit=false
				for j,l in ipairs(tmpl)
				do
					if(l.idx==nil or k[l.idx]==l.mark)
					then
						local tmp,v=verify(k,l.template)
						if(v)
						then
							new[i]=tmp
							item[i]=nil
							hit=true
						end
						pass=v
						break
					end
				end
				if(not hit)then pass=false end
				if(not pass)then break end
			end
		end
	end
	if(pass)
	then
		for i,k in pairs(item)do pass=false;break end
	end
	return new,pass
end
DAoCBuff.Verify=verify

local PacketManager={}
DAoCBuff.PacketManager=PacketManager

function PacketManager.Add(p,s)
	local t=""
	if(p~=nil)then t="Overwritten previos packet set.\n" end
	s=s:gsub("%s","")
	if(s:sub(1,1)=="-")
	then
		local _,_,c,n,l,rest=string.find(s,"-(%d+):(%d+):(%d+)\+(.*)")
		if(tonumber(l)==rest:len())
		then
			p={}
			p.c=c
			p.n=n
			p[1]=rest
			p.complete=false
			return p,t.."Recieved first packed of "..n.."packets.\nPlease insert the second packet."
		else
			return p,"The packet you inserted was damaged\nand has been ignored."
		end
	end
	if(s:sub(1,1)=="+")
	then
		local _,_,l,rest=string.find(s,"+(%d+)\+(.*)")
		if(tonumber(l)==rest:len())
		then
			return rest,t
		else
			return p,"The packet you inserted was damaged\nand has been ignored."
		end
	end
	if(p~=nil)
	then
		local _,_,c,n,l,rest=string.find(s,"(%d+):(%d+):(%d+)\+(.*)")
		if(tonumber(l)==rest:len())
		then
			if(p.c==c)
			then
				n=tonumber(n)
				if(p[n]==nil)
				then
					p[n]=rest
					local complete=true
					for i=1,p.n
					do
						if(p[i]==nil)
						then
							complete=false
							break
						end
					end
					p.complete=complete
					if(complete)
					then
						return p,"Inserted packet number "..n..".\nSet is now Complete.\n"
					else
						local hit=1
						for i=1,p.n
						do
							if(p[i]==nil)
							then
								hit=i
								break
							end
						end
						return p,"Inserted packet number "..n..".\nPlease insert packet number "..hit.."."
					end
				else
					return p,"The packet number "..n.."  was already inserted for this set.\nPlease insert the next correct packet."
				end
			else
				return p,"This packet was ignored because it does not belong to this set.\nPlease insert the next correct packet."
			end
		else
			return p,"The packet you inserted was damaged\nand has been ignored.\nPlease make sure to copy everything correctly."
		end
	else
		return p,"Your input did not match any familiar pattern.\nPlease begin with the first packet if it is a set of packets."
	end
end

function PacketManager.Create(s)
	local len=s:len()
	if(len<988)
	then
		return "+"..s:len().."+"..s
	else
		local d=GetTodaysDate()
		local t=GetComputerTime()+(d.todaysDay+(d.todaysMonth+(d.todaysYear-2009)*12)*31)*86400
		local x=math.floor(len/975+1)
		local ret={}
		local tmp
		tmp=s:sub(1,975)
		ret[1]="-"..t..":"..x..":"..tmp:len().."+"..tmp
		s=s:sub(976)
		for i=2,x
		do
			tmp=s:sub(1,975)
			ret[i]=tostring(t)..":"..i..":"..tmp:len().."+"..tmp
			s=s:sub(976)
		end
		return ret
	end
end

function PacketManager.Combine(p)
	if(p.complete)
	then
		local s=""
		for i=1,p.n
		do
			s=s..p[i]
		end
		return s
	else
		return nil
	end
end