-- Lumberjack Job Client Script

-- Variables
local isCutting = false
local isDelivering = false
local logs = 0
local maxLogs = 10

-- Config
local config = {
    treeModels = {
        'prop_tree_cedar_02a',
        'prop_tree_cedar_03a',
        'prop_tree_cedar_04a'
    },
    logModel = 'prop_logpile_07',
    vehicleModel = 'benson',
    deliveryPoint = vector3(1200.0, -1200.0, 35.0)
}

-- Functions
local function startCutting(tree)
    -- Start cutting animation and minigame
    isCutting = true
    TriggerEvent('lumberjack:startMinigame')
end

local function startDelivery()
    -- Start delivery process
    isDelivering = true
    TriggerEvent('lumberjack:startDelivery')
end

-- Event Handlers
RegisterNetEvent('lumberjack:startMinigame')
AddEventHandler('lumberjack:startMinigame', function()
    -- Minigame logic
end)

RegisterNetEvent('lumberjack:startDelivery')
AddEventHandler('lumberjack:startDelivery', function()
    -- Delivery logic
end)

-- Main Thread
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        
        -- Check for tree interaction
        if not isCutting and not isDelivering then
            local playerPed = PlayerPedId()
            local coords = GetEntityCoords(playerPed)
            
            for _, treeModel in ipairs(config.treeModels) do
                local tree = GetClosestObjectOfType(coords.x, coords.y, coords.z, 3.0, GetHashKey(treeModel), false, false, false)
                
                if tree ~= 0 then
                    DrawText3D(coords.x, coords.y, coords.z, "Press E to cut the tree")
                    
                    if IsControlJustPressed(0, 38) then
                        startCutting(tree)
                    end
                end
            end
        end
    
        -- Check for delivery interaction
        if logs > 0 and not isDelivering then
            local playerPed = PlayerPedId()
            local coords = GetEntityCoords(playerPed)
            
            if #(coords - config.deliveryPoint) < 3.0 then
                DrawText3D(config.deliveryPoint.x, config.deliveryPoint.y, config.deliveryPoint.z, "Press E to deliver logs")
                
                if IsControlJustPressed(0, 38) then
                    startDelivery()
                end
            end
        end
    end
end)

-- Helper Functions
function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
    
    local factor = (string.len(text)) / 370
    DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 41, 11, 41, 68)
end