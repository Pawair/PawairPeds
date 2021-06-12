ESX = nil


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
	end
end)

RegisterNetEvent('setgroup')
AddEventHandler('setgroup', function()
    group = true
end)    

Citizen.CreateThread(function()
    while true do
        
        Citizen.Wait( 5000 )

        if NetworkIsSessionStarted() then
            TriggerServerEvent( "checkadmin")
        end
    end
end )


function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)


	AddTextEntry('FMMC_KEY_TIP1', TextEntry) 
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght) 
	blockinput = true 

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
		Citizen.Wait(0)
	end
		
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult() 
		Citizen.Wait(500) 
		blockinput = false 
		return result 
	else
		Citizen.Wait(500) 
		blockinput = false 
		return nil 
	end
end




RMenu.Add('ped', 'main', RageUI.CreateMenu( "PawairPeds V1" , "Peds Menu"))
RMenu:Get('ped', 'main'):SetRectangleBanner(0, 0, 0)
RMenu.Add('ped', 'creat', RageUI.CreateSubMenu(RMenu:Get('ped', 'main'), "Male Peds", "Male Peds"))
RMenu.Add('ped', 'male', RageUI.CreateSubMenu(RMenu:Get('ped', 'main'), "Male Peds", "Male Peds"))
RMenu.Add('ped', 'fema', RageUI.CreateSubMenu(RMenu:Get('ped', 'main'), "Female Peds", "Female Peds"))
RMenu.Add('ped', 'anim', RageUI.CreateSubMenu(RMenu:Get('ped', 'main'), "Animals Peds", "Animals Peds"))
RMenu.Add('ped', 'other', RageUI.CreateSubMenu(RMenu:Get('ped', 'main'), "Other Peds", "Other Peds"))
RMenu.Add('ped', 'add', RageUI.CreateSubMenu(RMenu:Get('ped', 'main'), "Add-On Peds", "Add-On Peds"))
RMenu.Add('ped', 'cred', RageUI.CreateSubMenu(RMenu:Get('ped', 'main'), "Créditations", "Créditations"))
RMenu.Add('ped', 'gang', RageUI.CreateSubMenu(RMenu:Get('ped', 'main'), "Gangs Peds", "Gangs Peds"))
RMenu.Add('ped', 'gangfem', RageUI.CreateSubMenu(RMenu:Get('ped', 'gang'), "Female Peds", "Female Peds"))
RMenu.Add('ped', 'gangmal', RageUI.CreateSubMenu(RMenu:Get('ped', 'gang'), "Male Peds", "Male Peds"))


--cree sous menu
Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('ped', 'main'), true, true, true, function()
            
            RageUI.Button("Default", "To recover by default", {RightBadge = RageUI.BadgeStyle.Alert}, true, function(Hovered, Active, Selected)
                if (Selected) then   
                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                    local isMale = skin.sex == 0
    
    
                    TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
                        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                            TriggerEvent('skinchanger:loadSkin', skin)
                            TriggerEvent('esx:restoreLoadout')
                 
                    
                    end)
                    end)
                    end)
                end
            end)  
                    RageUI.Button("~b~Peds search", "Search for a ped ( Example : a_m_y_hipster_02 ) https://docs.fivem.net/docs/game-references/ped-models/",{RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if (Selected) then   
                            local j1 = PlayerId()
                            local newped = KeyboardInput('Search for a ped Enter a ped under penalty of deco reco ! ', '', 45)
                            local p1 = GetHashKey(newped)
                            while not HasModelLoaded(p1) do
                                Wait(100)
                          
                            end
                             SetPlayerModel(j1, p1)
                             SetModelAsNoLongerNeeded(p1)
                             ESX.ShowNotification('Your character ~g~was correctly changed')
                             
                            end 
                        end)

            RageUI.Button("Male Peds", "Male Peds", {RightLabel = ">>>"},true, function()
            end, RMenu:Get('ped', 'male'))

            RageUI.Button("Female Peds", "Female Peds", {RightLabel = ">>>"}, true, function()
            end, RMenu:Get('ped', 'fema'))

            RageUI.Button("Animals Peds", "Animals Peds", {RightLabel = ">>>"}, true, function()
            end, RMenu:Get('ped', 'anim'))

            RageUI.Button("Gangs Peds", "Gangs Peds", {RightLabel = ">>>"}, true, function()
            end, RMenu:Get('ped', 'gang'))

            RageUI.Button("~m~Other Peds", "Available soon", {RightBadge = RageUI.BadgeStyle.Lock}, true, function(Hovered, Active, Selected)
            end)

            RageUI.Button("~m~Add-On Peds", "Available soon", {RightBadge = RageUI.BadgeStyle.Lock}, true, function(Hovered, Active, Selected)
            end)
           
            RageUI.Button("Credit", "PawairPeds Creditations", {RightBadge = RageUI.BadgeStyle.Star}, true, function()
            end, RMenu:Get('ped', 'cred'))

           

        end, function()
        end)

        RageUI.IsVisible(RMenu:Get('ped', 'gang'), true, true, true, function()
            RageUI.Button("Male Peds", "Gang Male Peds", {RightLabel = ">>>"}, true, function()
            end, RMenu:Get('ped', 'gangmal'))
            RageUI.Button("Female Peds", "Gang Female Peds", {RightLabel = ">>>"}, true, function()
            end, RMenu:Get('ped', 'gangfem'))
        end)

        RageUI.IsVisible(RMenu:Get('ped', 'gangmal'), true, true, true, function()

            RageUI.Button("g_m_importexport_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('g_m_importexport_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end ) 

            RageUI.Button("g_m_m_armboss_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('g_m_m_armboss_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end ) 

            RageUI.Button("g_m_m_armgoon_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('g_m_m_armgoon_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end ) 
            
            RageUI.Button("g_m_m_armlieut_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('g_m_m_armlieut_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end )
            
            RageUI.Button("g_m_m_chemwork_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('g_m_m_chemwork_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end ) 

            RageUI.Button("g_m_m_chiboss_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('g_m_m_chiboss_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end ) 

            RageUI.Button("g_m_m_chicold_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('g_m_m_chicold_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end ) 

            RageUI.Button("g_m_m_chigoon_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('g_m_m_chigoon_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end ) 

            RageUI.Button("g_m_m_chigoon_02", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('g_m_m_chigoon_02')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end ) 

            RageUI.Button("g_m_m_korboss_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('g_m_m_korboss_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end ) 

            RageUI.Button("g_m_m_mexboss_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('g_m_m_mexboss_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end ) 

            RageUI.Button("g_m_m_mexboss_02", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('g_m_m_mexboss_02')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end ) 

            RageUI.Button("g_m_y_armgoon_02", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('g_m_y_armgoon_02')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end ) 

            RageUI.Button("g_m_y_azteca_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('g_m_y_azteca_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end ) 

            RageUI.Button("g_m_y_ballaeast_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('g_m_y_ballaeast_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end ) 

            RageUI.Button("g_m_y_ballaorig_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('g_m_y_ballaorig_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end ) 

            RageUI.Button("g_m_y_ballasout_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('g_m_y_ballasout_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end ) 

            RageUI.Button("g_m_y_famca_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('g_m_y_famca_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end ) 

            RageUI.Button("g_m_y_famdnf_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('g_m_y_famdnf_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end ) 

            RageUI.Button("g_m_y_famfor_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('g_m_y_famfor_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end ) 

            RageUI.Button("g_m_y_korean_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('g_m_y_korean_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end ) 

            RageUI.Button("g_m_y_korean_02", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('g_m_y_korean_02')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end ) 

            RageUI.Button("g_m_y_korlieut_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('g_m_y_korlieut_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end ) 

            RageUI.Button("g_m_y_lost_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('g_m_y_lost_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end ) 

            RageUI.Button("g_m_y_lost_02", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('g_m_y_lost_02')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end ) 

            RageUI.Button("g_m_y_lost_03", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('g_m_y_lost_03')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end ) 

            RageUI.Button("g_m_y_mexgang_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('g_m_y_mexgang_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end ) 

            RageUI.Button("g_m_y_mexgoon_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('g_m_y_mexgoon_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end ) 

            RageUI.Button("g_m_y_mexgoon_02", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('g_m_y_mexgoon_02')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end ) 
            
            RageUI.Button("g_m_y_mexgoon_03", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('g_m_y_mexgoon_03')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end ) 

            RageUI.Button("g_m_y_pologoon_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('g_m_y_pologoon_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end ) 

            RageUI.Button("g_m_y_pologoon_02", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('g_m_y_pologoon_02')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end ) 

            RageUI.Button("g_m_y_salvaboss_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('g_m_y_salvaboss_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end ) 

            RageUI.Button("g_m_y_salvagoon_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('g_m_y_salvagoon_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end ) 

            RageUI.Button("g_m_y_salvagoon_02", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('g_m_y_salvagoon_02')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end ) 

            RageUI.Button("g_m_y_salvagoon_03", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('g_m_y_salvagoon_03')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end ) 

            RageUI.Button("g_m_y_strpunk_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('g_m_y_strpunk_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end ) 

            RageUI.Button("g_m_y_strpunk_02", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('g_m_y_strpunk_02')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end )

            RageUI.Button("g_m_m_casrn_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('g_m_m_casrn_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end )




        end)

        RageUI.IsVisible(RMenu:Get('ped', 'gangfem'), true, true, true, function()
            
            RageUI.Button("g_f_importexport_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('g_f_importexport_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end ) 

            RageUI.Button("g_f_y_ballas_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('g_f_y_ballas_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end ) 

            RageUI.Button("g_f_y_families_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('g_f_y_families_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end ) 

            RageUI.Button("g_f_y_vagos_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('g_f_y_vagos_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end ) 

            RageUI.Button("g_f_y_lost_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('g_f_y_lost_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end ) 

            
        end)

        
    -- ########################################################################################################################################################################################
    -- ########################################################################################################################################################################################
    -- ########################################################################################################################################################################################
    -- ########################################################################################################################################################################################
    -- Debut Male
    -- ########################################################################################################################################################################################
    -- ########################################################################################################################################################################################
    -- ########################################################################################################################################################################################
    -- ########################################################################################################################################################################################
        RageUI.IsVisible(RMenu:Get('ped', 'male'), true, true, true, function()
            RageUI.Button("a_m_m_acult_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_m_acult_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end ) 
            
            RageUI.Button("a_m_m_afriamer_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_m_afriamer_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end ) 
            
            RageUI.Button("a_m_m_beach_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_m_beach_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end )

            RageUI.Button("a_m_m_beach_02", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_m_beach_02')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end )

            RageUI.Button("a_m_m_bevhills_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_m_bevhills_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end )

            RageUI.Button("a_m_m_bevhills_02", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_m_bevhills_02')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end )

            RageUI.Button("a_m_m_business_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_m_business_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end )

            RageUI.Button("a_m_m_eastsa_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_m_eastsa_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end )

            RageUI.Button("a_m_m_eastsa_02", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_m_eastsa_02')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end )

            RageUI.Button("a_m_m_farmer_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_m_farmer_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end )

            RageUI.Button("a_m_m_fatlatin_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_m_fatlatin_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end )

            RageUI.Button("a_m_m_genfat_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_m_genfat_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end )

            RageUI.Button("a_m_m_genfat_02", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_m_genfat_02')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end )

            RageUI.Button("a_m_m_golfer_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_m_golfer_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end )

            RageUI.Button("a_m_m_hasjew_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_m_hasjew_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end )

            RageUI.Button("a_m_m_hillbilly_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_m_hillbilly_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_m_hillbilly_02", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_m_hillbilly_02')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_m_indian_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_m_indian_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_m_ktown_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_m_ktown_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_m_malibu_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_m_malibu_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_m_mexcntry_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_m_mexcntry_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_m_og_boss_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_m_og_boss_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_m_paparazzi_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_m_paparazzi_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_m_polynesian_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_m_polynesian_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_m_prolhost_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_m_prolhost_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_m_rurmeth_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_m_rurmeth_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_m_salton_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_m_salton_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_m_salton_02", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_m_salton_02')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_m_salton_03", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_m_salton_03')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_m_salton_04", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_m_salton_04')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_m_skater_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_m_skater_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_m_skidrow_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_m_skidrow_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_m_socenlat_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_m_socenlat_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_m_soucent_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_m_soucent_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_m_soucent_03", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_m_soucent_03')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_m_soucent_04", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_m_soucent_04')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_m_stlat_02", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_m_stlat_02')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)
            
            RageUI.Button("a_m_m_tennis_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_m_tennis_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_m_tourist_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_m_tourist_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_m_trampbeac_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_m_tramp_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_m_trampbeac_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_m_trampbeac_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_m_tranvest_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_m_tranvest_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_m_tranvest_02", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_m_tranvest_02')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_o_acult_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_o_acult_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)
            
            RageUI.Button("a_m_o_acult_02", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_o_acult_02')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)
            
            RageUI.Button("a_m_o_beach_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_o_beach_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_o_genstreet_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_o_genstreet_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)
            
            RageUI.Button("a_m_o_ktown_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_o_ktown_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_o_salton_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_o_salton_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_o_soucent_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_o_soucent_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_o_soucent_02", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_o_soucent_02')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_o_soucent_03", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_o_soucent_03')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_o_tramp_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_o_tramp_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)
        
            RageUI.Button("a_m_y_acult_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_acult_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_acult_02", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_acult_02')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_beach_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_beach_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_beach_02", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_beach_02')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)
            
            RageUI.Button("a_m_y_beach_03", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_beach_03')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_beachvesp_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_beachvesp_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_beachvesp_02", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_beachvesp_02')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_bevhills_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_bevhills_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_bevhills_02", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_bevhills_02')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_breakdance_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_breakdance_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_busicas_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_busicas_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_business_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_business_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_business_02", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_business_02')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_business_03", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_business_03')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_clubcust_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_clubcust_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_cyclist_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_cyclist_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_dhill_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_dhill_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_downtown_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_downtown_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_eastsa_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_eastsa_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_epsilon_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_epsilon_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_epsilon_02", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_epsilon_02')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_gay_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_gay_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_gay_02", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_gay_02')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_genstreet_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_genstreet_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_genstreet_02", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_genstreet_02')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_golfer_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_golfer_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_hasjew_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_hasjew_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_hiker_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_hiker_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_hipster_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_hipster_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_hipster_02", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_hipster_02')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_hipster_03", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_hipster_03')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_indian_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_indian_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_jetski_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_jetski_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_juggalo_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_juggalo_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_ktown_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_ktown_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_ktown_02", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_ktown_02')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_latino_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_latino_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_methhead_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_methhead_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            
            RageUI.Button("a_m_y_mexthug_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_mexthug_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_motox_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_motox_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_motox_02", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_motox_02')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_musclbeac_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_musclbeac_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_musclbeac_02", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_musclbeac_02')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_polynesian_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_polynesian_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_roadcyc_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_roadcyc_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_runner_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_runner_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_runner_02", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_runner_02')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_salton_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_salton_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_skater_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_skater_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_skater_02", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_skater_02')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_soucent_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_soucent_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_soucent_02", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_soucent_02')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_soucent_03", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_soucent_03')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_soucent_04", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_soucent_04')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_stbla_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_stbla_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_stbla_02", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_stbla_02')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_stlat_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_stlat_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_stwhi_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_stwhi_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_stwhi_02", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_stwhi_02')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_sunbathe_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_sunbathe_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_surfer_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_surfer_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_vindouche_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_vindouche_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_vinewood_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_vinewood_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_vinewood_02", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_vinewood_02')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_vinewood_03", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_vinewood_03')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_vinewood_04", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_vinewood_04')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_yoga_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_yoga_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_m_mlcrisis_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_m_mlcrisis_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_gencaspat_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_gencaspat_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_m_y_smartcaspat_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_m_y_smartcaspat_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            end)
            -- ########################################################################################################################################################################################
            -- ########################################################################################################################################################################################
            -- ########################################################################################################################################################################################
            -- ########################################################################################################################################################################################
            -- Fin Male
            -- ########################################################################################################################################################################################
            -- ########################################################################################################################################################################################
            -- ########################################################################################################################################################################################
            -- ########################################################################################################################################################################################

            -- ########################################################################################################################################################################################
            -- ########################################################################################################################################################################################
            -- ########################################################################################################################################################################################
            -- ########################################################################################################################################################################################
            -- Début Female
            -- ########################################################################################################################################################################################
            -- ########################################################################################################################################################################################
            -- ########################################################################################################################################################################################
            -- ########################################################################################################################################################################################
            RageUI.IsVisible(RMenu:Get('ped', 'fema'), true, true, true, function()
                
                RageUI.Button("a_f_m_beach_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_m_beach_01')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end  
                end)

                RageUI.Button("a_f_m_bevhills_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_m_bevhills_01')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end  
                end) 

                RageUI.Button("a_f_m_bevhills_02", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_m_bevhills_02')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end  
                end) 

                RageUI.Button("a_f_m_bodybuild_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_m_bodybuild_01')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end  
                end) 

                RageUI.Button("a_f_m_business_02", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_m_business_02')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end  
                end)
                
                RageUI.Button("a_f_m_downtown_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_m_downtown_01')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end  
                end)

                RageUI.Button("a_f_m_eastsa_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_m_eastsa_01')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end  
                end)

                RageUI.Button("a_f_m_eastsa_02", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_m_eastsa_02')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end  
                end)

                RageUI.Button("a_f_m_fatbla_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_m_fatbla_01')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end  
                end)

                RageUI.Button("a_f_m_fatcult_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_m_fatcult_01')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end  
                end)

                RageUI.Button("a_f_m_fatwhite_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_m_fatwhite_01')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end  
                end)

                RageUI.Button("a_f_m_ktown_02", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_m_ktown_02')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end  
                end)

                RageUI.Button("a_f_m_prolhost_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_m_prolhost_01')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end  
                end)

                RageUI.Button("a_f_m_salton_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_m_salton_01')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end  
                end)

                RageUI.Button("a_f_m_skidrow_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_m_skidrow_01')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end  
                end)

                RageUI.Button("a_f_m_soucent_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_m_soucent_01')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end  
                end)

                RageUI.Button("a_f_m_soucent_02", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_m_soucent_02')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end  
                end)
                
                RageUI.Button("a_f_m_soucentmc_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_m_soucentmc_01')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end  
                end)

                RageUI.Button("a_f_m_tourist_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_m_tourist_01')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end  
                end)

                RageUI.Button("a_f_m_tramp_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_m_tramp_01')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end  
                end)

                RageUI.Button("a_f_m_trampbeac_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_m_trampbeac_01')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end  
                end)

                RageUI.Button("a_f_o_genstreet_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_o_genstreet_01')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end  
                end)

                RageUI.Button("a_f_o_indian_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_o_indian_01')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end  
                end)

                RageUI.Button("a_f_o_indian_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_o_indian_01')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end  
                end)

                RageUI.Button("a_f_o_ktown_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_o_ktown_01')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end  
                end)
                
                RageUI.Button("a_f_o_salton_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_o_salton_01')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end  
                end)

                RageUI.Button("a_f_o_soucent_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_o_soucent_01')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end  
                end)

                RageUI.Button("a_f_o_soucent_02", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_o_soucent_02')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end  
                end)

                RageUI.Button("a_f_y_beach_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_y_beach_01')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end  
                end)

                RageUI.Button("a_f_y_bevhills_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_y_bevhills_01')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end  
                end)

                RageUI.Button("a_f_y_bevhills_02", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_y_bevhills_02')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end  
                end)

                RageUI.Button("a_f_y_bevhills_03", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_y_bevhills_03')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end  
                end)

                RageUI.Button("a_f_y_bevhills_04", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_y_bevhills_04')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end  
                end)

                RageUI.Button("a_f_y_business_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_y_business_01')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end  
                end)

                RageUI.Button("a_f_y_business_02", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_y_business_02')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end  
                end)

                RageUI.Button("a_f_y_business_03", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_y_business_03')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end  
                end)

                RageUI.Button("a_f_y_business_04", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_y_business_04')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end  
                end)

                RageUI.Button("a_f_y_clubcust_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_y_clubcust_01')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end  
                end)

                RageUI.Button("a_f_y_clubcust_02", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_y_clubcust_02')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end  
                end)

                RageUI.Button("a_f_y_clubcust_03", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_y_clubcust_03')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end  
                end)

                RageUI.Button("a_f_y_eastsa_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_y_eastsa_01')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end   
                end)


                RageUI.Button("a_f_y_eastsa_02", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_y_eastsa_02')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end   
                end)

                RageUI.Button("a_f_y_eastsa_03", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_y_eastsa_03')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end   
                end)

                RageUI.Button("a_f_y_epsilon_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_y_epsilon_01')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end   
                end)

                RageUI.Button("a_f_y_femaleagent", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_y_femaleagent')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end   
                end)

                RageUI.Button("a_f_y_fitness_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_y_fitness_01')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end   
                end)

                RageUI.Button("a_f_y_fitness_02", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_y_fitness_02')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end   
                end)

                RageUI.Button("a_f_y_genhot_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_y_genhot_01')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end   
                end)

                RageUI.Button("a_f_y_golfer_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_y_golfer_01')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end   
                end)

                RageUI.Button("a_f_y_hiker_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_y_hiker_01')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end   
                end)

                RageUI.Button("a_f_y_hippie_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_y_hippie_01')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end   
                end)

                RageUI.Button("a_f_y_hipster_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_y_hipster_01')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end   
                end)

                RageUI.Button("a_f_y_hipster_02", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_y_hipster_02')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end   
                end)

                RageUI.Button("a_f_y_hipster_03", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_y_hipster_03')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end   
                end)

                RageUI.Button("a_f_y_hipster_04", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_y_hipster_04')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end   
                end)

                RageUI.Button("a_f_y_indian_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_y_indian_01')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end   
                end)

                RageUI.Button("a_f_y_juggalo_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_y_juggalo_01')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end   
                end)

                RageUI.Button("a_f_y_runner_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_y_runner_01')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end   
                end)

                RageUI.Button("a_f_y_rurmeth_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_y_rurmeth_01')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end   
                end)

                RageUI.Button("a_f_y_scdressy_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_y_scdressy_01')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end   
                end)
                
                RageUI.Button("a_f_y_skater_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_y_skater_01')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end   
                end)

                RageUI.Button("a_f_y_soucent_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_y_soucent_01')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end   
                end)

                RageUI.Button("a_f_y_soucent_02", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_y_soucent_02')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end   
                end)

                RageUI.Button("a_f_y_soucent_03", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_y_soucent_03')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end   
                end)

                RageUI.Button("a_f_y_tennis_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_y_tennis_01')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end   
                end)

                RageUI.Button("a_f_y_topless_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_y_topless_01')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end   
                end)

                RageUI.Button("a_f_y_tourist_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_y_tourist_01')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end   
                end)

                RageUI.Button("a_f_y_tourist_02", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_y_tourist_02')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end   
                end)

                RageUI.Button("a_f_y_vinewood_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_y_vinewood_01')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end   
                end)

                RageUI.Button("a_f_y_vinewood_02", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_y_vinewood_02')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end   
                end)

                RageUI.Button("a_f_y_vinewood_03", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_y_vinewood_03')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end   
                end)

                RageUI.Button("a_f_y_vinewood_04", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_y_vinewood_04')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end   
                end)

                RageUI.Button("a_f_y_yoga_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_y_yoga_01')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end   
                end)

                RageUI.Button("a_f_y_gencaspat_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_y_gencaspat_01')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end   
                end)

                RageUI.Button("a_f_y_smartcaspat_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                    local j1 = PlayerId()
                    local p1 = GetHashKey('a_f_y_smartcaspat_01')
                    RequestModel(p1)
                    while not HasModelLoaded(p1) do
                      Wait(100)
                     end
                     SetPlayerModel(j1, p1)
                     SetModelAsNoLongerNeeded(p1)
                     ESX.ShowNotification('Your character ~g~was correctly changed')
                    end   
                end)

                end)

              

            -- ########################################################################################################################################################################################
            -- ########################################################################################################################################################################################
            -- ########################################################################################################################################################################################
            -- ########################################################################################################################################################################################
            -- Fin Female
            -- ########################################################################################################################################################################################
            -- ########################################################################################################################################################################################
            -- ########################################################################################################################################################################################
            -- ########################################################################################################################################################################################
            RageUI.IsVisible(RMenu:Get('ped', 'anim'), true, true, true, function()
            

            RageUI.Button("a_c_boar", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_c_boar')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_c_cat_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_c_cat_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_c_chickenhawk", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_c_chickenhawk')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_c_chimp", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_c_chimp')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)
            
            RageUI.Button("~m~a_c_chop", "Available soon", {RightBadge  = RageUI.BadgeStyle.Lock},true, function(Hovered, Active, Selected)
                  
            end)

            RageUI.Button("a_c_cormorant", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_c_cormorant')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_c_cow", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_c_cow')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_c_coyote", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_c_coyote')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_c_crow", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_c_crow')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_c_deer", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_c_deer')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("~r~a_c_dolphin", "Choose this ped ? ~r~Must be in the water ", {RightBadge = RageUI.BadgeStyle.Alert},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_c_dolphin')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("~r~a_c_fish", "Choose this ped ? ~r~Must be in the water ", {RightBadge = RageUI.BadgeStyle.Alert},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_c_fish')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("~r~a_c_humpback", "Choose this ped ? ~r~Must be in the water ", {RightBadge = RageUI.BadgeStyle.Alert},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_c_humpback')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("~r~a_c_killerwhale", "Choose this ped ? ~r~Must be in the water ", {RightBadge = RageUI.BadgeStyle.Alert},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_c_killerwhale')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("~r~a_c_sharkhammer", "Choose this ped ? ~r~Must be in the water ", {RightBadge = RageUI.BadgeStyle.Alert},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_c_sharkhammer')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("~r~a_c_sharktiger",  "Available soon", {RightBadge  = RageUI.BadgeStyle.Lock},true, function(Hovered, Active, Selected)
                    
            end)

            RageUI.Button("~r~a_c_stingray", "Choose this ped ? ~r~Must be in the water ", {RightBadge = RageUI.BadgeStyle.Alert},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_c_stingray')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_c_hen", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_c_hen')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("~m~a_c_huski", "Available soon", {RightBadge  = RageUI.BadgeStyle.Lock},true, function(Hovered, Active, Selected)
                  
            end)

            RageUI.Button("~m~a_c_mtlion",  "Available soon", {RightBadge  = RageUI.BadgeStyle.Lock},true, function(Hovered, Active, Selected)
                  
            end)

            RageUI.Button("a_c_pig", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_c_pig')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_c_pigeon", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_c_pigeon')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_c_poodle", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_c_poodle')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

             RageUI.Button("a_c_pug", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_c_pug')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_c_rabbit_01", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_c_rabbit_01')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("a_c_rat", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_c_rat')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("~m~a_c_retriever",  "Available soon", {RightBadge  = RageUI.BadgeStyle.Lock},true, function(Hovered, Active, Selected)
                  
            end)

            RageUI.Button("a_c_rhesus", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_c_rhesus')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("~m~a_c_rottweiler",  "Available soon", {RightBadge  = RageUI.BadgeStyle.Lock},true, function(Hovered, Active, Selected)
                  
            end)

            RageUI.Button("a_c_seagull", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_c_seagull')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

            RageUI.Button("~m~a_c_shepherd",  "Available soon", {RightBadge  = RageUI.BadgeStyle.Lock},true, function(Hovered, Active, Selected)
                  
                end)
                  
            

            RageUI.Button("a_c_westy", "Choose this ped ?", {RightLabel = "~c~ Select"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                local j1 = PlayerId()
                local p1 = GetHashKey('a_c_westy')
                RequestModel(p1)
                while not HasModelLoaded(p1) do
                  Wait(100)
                 end
                 SetPlayerModel(j1, p1)
                 SetModelAsNoLongerNeeded(p1)
                 ESX.ShowNotification('Your character ~g~was correctly changed')
                end   
            end)

    
        end)

    --    RageUI.IsVisible(RMenu:Get('ped', 'other'), true, true, true, function()
           
   --         RageUI.Button("~m~cs_amandatownley",  "Available soon", {RightBadge  = RageUI.BadgeStyle.Lock},true, function(Hovered, Active, Selected)
                
   --             end)
            

   --         RageUI.Button("~m~cs_andreas",  "Available soon", {RightBadge  = RageUI.BadgeStyle.Lock},true, function(Hovered, Active, Selected)
                  
  --          end)

  --          RageUI.Button("~m~cs_ashley",  "Available soon", {RightBadge  = RageUI.BadgeStyle.Lock},true, function(Hovered, Active, Selected)
                  
  --          end)

--            RageUI.Button("~m~cs_bankman",  "Available soon", {RightBadge  = RageUI.BadgeStyle.Lock},true, function(Hovered, Active, Selected)
                  
 --           end)

   --         RageUI.Button("~m~cs_barry",  "Available soon", {RightBadge  = RageUI.BadgeStyle.Lock},true, function(Hovered, Active, Selected)
                  
  --          end)

  --          RageUI.Button("~m~cs_beverly",  "Available soon", {RightBadge  = RageUI.BadgeStyle.Lock},true, function(Hovered, Active, Selected)
                  
--            end)

--            RageUI.Button("~m~cs_brad",  "Available soon", {RightBadge  = RageUI.BadgeStyle.Lock},true, function(Hovered, Active, Selected)
                  
 --           end)

 --           RageUI.Button("~m~cs_bradcadaver",  "Available soon", {RightBadge  = RageUI.BadgeStyle.Lock},true, function(Hovered, Active, Selected)
 --                 
--            end)
 --       end)
         

            
            RageUI.IsVisible(RMenu:Get('ped', 'cred'), true, true, true, function()
                RageUI.Button("Develop by : ", "", {RightLabel = "~g~PWR"},true, function(Hovered, Active, Selected)
                end, RMenu:Get('ped', 'cred'))
            
                    RageUI.Button("Version : ", "", {RightLabel = "~b~1.0.0"},true, function(Hovered, Active, Selected)
                    end, RMenu:Get('ped', 'cred'))

                    RageUI.Button("Discord : ", "", {RightLabel = "~p~PWR#8263"},true, function(Hovered, Active, Selected)
                    end, RMenu:Get('ped', 'cred'))

            end)
        

        
            Citizen.Wait(0)
        end
    end)
-- cree sous menu 




 
    
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
                if group == true then 
                    if IsControlJustPressed(1,57) then
                        RageUI.Visible(RMenu:Get('ped', 'main'), not RageUI.Visible(RMenu:Get('PowerPeds V1', 'Peds menu')))
                        
                        
                    end
                end
       		 end
    end)



    
