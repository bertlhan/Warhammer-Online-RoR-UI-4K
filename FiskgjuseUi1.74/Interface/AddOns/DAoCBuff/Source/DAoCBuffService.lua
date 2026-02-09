--##########################################################
--All Rights Reserved unless otherwise explicitly stated.
--You are not allowed to use any content of the .lua files from DAoCBuff without the permission of the authors.
--##########################################################

local towstring=towstring
local ti=table.insert
local mf=math.floor

function DAoCBuff.CopyTable(src)
	if(type(src)~="table")
	then
		return src
	else
		local ret={}
		local i,k
		for i,k in pairs(src)
		do
			ret[i]=DAoCBuff.CopyTable(k)
		end
		return ret
	end
end

function DAoCBuff.MergeTables(dst,src,overwrite)
	local i,k
	if(overwrite)
	then
		if(type(src)~="table")
		then
			if(src==nil)
			then
				return dst
			else
				return src
			end
		else
			if(type(dst)=="table")
			then
				for i,k in pairs(src)
				do
					DAoCBuff.MergeTables(dst[i],k,overwrite)
				end
			else
				return dst
			end
		end
	else
		if(type(src)~="table")
		then
			if(dst==nil)
			then
				return src
			else
				return dst
			end
		else
			if(type(dst)=="table")
			then
				for i,k in pairs(src)
				do
					if(dst[i]==nil)
					then
						DAoCBuff.MergeTables(dst[i],k,overwrite)
					end
				end
			else
				return src
			end
		end
	end
	return dst
end

function DAoCBuff.InstallSBDestroyer()
	if(DAoCBuff.DestroySBT==nil)
	then
		function DAoCBuff:DestroySBT()
			if(not self.dead and self.DestroySBT==nil)
			then
				self:ClearAllBuffs()
				self.dead=true
			end
		end
		BuffTracker.Update=DAoCBuff.DestroySBT
		BuffTracker.UpdateBuffs=DAoCBuff.DestroySBT
		BuffTracker.Refresh=DAoCBuff.DestroySBT
	end
end

local Colors
do
	local c1=DefaultColor.AbilityType.DAMAGING
	local c2=DefaultColor.AbilityType.HEALING
	local c3=DefaultColor.AbilityType.BUFF
	local c4=DefaultColor.AbilityType.DEBUFF
	Colors={{c1.r,c1.g,c1.b},{c2.r,c2.g,c2.b},{c3.r,c3.g,c3.b},{c4.r,c4.g,c4.b}}
end
function DAoCBuff.SetLWEffect(t,i,d,src,_,typ,delay)
	local item,color
	if(typ<5)
	then
		color=Colors[typ]
	else
		color={src.typeColorRed,src.typeColorGreen,src.typeColorBlue}
	end
	item=	{["name"]=src.name,["effectIndex"]=src.effectIndex,["duration"]=src.duration,
			["delay"]=delay,["iconNum"]=src.iconNum,["abilityId"]=src.abilityId,
			["stackCount"]=src.stackCount,["permanentUntilDispelled"]=src.permanentUntilDispelled,
			["lastU"]=nil,["effect"]=src,
			["borderC"]=color}
	t[i]=item
	d[#d+1]=item
	return item
end

function DAoCBuff.GetLWEffect(d,src,typ,delay)
	local item,color
	if(typ<5)
	then
		color=Colors[typ]
	else
		color={src.typeColorRed,src.typeColorGreen,src.typeColorBlue}
	end
	item=	{["name"]=src.name,["effectIndex"]=src.effectIndex,["duration"]=src.duration,
			["delay"]=delay,["iconNum"]=src.iconNum,["abilityId"]=src.abilityId,
			["stackCount"]=src.stackCount,["permanentUntilDispelled"]=src.permanentUntilDispelled,
			["lastU"]=nil,["effect"]=src,
			["borderC"]=color}
	d[#d+1]=item
	return item
end

function DAoCBuff.SetLWEffectA(t,i,d,src,bufftype,typ,delay,funcs)
	if(bufftype==0)
	then
		src.isBuff=false
		src.isDebuff=true
	else
		src.isBuff=true
		src.isDebuff=false
	end
	local endF,keep,item=false,true
	for _,k in ipairs(funcs)
	do
		endF,keep,item=k(i,src,item,typ,delay,d)
		if(endF)then break end
	end
	if(keep)
	then
		if(item)
		then
			item.marked=true
			t[i]=item
		else
			if(typ<5)
			then
				item=	{["name"]=src.name,["effectIndex"]=src.effectIndex,["duration"]=src.duration,
						["delay"]=delay,["iconNum"]=src.iconNum,["abilityId"]=src.abilityId,
						["stackCount"]=src.stackCount,["permanentUntilDispelled"]=src.permanentUntilDispelled,
						["marked"]=true,["lastU"]=nil,["effect"]=src,
						["borderC"]=Colors[typ]}
			else
				item=	{["name"]=src.name,["effectIndex"]=src.effectIndex,["duration"]=src.duration,
						["delay"]=delay,["iconNum"]=src.iconNum,["abilityId"]=src.abilityId,
						["stackCount"]=src.stackCount,["permanentUntilDispelled"]=src.permanentUntilDispelled,
						["marked"]=true,["lastU"]=nil,["effect"]=src,
						["borderC"]={src.typeColorRed,src.typeColorGreen,src.typeColorBlue}}
			end
			t[i]=item
			d[#d+1]=item
		end
	end
	return keep
end

local up=DataUtils.SORT_ORDER_UP
local function db_sort(table1, table2, sortKey, sortKeys)
	local value1		= table1[sortKey]
	local value2		= table2[sortKey]

	if(type(value1) == "boolean" or value1==nil)
	then
		if(value1)
		then
			value1=1
		else
			value1=0
		end
		if(value2)
		then
			value2=1
		else
			value2=0
		end
	end


	if(value1 == value2)
	then
		local fallback = sortKeys[sortKey].fallback

		if(fallback)
		then
			return db_sort(table1, table2, fallback, sortKeys)
		end
	else
		if(sortKeys[sortKey].sortOrder == up)
		then
			return value1 < value2
		end

		return value1 > value2
	end

	return false
end
DAoCBuff.CompareBuffs=db_sort

local function _insert(t,i,n,k,sk)
	local p=1
	local l=n
	while(l-p>2)
	do
		n=mf((l-p)/2+p)
		if(db_sort(t[n],i,k,sk))
		then
			p=n
		else
			l=n
		end
	end
	n=l-p
	if(db_sort(t[p],i,k,sk))
	then
		if(n==2 and db_sort(t[p+1],i,k,sk))
		then
			ti(t,p+2,i)
		else
			ti(t,p+1,i)
		end
	else
		ti(t,p,i)
	end
end

local function insert(t,i,k,sk,limit)
	local nt=#t
	if(nt>1)
	then
		if(db_sort(t[nt],i,k,sk))
		then
			if(nt<limit)
			then
				t[nt+1]=i
			end
		else
			if(nt+1>limit)then t[nt]=nil end
			_insert(t,i,nt,k,sk)
		end
	else
		if(nt==0)then t[1]=i
		else
			if(db_sort(t[1],i,k,sk))
			then
				t[2]=i
			else
				t[2]=t[1]
				t[1]=i
			end
		end
	end
end
DAoCBuff.insert=insert

local h=GetStringFormat(StringTables.Default.LABEL_X_H,{})
local m=GetStringFormat(StringTables.Default.LABEL_X_M,{})
local s=GetStringFormat(StringTables.Default.LABEL_X_S,{})
function DAoCBuff.GetTime(t)
	if(t>90)
	then
		if(t>5400)then return towstring(mf(t/3600+0.5))..h
		else return towstring(mf(t/60+0.5))..m end
	else
		return towstring(mf(t+0.5))..s
	end
end

local function confirmTypeR(conditions,target)
	local tmp=false
	for i,k in ipairs(conditions)
	do
		if(k[1]==target)
		then
			return true
		else
			if(k[1]==4)then tmp=confirmTypeR(k[2],target) end
		end
		if(tmp==true)then return true end
	end
	return false
end

local function confirmTypeItemR(conditions,target,content)
	local tmp=false
	for i,k in ipairs(conditions)
	do
		if(k[1]==target)
		then
			return (content==k[2])
		else
			if(k[1]==4)then tmp=confirmTypeR(k[2],target) end
		end
		if(tmp==true)then return true end
	end
	return false
end

local function checkexternal(conditions)
	local tmp=false
	for i,k in ipairs(conditions)
	do
		if(k[1]==4)
		then
			if(conditions[5]~=nil and #conditions[5]>0)
			then
				return true
			end
			tmp=checkexternal(k[2])
			if(tmp==true)then return true end
		end
	end
	return false
end

function DAoCBuff.CreateNestedFilter(condition)
	if(condition[1]~=4)then return nil end
	local str="G7ff"
	local G={false,false,false,false,false}
	local G2e=false
	for i,k in ipairs(condition[2])
	do
		G[k[1]]=true
		if(G[1]==2 and G[4]~=nil)
		then
			G2e=true
		end
	end
	if(G2e)then str=str.."t"
	else str=str.."f" end
	str=str.."f"
	if(condition[3]) then str=str.."t"
	else str=str.."f" end
	if(condition[4])then str=str.."t"
	else str=str.."f" end
	if(#condition[2]>1 or (condition[5]~=nil and #condition[5]>0))then str=str.."t"
	else str=str.."f" end
	local G={}
	G[1]=false
	G[2]=false
	G[4]=false
	G[5]=false
	for i,k in ipairs(condition[2])
	do
		G[k[1]]=true
	end
	if(G[1])then str=str.."t"
	else str=str.."f" end
	if(G[2])then str=str.."t"
	else str=str.."f" end
	if(G[4])then str=str.."t"
	else str=str.."f" end
	if(G[5])then str=str.."t"
	else str=str.."f" end
	if(condition[5]~=nil and #condition[5]>0)then str=str.."t"
	else str=str.."f" end
	return DAoCBuff.Filters[str](true,false,condition[2],nil,condition[5])
end

function DAoCBuff.CreateFilter(tracker,filter)
	if(filter.active)
	then
		if(filter.classtable==nil or filter.classtable[GameData.Player.career.id])
		then
			local data
			if(filter.condense)
			then
				data={}
				local tmp=filter.addPrefs
				if		(tmp.isDamaging)		then data.borderC=Colors[1]
				elseif	(tmp.isHealing)			then data.borderC=Colors[2]
				elseif	(tmp.isDebuff)			then data.borderC=Colors[3]
				else								 data.borderC=Colors[4]
				end
				table.insert(tracker.Condense,data)
				data.entries={}
				data.stackCount=0
				data.permanentUntilDispelled=true
				data.duration=0
				data.iconNum=filter.icon
				data.name=towstring(filter.name)
				data.effectIndex=0
				data.combathide=filter.combathide
				data.iscondensed=true
				data.enabled=false
				data.tracker=tracker
				if(filter.borderC~=nil)
				then
					data.borderC=filter.borderC
				end
				data.iconC=filter.iconC
			end
			local ccolor=true
			if(filter.borderC==nil and filter.iconC==nil)
			then
				ccolor=false
			end
			if(ccolor and data==nil)
			then
				data={["borderC"]=filter.borderC,["iconC"]=filter.iconC}
			end
			if(filter.delete)
			then
				filter.enda=true
			end

			local str="G7"
			if(filter.condense)then str=str.."t"
			else str=str.."f" end
			if(#filter.conditions<2 or confirmTypeR(filter.conditions,5) or checkexternal(filter.conditions) or confirmTypeItemR(filter.conditions,1,"castByPlayer"))
			then
				str=str.."f"
			else
				str=str.."t"
			end
			local G={false,false,false,false,false}
			local G2e=false
			for i,k in ipairs(filter.conditions)
			do
				G[k[1]]=true
				if(k[1]==2)
				then
					k[4]=nil
					if(k[3]~=nil and DAoCBuffVar.Tables[k[3]]~=nil)
					then
						for j,l in pairs(DAoCBuffVar.Tables[k[3]])
						do
							if(type(j)~="number")
							then
								k[4]="name"
								G2e=true
								break
							end
						end
					end
				end
			end
			if(G2e)then str=str.."t"
			else str=str.."f" end
			if(ccolor)then str=str.."t"
			else str=str.."f" end
			if(filter.useand)then str=str.."t"
			else str=str.."f" end
			if(filter.notresult)then str=str.."t"
			else str=str.."f" end
			if(#filter.conditions>1 or (filter.external~=nil and #filter.external>0))then str=str.."t"
			else str=str.."f" end

			if(G[1])then str=str.."t"
			else str=str.."f" end
			if(G[2])then str=str.."t"
			else str=str.."f" end
			if(G[4])then str=str.."t"
			else str=str.."f" end
			if(G[5])then str=str.."t"
			else str=str.."f" end
			if(filter.external~=nil and #filter.external>0)then str=str.."t"
			else str=str.."f" end

			if(filter.condense or filter.delete or filter.enda or ccolor)
			then
				ti(tracker.funcA,DAoCBuff.Filters[str](filter.enda,not filter.delete,filter.conditions,data,filter.external))
			end
		end
	end
end
