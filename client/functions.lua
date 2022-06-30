---------------------------------------------------------------------------------------------------
--------------------------------------- FUNCTIONS -------------------------------------------------

--close menu

function Closem()
    MenuData.CloseAll()
    if Inmenu then
        Inmenu = false
    end
end

function GetPlayers()
    TriggerServerEvent("vorp_admin:GetPlayers")
    local playersData = {}
    RegisterNetEvent("vorp_admin:SendPlayers", function(result)
        playersData = result
    end)
    while next(playersData) == nil do
        Wait(10)
    end
    return playersData
end

---------------------------------------------------------------------------------------------------------------
----------------------------------- MAIN MENU -----------------------------------------------------------------
function OpenMenu()
    MenuData.CloseAll()
    local elements = {
        { label = _U("Administration"), value = 'administration', desc = _U("administration_desc") },
        { label = _U("Booster"), value = 'boost', desc = _U("booster_desc") },
        { label = _U("Database"), value = 'database', desc = _U("database_desc") },
        { label = _U("Teleport"), value = 'teleport', desc = _U("teleport_desc") },
        { label = _U("devtools"), value = 'devtools', desc = _U("devtools_desc") },
    }
    MenuData.Open('default', GetCurrentResourceName(), 'menuapi',
        {
            title    = _U("MenuTitle"),
            subtext  = _U("MenuSubTitle"),
            align    = 'top-left',
            elements = elements,
        },
        function(data, menu)
            if data.current == "backup" then
                _G[data.trigger]()
            end

            if data.current.value == "administration" then
                Admin()

            elseif data.current.value == "boost" then
                Boost()

            elseif data.current.value == "database" then
                DataBase()

            elseif data.current.value == "teleport" then
                Teleport()
            elseif data.current.value == "devtools" then
                OpenDevTools()
            end
        end,

        function(data, menu)
            menu.close()
        end)
end

-- FUNCTIONS
-- CREDITS to the author for the clipboard
function Round(input, decimalPlaces)
    return tonumber(string.format("%." .. (decimalPlaces or 0) .. "f", input))
end

function CopyToClipboard(dataType)
    local ped = PlayerPedId()
    if dataType == 'v2' then
        local coords = GetEntityCoords(ped)
        local x = Round(coords.x, 2)
        local y = Round(coords.y, 2)
        local z = Round(coords.z, 2)

        SendNUIMessage({
            string = string.format('{x = %s, y = %s, z = %s}', x, y, z)
        })
        TriggerEvent('vorp:TipRight', _U("copied"), 3000)
    elseif dataType == 'v3' then
        local coords = GetEntityCoords(ped)
        local x = Round(coords.x, 2)
        local y = Round(coords.y, 2)
        local z = Round(coords.z, 2)
        SendNUIMessage({
            string = string.format('vector3(%s, %s, %s)', x, y, z)
        })
        TriggerEvent('vorp:TipRight', _U("copied"), 3000)
    elseif dataType == 'v4' then
        local coords = GetEntityCoords(ped)
        local x = Round(coords.x, 2)
        local y = Round(coords.y, 2)
        local z = Round(coords.z, 2)
        local heading = GetEntityHeading(ped)
        local h = Round(heading, 2)
        SendNUIMessage({
            string = string.format('vector4(%s, %s, %s, %s)', x, y, z, h)
        })
        TriggerEvent('vorp:TipRight', _U("copied"), 3000)
    elseif dataType == 'heading' then
        local heading = GetEntityHeading(ped)
        local h = Round(heading, 2)
        SendNUIMessage({
            string = h
        })
        TriggerEvent('vorp:TipRight', _U("copied"), 3000)

    end
end

-- GET CLOSESTOBJECT
function GetClosestObject(coords)
    local ped = PlayerPedId()
    local objects = GetGamePool('CObject')
    local closestDistance = -1
    local closestObject = -1
    if coords then
    else
        coords = GetEntityCoords(ped)
    end
    for i = 1, #objects, 1 do
        local objectCoords = GetEntityCoords(objects[i])
        local distance = #(objectCoords - coords)
        if closestDistance == -1 or closestDistance > distance then
            closestObject = objects[i]
            closestDistance = distance
        end
    end
    return closestObject, closestDistance
end
