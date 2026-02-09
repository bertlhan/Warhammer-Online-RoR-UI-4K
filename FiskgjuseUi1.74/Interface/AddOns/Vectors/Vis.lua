
local Vis={}
Vectors.Vis=Vis
local Point=Frame:Subclass("Vectors_Point")
local Point_Hook=Frame:Subclass("Vectors_Invis")

local ipairs=ipairs
local math=math
local WindowGetAlpha=WindowGetAlpha
local WindowStartPositionAnimation=WindowStartPositionAnimation
local WindowGetScale=WindowGetScale
local WindowSetScale=WindowSetScale
local ti=table.insert
local tr=table.remove

local Jobs={}
local pool={}


function Vis.Shutdown()
	for i,k in ipairs(Jobs)
	do
		if(k.newpoint)then k.newpoint:Shutdown() end
		for j,l in ipairs(k)
		do
			l:Shutdown()
		end
	end
	Jobs={}
end

function Vis.Update(e)
	for i,k in ipairs(Jobs)
	do
		if(Vis.UpdateJob(k,e))
		then
			tr(Jobs,i)
		end
	end
end

function Vis.UpdateJob(j,e)
	if(j.newpoint)
	then
		if(j.newpoint:GetAlpha()==1)
		then
			j.newpoint:Start(j.startX,j.startY,j.endX,j.endY,math.min(3,0.6*(math.max(#j,j.last or 0)/2)+0.8))
			ti(j,1,j.newpoint)
			j.newpoint=nil
		end
	else
		if(j.active)
		then
			j.e=j.e+e
			if(j.e>math.max(0.1,0.01+0.01*(math.max(#j,j.last or 0)/2)))
			then
				j.newpoint=Point:Create(j.startX,j.startY,j.highlight,j.scale)
				j.e=0
			end
		end
	end
	local tmp
	while(true)
	do
		tmp=j[#j]
		if(tmp~=nil)
		then
			local alpha=tmp:GetAlpha()
			if(alpha<1 and alpha==(tmp.lastalpha or 1))
			then
				tmp:Destroy()
				j[#j]=nil
			else
				tmp.lastalpha=alpha
				break
			end
		else
			break
		end
	end
	return not (j.active or j.newpoint or #j>0)
end

function Vis.Show(name,h)
	if(not name or name=="" or name=="Root" or not DoesWindowExist(name))then return end
	local c=WindowGetAnchorCount(name)
	if(type(h)~="number" or h==0)
	then
		highlight=1
	else
		highlight=h
	end
	for i,k in ipairs(Jobs)
	do
		k.active=false
	end
	for i=1,c
	do
		Vis.AddJob(name,i,highlight==i)
	end
end

function Vis.AddJob(name,n,highlight)
	local pp,p,pw,x,y=WindowGetAnchor(name,n)
	local job={["active"]=true,["n"]=n,["name"]=name,["e"]=1,["highlight"]=highlight}
	for i,k in ipairs(Jobs)
	do
		if(k.name==name and k.n==n)
		then
			job.last=#k
			break
		end
	end
	job.endX,job.endY=Vis.GetCoordsFromAnchor(name,p)
	job.startX,job.startY=Vis.GetCoordsFromAnchor(pw,pp)
	job.scale=math.max(math.abs(job.startX-job.endX),math.abs(job.startY-job.endY))/30
	ti(Jobs,1,job)
end

function Vis.GetCoordsFromAnchor(name,point)
	WindowClearAnchors("Vectors_Invis")
	WindowAddAnchor("Vectors_Invis",point,name,"topleft",0,0)
	WindowForceProcessAnchors("Vectors_Invis")
	return WindowGetScreenPosition("Vectors_Invis")
end

local fadingout={}
local function onshutdown(windowname,visible)
	local Point=fadingout[windowname]
	if(not visible and Point)
	then
		Point:Destroy()
		fadingout[windowname]=nil
	end
end

function Point:Create(startX,startY,highlight,scale)
	local num=0
	for i = 1,150
	do
		if(pool[i]==nil)
		then
			pool[i]=true
			num=i
			break
		end
	end
	local windowname="Vectors_Point_"..num
	local newPoint=self:CreateFromTemplate(windowname,"Root")
	newPoint.windowname=windowname
	newPoint.num=num
	newPoint._Destroy=newPoint.Destroy
	newPoint.Destroy=newPoint.DestroyH
	local Hookname=windowname.."_Hook"
	newPoint.Hook=Point_Hook:CreateFromTemplate(Hookname,"Root")
	newPoint.Hook.windowname=Hookname
	WindowAddAnchor(windowname,"center",Hookname,"center",0,0)
	if(not highlight)
	then
		WindowSetTintColor(windowname,50,255,255)
	end
	if(scale>0.01)
	then
		WindowSetScale(windowname,WindowGetScale(windowname)*math.min(1,scale))
		WindowStartPositionAnimation(Hookname,Window.AnimationType.SINGLE_NO_RESET,startX+math.random(-10,10),startY+math.random(-10,10),startX,startY,0.5,false,0,0)
		WindowSetShowing(windowname.."_Scope",false)
	else
		WindowStartPositionAnimation(Hookname,Window.AnimationType.SINGLE_NO_RESET,startX,startY,startX,startY,0.5,false,0,0)
		WindowSetShowing(windowname.."_Icon",false)
	end

	Fader.Register(windowname,nil,nil,onshutdown)
	Fader.FadeTo(windowname,1,0.4,0,0)

	newPoint.Hook:Show(true)
	newPoint:Show(true)
	return newPoint
end

function Point:Start(startX,startY,endX,endY,duration)
	WindowStartPositionAnimation(self.Hook.windowname,Window.AnimationType.SINGLE_NO_RESET,startX,startY,endX,endY,duration,false,0,0)
	Fader.FadeTo(self.windowname,0,0.3,0.3+duration)
end

function Point:DestroyH()
	Fader.Unregister(self.windowname)
	self.Hook:Destroy()
	self:_Destroy()
	pool[self.num]=nil
end

function Point:GetAlpha()
	return WindowGetAlpha(self.windowname)
end

function Point:Shutdown()
	fadingout[self.windowname]=self
	Fader.FadeTo(self.windowname,0,0.6)
end
