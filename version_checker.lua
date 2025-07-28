--[[ Version Checker ]]--
local resourceName = GetCurrentResourceName()
local localVersion = GetResourceMetadata(resourceName, 'version', 0)

AddEventHandler("onResourceStart", function(resource)
    if resource == resourceName then
        CheckUpToDate()
    end
end)

function CheckUpToDate()
    PerformHttpRequest("https://raw.githubusercontent.com/Eyesmack/FiveM-IsaacsScripts/refs/heads/master/fxmanifest.lua", function(err, text, headers)
        local startIndex, endIndex = string.find(text, "\nversion \"")
        local version = string.sub(text, endIndex + 1, endIndex + 5)

        if string.match(version, localVersion) then
            PrintSpace()
            print("------------------------------------------------")
            PrintLogo()
            print("#Version: ^2" .. localVersion .. "^7")
            print("#Up to date and ready to go!")
            print("#^5https://github.com/Eyesmack/FiveM-IsaacsScripts^7")
            print("------------------------------------------------")
            PrintSpace()
        else
            PrintSpace()
            print("------------------------------------------------")
            PrintLogo()
            print("#Version: ^8" .. localVersion .. "^7")
            print("#Latest Version: ^2" .. version .. "^7")
            print("#^8Out of Date^7, Update for more features!")
            print("#^5https://github.com/Eyesmack/FiveM-IsaacsScripts^7")
            print("------------------------------------------------")
            PrintSpace()
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
function PrintSpace()
    print(" ")
    print(" ")
    print(" ")
    print(" ")
end
