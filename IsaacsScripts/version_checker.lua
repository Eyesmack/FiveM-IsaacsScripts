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

        -- print("^1Red")
        -- print("^2Green")
        -- print("^3Yellow")
        -- print("^4Blue")
        -- print("^5Light Blue")
        -- print("^6Purple")
        -- print("^7White")
        -- print("^8Blood Red")
        -- print("^9Patriotic Blue^7")

        if localVersion == version then
            -- Versions match exactly
            if string.find(localVersion, '-') ~= nil then
                -- Using an alpha build
                print(" ")
                print("------------------------------------------------")
                PrintLogo("^3")
                print("#Version: ^2" .. localVersion .. " [" .. CalcBuildNum(localVersion) .. "]^7")
                print("#^3Using an alpha build! May cause issues or have^7")
                print("#^3buggy code that may cause server instability^7")
                PrintInstalledScripts()
                print("#^5https://github.com/Eyesmack/FiveM-IsaacsScripts^7")
                print("------------------------------------------------")
                print(" ")
            else
                -- Not using an alpha build
                print(" ")
                print("------------------------------------------------")
                PrintLogo("^2")
                print("#Version: ^2" .. localVersion .. " [" .. CalcBuildNum(localVersion) .. "]^7")
                print("#Up to date and ready to go!")
                PrintInstalledScripts()
                print("#^5https://github.com/Eyesmack/FiveM-IsaacsScripts^7")
                print("------------------------------------------------")
                print(" ")
            end
        elseif CalcBuildNum(localVersion) == CalcBuildNum(version) then
            -- Using a build that matches the latest build on github
            if string.find(localVersion, '-') ~= nil then
                -- Using an alpha build
                print(" ")
                print("------------------------------------------------")
                PrintLogo("^3")
                print("#Version: ^2" .. localVersion .. " [" .. CalcBuildNum(localVersion) .. "]^7")
                print("#^3Using an alpha build! May cause issues or have^7")
                print("#^3buggy code that may cause server instability^7")
                PrintInstalledScripts()
                print("#^5https://github.com/Eyesmack/FiveM-IsaacsScripts^7")
                print("------------------------------------------------")
                print(" ")
            else
                -- Not using an alpha build
                print(" ")
                print("------------------------------------------------")
                PrintLogo("^2")
                print("#Version: ^2" .. localVersion .. " [" .. CalcBuildNum(localVersion) .. "]^7")
                print("#Up to date and ready to go!")
                PrintInstalledScripts()
                print("#^5https://github.com/Eyesmack/FiveM-IsaacsScripts^7")
                print("------------------------------------------------")
                print(" ")
            end
        elseif CalcBuildNum(localVersion) > CalcBuildNum(version) then
            -- Using a build that is higher than the latest on github
            print(" ")
            print("------------------------------------------------")
            PrintLogo("^3")
            print("#Your Version: ^8" .. localVersion .. " [" .. CalcBuildNum(localVersion) .. "]^7")
            print("#Latest Version on Github: ^2" .. version .. " [" .. CalcBuildNum(version) .. "]^7")
            print("#^8Out of Date, BUT SOMEHOW IN THE FUTURE???!?!^7")
            print("#^3Your local build is somehow later than the^7")
            print("#^3publicly available one on github?^7")
            print("#^9Are you playin around with the manifest file?^7")
            PrintInstalledScripts()
            print("#^5https://github.com/Eyesmack/FiveM-IsaacsScripts^7")
            print("------------------------------------------------")
            print(" ")
        else
            -- Everything else
            print(" ")
            print("------------------------------------------------")
            PrintLogo("^8")
            print("#Version: ^8" .. localVersion .. " [" .. CalcBuildNum(localVersion) .. "]^7")
            print("#Latest Version: ^2" .. version .. " [" .. CalcBuildNum(version) .. "]^7")
            print("#^8Out of Date^7, Update for more features!")
            PrintInstalledScripts()
            print("#^5https://github.com/Eyesmack/FiveM-IsaacsScripts^7")
            print("------------------------------------------------")
            print(" ")
        end
    end, "GET", "", {})
end
function PrintLogo(colour)
    if colour == nil or colour == '' then
        colour = "^7"
    end
    print("#"..colour.."   _____                           ^7")
    print("#"..colour.."  |_   _|                          ^7")
    print("#"..colour.."    | | ___  __ _  __ _  ___ ___   ^7")
    print("#"..colour.."    | |/ __|/ _` |/ _` |/ __/ __|  ^7")
    print("#"..colour.."   _| |\\__ \\ (_| | (_| | (__\\__ \\  ^7")
    print("#"..colour.."   ________/\\__,_|\\__,_|\\___|___/  ^7")
    print("#"..colour.."  /  ___|         (_)     | |      ^7")
    print("#"..colour.."  \\ `--.  ___ _ __ _ _ __ | |_ ___ ^7")
    print("#"..colour.."   `--. \\/ __| '__| | '_ \\| __/ __|^7")
    print("#"..colour.."  /\\__/ / (__| |  | | |_) | |_\\__ \\^7")
    print("#"..colour.."  \\____/ \\___|_|  |_| .__/ \\__|___/^7")
    print("#"..colour.."                    | |            ^7")
    print("#"..colour.."                    |_|            ^7")
end
function PrintInstalledScripts()
    local resourcePath = GetResourcePath(resourceName) -- Gets the absolute path to the resource's root directory
    local myFiles = GetFilesInDirectory(resourcePath .. "/client/")
    local returnString = ""
    for i, fileName in ipairs(myFiles) do
        if string.find(fileName, ".lua") then
            returnString = returnString .. "\n^7#^3" .. fileName:match("(.+)%..+$") .. ""
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
function CalcBuildNum(version)
    if version == nil or version == '' then return end
    
    -- print(semantics[1])
    -- print(semantics[2])
    -- print(semantics[3])
    local semantics = {}
    local a = {}
    local b = {}
    local c = {}
    local overall = 0
    local major = 0
    local majorMul = 100000
    local minor = 0
    local minorMul = 1000
    local patch = 0
    for word in string.gmatch(version, '[^.]+') do
        table.insert(semantics, word)
    end

    --print("Version: [" .. table.concat(semantics, '.') .. "]")

    if string.find(semantics[1], '-') ~= nil then
        for word in string.gmatch(semantics[1], '([^-]+)') do
            table.insert(a, word)
        end
        --print("Major: " .. table.concat(a, " "))
        major = tonumber(a[1]) * majorMul
    else
        major = tonumber(semantics[1]) * majorMul
    end
    if string.find(semantics[2], '-') ~= nil then
        for word in string.gmatch(semantics[2], '([^-]+)') do
            table.insert(b, word)
        end
        --print("Minor: " .. table.concat(b, " "))
        minor = tonumber(b[1]) * minorMul
    else
        minor = tonumber(semantics[2]) * minorMul
    end
    if string.find(semantics[3], '-') ~= nil then
        for word in string.gmatch(semantics[3], '([^-]+)') do
            table.insert(c, word)
        end
        --print("Patch: " .. table.concat(c, " "))
        patch = tonumber(c[1]) * 1
    else
        patch = semantics[3]
    end

    overall = major + minor + patch

    return overall
end