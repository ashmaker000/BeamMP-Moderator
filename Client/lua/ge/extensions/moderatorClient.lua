local M = {}

local filterName = "moderator_reset_lock"
local resetLockedUntil = 0
local resetLockActive = false

local resetActions = {
  "recover_vehicle",
  "recover_vehicle_alt",
  "recover_to_last_road",
  "reset_physics",
  "reset_all_physics",
  "reload_vehicle",
  "reload_all_vehicles",
  "loadHome",
  "saveHome",
  "dropPlayerAtCamera",
  "dropPlayerAtCameraNoReset",
}

local function now()
  return os.time()
end

local function decodeJson(raw)
  if jsonDecode then
    local ok, decoded = pcall(jsonDecode, raw)
    if ok then return decoded end
  end
  if json and json.decode then
    local ok, decoded = pcall(json.decode, raw)
    if ok then return decoded end
  end
  return nil
end

local function setResetLock(state)
  if not core_input_actionFilter then return end
  if resetLockActive == state then return end
  core_input_actionFilter.setGroup(filterName, resetActions)
  core_input_actionFilter.addAction(0, filterName, state and true or false)
  resetLockActive = state and true or false
end

local function enforce()
  local shouldLock = resetLockedUntil > now()
  setResetLock(shouldLock)
end

function M.moderator_setState(raw)
  local data = decodeJson(raw)
  if type(data) ~= "table" then return end
  resetLockedUntil = tonumber(data.resetLockedUntil or 0) or 0
  enforce()
  if resetLockedUntil > now() and guihooks and guihooks.message then
    guihooks.message({ txt = "Moderator: reset actions temporarily locked.", ttl = 4 }, 4, "moderator.resetlock")
  end
end

function M.onUpdate(dtReal, dtSim, dtRaw)
  enforce()
end

function M.onExtensionUnloaded()
  setResetLock(false)
end

if AddEventHandler then
  AddEventHandler("moderator_setState", function(raw)
    M.moderator_setState(raw)
  end)
end

return M
