-- Load Orion Library
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Main Window
local Window = Rayfield:MakeWindow({
    Name = "Reality-Hub V1",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "Reality-HubConfig"
})

-- Variables
local jobID = ""

-- Tab: Join Server
local ServerTab = Window:MakeTab({
    Name = "Join Server",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Input Job ID
ServerTab:AddTextbox({
    Name = "Input Job ID",
    Default = "",
    TextDisappear = true,
    Callback = function(value)
        jobID = value:gsub("`", "") -- Hapus karakter backtick
        Rayfield:MakeNotification({
            Name = "Job ID Set",
            Content = jobID ~= "" and "Job ID berhasil disimpan!" or "Job ID tidak boleh kosong!",
            Image = "rbxassetid://4483345998",
            Time = 5
        })
    end
})

-- Join Server
ServerTab:AddButton({
    Name = "Join Server",
    Callback = function()
        if jobID == "" then
            Rayfield:MakeNotification({
                Name = "Error",
                Content = "Masukkan Job ID terlebih dahulu!",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
            return
        end

        local success, err = pcall(function()
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, jobID, game.Players.LocalPlayer)
        end)

        if success then
            Rayfield:MakeNotification({
                Name = "Success",
                Content = "Berhasil bergabung ke server!",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
        else
            Rayfield:MakeNotification({
                Name = "Error",
                Content = "Gagal bergabung ke server! Periksa Job ID.",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
        end
    end
})

-- Clear Job ID
ServerTab:AddButton({
    Name = "Clear Job ID",
    Callback = function()
        jobID = ""
        Rayfield:MakeNotification({
            Name = "Cleared",
            Content = "Job ID telah dihapus!",
            Image = "rbxassetid://4483345998",
            Time = 5
        })
    end
})

-- Initialize Orion
OrionLib:Init()

-- Welcome Message Override
local notificationFrame = game:GetService("CoreGui"):FindFirstChild("Rayfield"):FindFirstChild("Notifications")
if notificationFrame then
    for _, child in pairs(notificationFrame:GetChildren()) do
        if child.Name == "Welcome" then
            child.Message.Text = "Reality-Hub V1 - Welcome!"
        end
    end
end
