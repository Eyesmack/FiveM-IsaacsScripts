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
            PrintSpace()
            print("------------------------------------------------")
            PrintLogo()
            print("                   Version: ^2" .. version)
            print("^rIsaacsScripts is up to date and ready to go!")
            print("https://github.com/Eyesmack/FiveM-IsaacsScripts")
            print("------------------------------------------------")
            PrintSpace()
        else
            PrintSpace()
            print("------------------------------------------------")
            PrintLogo()
            print("                   Version: ^8" .. version)
            print("^r            Latest Version: ^2" .. text)
            print("^8IsaacsScripts is outdated. Update for more features!^r")
            print("https://github.com/Eyesmack/FiveM-IsaacsScripts")
            print("------------------------------------------------")
            PrintSpace()
        end

    end, "GET", "", {})
end
function PrintLogo()
    print(".___                                          ")
    print("|   | __________  _____    ____   ______      ")
    print("|   |/  ___|__  \\ \\__  \\ _/ ___\\ /  ___/      ")
    print("|   |\\___ \\ / __ \\_/ __ \\  \\___ \\___ \\       ")
    print("|___/____  >____  (____  /\\___  >____  >      ")
    print("  _________     \\/     .__    \\/  __ \\/       ")
    print(" /   _____/ ___________|__|______/  |_  ______")
    print(" \\_____  \\_/ ___\\_  __ \\  \\____ \\   __\\/  ___/")
    print(" /        \\  \\___|  | \\/  |  |_> >  |  \\___ \\ ")
    print("/_______  /\\___  >__|  |__|   __/|__| /____  >")
    print("        \\/     \\/         |__|             \\/ ")
end
function PrintSpace()
    print(" ")
    print(" ")
    print(" ")
    print(" ")
end
