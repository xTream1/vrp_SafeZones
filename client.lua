inSafeZone = false
safeZone = nil

safeZones = {
	-- {x, y, z, arie}
	["showroom"] = {-43.726108551026,-1101.1746826172,35.20348739624, 50},
	["spital"] = {366.35552978516,-593.0092163086,28.69900894165, 35},
	["politie"] = {439.81991577148,-990.33282470704,43.691638946534, 60},
	["swat"] = {-1102.8555908204,-262.93338012696,37.739303588868, 35},
        ["primarie"] = {-516.20556640625,-293.70510864258,35.22013092041, 70}
}
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		
		local playerPos = GetEntityCoords(GetPlayerPed(-1), true)
		local px,py,pz = playerPos.x, playerPos.y, playerPos.z
		
		for i, v in pairs(safeZones)do
			x, y, z = v[1], v[2], v[3]
			radius = v[4]
			if(Vdist(x, y, z,px,py,pz) < radius)then
				inSafeZone = true
				safeZone = i
			end
		end
		if(safeZone ~= nil)then
			x2, y2, z2 = safeZones[safeZone][1], safeZones[safeZone][2], safeZones[safeZone][3]
			radius2 = safeZones[safeZone][4]
			if(Vdist(x2, y2, z2,px,py,pz) > radius2)then
				inSafeZone = false
				safeZone = nil
			end
		end
	end
end)

function vehPrs_drawTxt(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if (inSafeZone == true)then
			DisableControlAction(0,24,true)
			DisableControlAction(0,25,true)
			DisableControlAction(0,47,true)
			DisableControlAction(0,58,true)
			DisableControlAction(0,263,true)
			DisableControlAction(0,264,true)
			DisableControlAction(0,257,true)
			DisableControlAction(0,140,true)
			DisableControlAction(0,141,true)
			DisableControlAction(0,142,true)
			DisableControlAction(0,143,true)
			vehPrs_drawTxt("You are now in a ~g~safezone")
		end
	end
end)
