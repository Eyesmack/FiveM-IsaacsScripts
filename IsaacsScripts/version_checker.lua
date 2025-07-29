--[[ Version Checker ]]--
local resourceName = GetCurrentResourceName()
local localVersion = GetResourceMetadata(resourceName, 'version', 0)

AddEventHandler("onResourceStart", function(resource)
    if resource == resourceName then
        CheckUpToDate()
    end
end)

function CheckUpToDate()
    PerformHttpRequest("https://raw.githubusercontent.com/Eyesmack/FiveM-IsaacsScripts/refs/heads/master/IsaacsScripts/fxmanifest.lua", function(err, text, headers)
        -- Find the version in the fxmanifest.lua file
        local startIndex, endIndex = string.find(text, "\nversion \"")
        -- Find the description in the fxmanifest.lua file
        local descStartIndex, descEndIndex = string.find(text, "\ndescription \"")

        -- Get the version number from the fxmanifest.lua file by using the endIndex of the version string and the startIndex of the description string
        local version = string.sub(text, endIndex + 1, descStartIndex - 2)

        if string.match(version, localVersion) then
            print(" ")
            print("------------------------------------------------")
            PrintLogo()
            print("#Version: ^2" .. localVersion .. "^7")
            print("#Up to date and ready to go!")
            PrintInstalledScripts()
            print("#^5https://github.com/Eyesmack/FiveM-IsaacsScripts^7")
            print("------------------------------------------------")
            print(" ")
        else
            print(" ")
            print("------------------------------------------------")
            PrintLogo()
            print("#Version: ^8" .. localVersion .. "^7")
            print("#Latest Version: ^2" .. version .. "^7")
            print("#^8Out of Date^7, Update for more features!")
            PrintInstalledScripts()
            print("#^5https://github.com/Eyesmack/FiveM-IsaacsScripts^7")
            print("------------------------------------------------")
            print(" ")
        end

    end, "GET", "", {})
end
function PrintLogo()
    print("#   _____                           ")
    print("#  |_   _|                          ")
    print("#    | | ___  __ _  __ _  ___ ___   ")
    print("#    | |/ __|/ _` |/ _` |/ __/ __|  ")
    print("#   _| |\\__ \\ (_| | (_| | (__\\__ \\  ")
    print("#   ________/\\__,_|\\__,_|\\___|___/  ")
    print("#  /  ___|         (_)     | |      ")
    print("#  \\ `--.  ___ _ __ _ _ __ | |_ ___ ")
    print("#   `--. \\/ __| '__| | '_ \\| __/ __|")
    print("#  /\\__/ / (__| |  | | |_) | |_\\__ \\")
    print("#  \\____/ \\___|_|  |_| .__/ \\__|___/")
    print("#                    | |            ")
    print("#                    |_|            ")
end
function PrintInstalledScripts()
    local resourcePath = GetResourcePath(resourceName) -- Gets the absolute path to the resource's root directory
    local myFiles = GetFilesInDirectory(resourcePath .. "/client/")
    local returnString = ""
    for i, fileName in ipairs(myFiles) do
        if string.find(fileName, ".lua") then
            returnString = returnString .. fileName:match("(.+)%..+$") .. " "
        end
    end
    print("#Installed Scripts: ^3" .. returnString .. "^7")
end
function GetFilesInDirectory(directoryPath)
    local files = {}
    local command

    command = "dir \"" .. directoryPath .. "\" /b /a-d" -- /b for bare format, /a-d to exclude directories

    local handle = io.popen(command)
    if handle then
        for line in handle:lines() do
            table.insert(files, line)
        end
        handle:close()
    else
        print("Error: Could not execute command to list files in " .. directoryPath)
    end
    return files
end