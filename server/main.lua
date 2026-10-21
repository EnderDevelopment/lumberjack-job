-- Lumberjack Job Server Script

-- Variables
local logs = {}

-- Config
local config = {
    paymentPerLog = 50
}

-- Event Handlers
RegisterNetEvent('lumberjack:deliverLogs')
AddEventHandler('lumberjack:deliverLogs', function(logCount)
    local playerId = source
    local xPlayer = ESX.GetPlayerFromId(playerId)
    
    if xPlayer then
        local payment = logCount * config.paymentPerLog
        xPlayer.addMoney(payment)
        TriggerClientEvent('esx:showNotification', playerId, "You delivered " .. logCount .. " logs and earned $" .. payment)
    end
end)

-- Functions
function getLogs(playerId)
    if not logs[playerId] then
        logs[playerId] = 0
    end
    
    return logs[playerId]
end

function setLogs(playerId, count)
    logs[playerId] = count
end