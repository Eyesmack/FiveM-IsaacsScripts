--[[ Version Checker ]]--
local resourceName = GetCurrentResourceName()
local version = GetResourceMetadata(resourceName, 'version', 0)

AddEventHandler("onResourceStart", function(resource)
    if resource == resourceName then
        CheckUpToDate()
    end
end)

function CheckUpToDate()
    PerformHttpRequest("https://raw.githubusercontent.com/Eyesmack/FiveM-IsaacsScripts/refs/heads/master/version.txt", function(err, text, headers)
        if string.match(text, version) then
            print(" ")
            print(" ")
            print(" ")
            print(" ")
            print("------------ ISAACS SCRIPTS VERSION ------------")
            print("                   Version: " .. version)
            print("IsaacsScripts is up to date and ready to go!")
            print("https://github.com/Eyesmack/FiveM-IsaacsScripts")
            print("------------------------------------------------")
            print(" ")
            print(" ")
            print(" ")
            print(" ")
        else
            print(" ")
            print(" ")
            print(" ")
            print(" ")
            print("------------ ISAACS SCRIPTS VERSION ------------")
            print("                   Version: " .. version)
            print("            Latest Version: " .. text)
            print("IsaacsScripts is outdated. Update for more features!")
            print("https://github.com/Eyesmack/FiveM-IsaacsScripts")
            print("------------------------------------------------")
            print(" ")
            print(" ")
            print(" ")
            print(" ")
        end

    end, "GET", "", {})
end
