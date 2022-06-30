------------------------------------------------------------------------------------------------------------
---------------------------------------- TELEPORTS ---------------------------------------------------------
local lastLocation = {}

function Teleport()
    MenuData.CloseAll()
    local elements = {
        { label = _U("tpm"), value = 'tpm', desc = _U("teleporttomarker_desc") },
        { label = _U("tptocoords"), value = 'tptocoords', desc = _U("teleporttocoords_desc") },
        { label = _U("tptoplayer"), value = 'tptoplayer', desc = _U("teleportplayer_desc") },
        { label = _U("tpbackadmin"), value = 'admingoback', desc = _U("sendback_desc") },
        { label = _U("bringplayer"), value = 'bringplayer', desc = _U("bringplayer_desc") },
        { label = _U("sendback"), value = 'sendback', desc = _U("sendback_desc") },
    }

    MenuData.Open('default', GetCurrentResourceName(), 'menuapi',
        {
            title    = _U("MenuTitle"),
            subtext  = _U("teleports"),
            align    = 'top-left',
            elements = elements,
            lastmenu = 'OpenMenu', --Go back
        },

        function(data)
            if data.current == "backup" then
                _G[data.trigger]()
            end
            if data.current.value == "tpm" then
                TriggerEvent('vorp:teleportWayPoint')
            elseif data.current.value == "tptocoords" then
                local myInput = {
                    type = "enableinput", -- dont touch
                    inputType = "input",
                    button = _U("confirm"), -- button name
                    placeholder = "X Y Z", --placeholdername
                    style = "block", --- dont touch
                    attributes = {
                        inputHeader = _U("insertcoords"), -- header
                        type = "text", -- inputype text, number,date.etc if number comment out the pattern
                        pattern = "[0-9 \\-\\.]{5,60}", -- regular expression validated for only numbers "[0-9]", for letters only [A-Za-z]+   with charecter limit  [A-Za-z]{5,20}     with chareceter limit and numbers [A-Za-z0-9]{5,}
                        title = "must use only numbers - and .", -- if input doesnt match show this message
                        style = "border-radius: 10px; background-color: ; border:none;", -- style  the inptup
                    }
                }

                TriggerEvent("vorpinputs:advancedInput", json.encode(myInput), function(result)
                    local coords = result
                    local admin = PlayerPedId()
                    if coords ~= "" then
                        local finalCoords = {}
                        for i in string.gmatch(coords, "%S+") do
                            finalCoords[#finalCoords + 1] = i
                        end
                        local x, y, z = tonumber(finalCoords[1]), tonumber(finalCoords[2]), tonumber(finalCoords[3])
                        DoScreenFadeOut(2000)
                        Wait(2000)
                        SetEntityCoords(admin, x, y, z)
                        DoScreenFadeIn(3000)

                    else
                        TriggerEvent("vorp:TipRight", _U("empty"))
                    end
                end)
            elseif data.current.value == "tptoplayer" then
                TriggerEvent("vorpinputs:getInput", _U("confirm"), _U("insertid"), function(result)
                    local TargetID = result
                    if TargetID ~= "" then
                        TriggerServerEvent("vorp_admin:TpToPlayer", TargetID)
                    else
                        TriggerEvent("vorp:TipRight", _U("empty"))
                    end
                end)
            elseif data.current.value == "admingoback" then
                if lastLocation then
                    TriggerServerEvent("vorp_admin:sendAdminBack")
                end
            elseif data.current.value == "bringplayer" then
                TriggerEvent("vorpinputs:getInput", _U("confirm"), _U("insertid"), function(result)
                    local TargetID = result
                    if TargetID ~= "" and lastLocation then
                        local adminCoords = GetEntityCoords(PlayerPedId())
                        TriggerServerEvent("vorp_admin:Bring", TargetID, adminCoords)
                    else
                        TriggerEvent("vorp:TipRight", _U("empty"))
                    end
                end)

            elseif data.current.value == "sendback" then
                TriggerEvent("vorpinputs:getInput", _U("confirm"), _U("insertid"), function(result)
                    local TargetID = result
                    if TargetID ~= "" and lastLocation then
                        TriggerServerEvent("vorp_admin:TeleportPlayerBack", TargetID)
                    else
                        TriggerEvent("vorp:TipRight", _U("gotoplayerfirst"), 4000)
                    end
                end)
            end

        end,

        function(menu)
            menu.close()
        end)

end

------------------------- TELEPORT  EVENTS FROM SERVER  -------------------------------
RegisterNetEvent("vorp_admin:gotoPlayer", function(targetCoords)

    lastLocation = GetEntityCoords(PlayerPedId())

    SetEntityCoords(PlayerPedId(), targetCoords)
end)

RegisterNetEvent("vorp_admin:sendAdminBack", function()
    if lastLocation then
        SetEntityCoords(PlayerPedId(), lastLocation, 0, 0, 0, false)
        lastLocation = nil
    end
end)

RegisterNetEvent("vorp_admin:Bring", function(adminCoords)
    lastLocation = GetEntityCoords(PlayerPedId())
    SetEntityCoords(PlayerPedId(), adminCoords, false, false, false, false)
end)

RegisterNetEvent("vorp_admin:TeleportPlayerBack", function()
    if lastLocation then
        SetEntityCoords(PlayerPedId(), lastLocation, 0, 0, 0, false)
        lastLocation = nil
    end
end)
-----------------------------------------------------------------------------
