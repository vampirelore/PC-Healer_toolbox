# Load necessary .NET assemblies for building a Windows Forms GUI
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
# Load necessary .NET assemblies
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Force-load Forms types into memory
[void][System.Windows.Forms.Form]
[void][System.Windows.Forms.MessageBox]

# Admin check
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
    [Security.Principal.WindowsBuiltInRole]::Administrator)) {
    [System.Windows.Forms.MessageBox]::Show("This tool must be run as Administrator for all features to work.", "Permission Required", "OK", "Error")
    exit
}

# PC Healer Toolbox - Created by Vampirelore
# Licensed under GNU GPL v3
# This script is open-source. You are free to use, share, and improve it,
# as long as any modifications remain .bat and stay open sourced also give credit to the original author.
#Generated for public release: Year | {2025} Month | {April}



# Coordinate Reference Guide for UI Layout
# Y ▼     X →   0     50    100   100   200   250   300   350   400   450   500
#        +---------------------------------------------------------------------+
#  0     |     |     |     |     |     |     |     |     |     |     |     |
#  50    |     |     |     |     |     |     |     |     |     |     |     |
#  100   |     |     |     |     |     |     |     |     |     |     |     |
#  100   |     |     |     |     |     |     |     |     |     |     |     |
#  200   |     |     |     |     |     |     |     |     |     |     |     |
#  250   |     |     |     |     |     |     |     |     |     |     |     |
#  300   |     |     |     |     |     |     |     |     |     |     |     |
#  350   |     |     |     |     |     |     |     |     |     |     |     |
#  400   |     |     |     |     |     |     |     |     |     |     |     |
#  450   |     |     |     |     |     |     |     |     |     |     |     |
#  500   |     |     |     |     |     |     |     |     |     |     |     |
#        +---------------------------------------------------------------------+

$tooltip = New-Object System.Windows.Forms.ToolTip
$tooltip.AutoPopDelay = 5000


# Watermark validation block with multiple accepted variants
$authorVariants = @(
    'vampirelore',
    'VampireLore',
    'vampire' + 'lore',
    'vampire-lore',
    'vam' + 'pirelore',
    "Vampire"+"Lore",
    'vamp' + 'ire' + 'lore'
)

$matchCount = 0

try {
    if ($MyInvocation.MyCommand.Path) {
        $scriptContent = Get-Content -Raw $MyInvocation.MyCommand.Path
    } else {
        $scriptContent = $MyInvocation.Line
    }

    foreach ($variant in $authorVariants) {
        $regex = [regex]::Escape($variant)
        $matchCount += ([regex]::Matches($scriptContent, $regex)).Count
    }
} catch {
    $matchCount = 0
}

if ($matchCount -lt 3) {
    Write-Host "Unauthorized modification detected. Author watermark not found enough times." -ForegroundColor Red
    exit
}


# Create main form
$form = New-Object System.Windows.Forms.Form
$form.Text = "PC Healer Toolbox - Tools by Vampire"+"Lore"
$form.Size = New-Object System.Drawing.Size(820, 800)
$form.MinimumSize = New-Object System.Drawing.Size(700, 600)  # Allow smaller screen support
$form.StartPosition = "CenterScreen"
$form.WindowState = "Maximized"
$form.BackColor = 'LightSteelBlue'

# Create a scrollable main panel
$mainPanel = New-Object System.Windows.Forms.Panel
$mainPanel.Dock = "Fill"
$mainPanel.AutoScroll = $true
$form.Controls.Add($mainPanel)

# Create TabControl
$tabs = New-Object System.Windows.Forms.TabControl
$tabs.Dock = "Fill"
$mainPanel.Controls.Add($tabs)

#$form.Controls.Add($tabs)

# Create WiFi Tab
$tabWiFi = New-Object System.Windows.Forms.TabPage
$tabWiFi.Text = "WiFi Tools"
$tabWiFi.BackColor = '#aaaaaa'
$tabs.TabPages.Add($tabWiFi)

# Sidebar Panel for buttons (LEFT side)
$sidebarPanel = New-Object System.Windows.Forms.Panel
$sidebarPanel.Size = New-Object System.Drawing.Size(170, 700)
$sidebarPanel.Location = New-Object System.Drawing.Point(10, 10)
$sidebarPanel.Anchor = "Top,Bottom,Left"
$sidebarPanel.BackColor = '#aaaaaa'
$sidebarPanel.AutoScroll = $true
$tabWiFi.Controls.Add($sidebarPanel)


# Create the watermark button first
$lblWatermarkwifi = New-Object System.Windows.Forms.Button
$lblWatermarkwifi.Text = "vampirelore"
$lblWatermarkwifi.Location = '10,700'
$lblWatermarkwifi.Size = '1,2'
$lblWatermarkwifi.FlatStyle = 'Flat'
$lblWatermarkwifi.BackColor = 'LightGray'
$lblWatermarkwifi.ForeColor = 'DarkGray'
$lblWatermarkwifi.Font = New-Object System.Drawing.Font("Arial", 8, [System.Drawing.FontStyle]::Bold)
$sidebarPanel.Controls.Add($lblWatermarkwifi)

# Then apply tooltip to the already-created object
#$tooltip.SetToolTip($lblWatermarkwifi, "Click me to learn more about PC Healer and vampirelore.")

# Watermark Button
$btnWatermark = New-Object System.Windows.Forms.Button
$btnWatermark.Text = "Created by vampire"+"lore"
$btnWatermark.Size = '120,50'
$btnWatermark.Location = '10,700'
$btnWatermark.FlatStyle = 'Flat'
$btnWatermark.ForeColor = 'Gray'
$btnWatermark.Font = New-Object System.Drawing.Font("Arial", 8, [System.Drawing.FontStyle]::Italic)
$sidebarPanel.Controls.Add($btnWatermark)

# Tooltip: Invite click
$tooltip.SetToolTip($lblWatermarkwifi, "Click me to learn more about the creator.")

# On click: Show popup with message
$btnWatermark.Add_Click({
    [System.Windows.Forms.MessageBox]::Show(
        "This project has been in the works for years, evolving from batch files to a full GUI. You're using Version 3.0 of the tool created by VampireLore. Thank you for trying it out!",
        "About This Tool",
        [System.Windows.Forms.MessageBoxButtons]::OK,
        [System.Windows.Forms.MessageBoxIcon]::Information
    )
})


# Add hidden tooltip watermark to Utilities tab
$lblWatermarkTip = New-Object System.Windows.Forms.Label
$lblWatermarkTip.Text = " "
$lblWatermarkTip.Size = '10,10'
$lblWatermarkTip.Location = '1,1'
$tabWiFi.Controls.Add($lblWatermarkTip)

# Output TextBox in WiFi Tab
$outputBox = New-Object System.Windows.Forms.TextBox
$outputBox.Multiline = $true
$outputBox.ScrollBars = "Both"
$outputBox.ReadOnly = $true
$outputBox.Font = New-Object System.Drawing.Font("Consolas", 10)
$outputBox.BackColor = 'Black'
$outputBox.ForeColor = 'Lime'
$outputBox.Size = '570,650'
$outputBox.Location = '190,30'
#$outputBox.Anchor = "Top,Bottom,Left,Right"
$tabWiFi.Controls.Add($outputBox)



# Show Profiles Button
$btnShow = New-Object System.Windows.Forms.Button
$btnShow.Text = "Show Profiles"
$btnShow.Size = '160,40'
$btnShow.Location = '10,50'
$btnShow.Add_Click({
    $output = netsh wlan show profile
    $outputBox.Text = $output -join "`r`n"
})
$sidebarPanel.Controls.Add($btnShow)

$tooltip.SetToolTip($btnShow, "Displays all Previously connected WiFi profiles.")


# Label for Input
$lblInput = New-Object System.Windows.Forms.Label
$lblInput.Text = "Profile Name:"
$lblInput.Location = '10,100'
$lblInput.Size = '160,20'
$sidebarPanel.Controls.Add($lblInput)

# Input TextBox
$txtProfile = New-Object System.Windows.Forms.TextBox
$txtProfile.Location = '10,120'
$txtProfile.Size = '160,25'
$sidebarPanel.Controls.Add($txtProfile)

# Export Profile Button
$btnExport = New-Object System.Windows.Forms.Button
$btnExport.Text = "Export Profile"
$btnExport.Size = '160,40'
$btnExport.Location = '10,160'
$btnExport.Add_Click({
    $profileName = $txtProfile.Text
    if ($profileName -ne "") {
        $folder = "$env:USERPROFILE\Documents\PCHealerProfiles"
        if (!(Test-Path $folder)) {
            New-Item -ItemType Directory -Path $folder | Out-Null
        }

        $cmd = 'netsh wlan export profile name="' + $profileName + '" folder="' + $folder + '" key=clear'
        Start-Process -FilePath "cmd.exe" -ArgumentList "/c $cmd" -NoNewWindow -Wait

        $xmlPath = Get-ChildItem "$folder\*-$profileName.xml" -ErrorAction SilentlyContinue | Select-Object -First 1
        if ($xmlPath) {
            $content = Get-Content $xmlPath.FullName
            $outputBox.Text = $content -join "`r`n"
        } else {
            $outputBox.Text = "Export completed, but XML file was not found."
        }
    } else {
        [System.Windows.Forms.MessageBox]::Show("Please enter a profile name.", "Missing Info")
    }
})
$sidebarPanel.Controls.Add($btnExport)

$tooltip.SetToolTip($btnExport, "Pulls the selected WiFi profile information + Password or called SSID to XML format.")

# Change DNS Button
$btnChangeDNS = New-Object System.Windows.Forms.Button
$btnChangeDNS.Text = "Change DNS"
$btnChangeDNS.Size = "160,40"
$btnChangeDNS.Location = '10,230'
#$btnChangeDNS.FlatStyle = "Flat"
$sidebarPanel.Controls.Add($btnChangeDNS)
$btnChangeDNS.Add_Click({
    $outputBox.Clear()

    $dnsForm = New-Object System.Windows.Forms.Form
    $dnsForm.Text = "Change DNS"
    $dnsForm.Size = New-Object System.Drawing.Size(350,200)
    $dnsForm.StartPosition = "CenterParent"

    $dnsLabel = New-Object System.Windows.Forms.Label
    $dnsLabel.Text = "Enter Preferred DNS:"
    $dnsLabel.Location = '10,20'
    $dnsLabel.Size = '300,20'
    $dnsForm.Controls.Add($dnsLabel)

    $dnsInputBox = New-Object System.Windows.Forms.TextBox
    $dnsInputBox.Location = '10,45'
    $dnsInputBox.Size = '200,20'
    $dnsInputBox.Text = "8.8.8.8"
    $dnsForm.Controls.Add($dnsInputBox)

    $dnsPreview = New-Object System.Windows.Forms.Label
    $dnsPreview.Location = '10,75'
    $dnsPreview.Size = '300,20'
    $dnsPreview.Text = "New DNS will be: 8.8.8.8"
    $dnsForm.Controls.Add($dnsPreview)

    $dnsInputBox.Add_TextChanged({
        $dnsPreview.Text = "New DNS will be: " + $dnsInputBox.Text
    })

    $applyDNSButton = New-Object System.Windows.Forms.Button
    $applyDNSButton.Location = '10,105'
    $applyDNSButton.Size = '100,30'
    $applyDNSButton.Text = "Apply DNS"
    $applyDNSButton.Add_Click({
        $adapter = "Ethernet"
        $dns = $dnsInputBox.Text
        $command = 'netsh interface ip set dns name="' + $adapter + '" static ' + $dns
        $outputBox.AppendText("Running command: $command`r`n")
        Invoke-Expression $command
        $outputBox.AppendText("DNS changed to $dns`r`n")
        $dnsForm.Close()
    })
    $dnsForm.Controls.Add($applyDNSButton)

    $dnsForm.ShowDialog()
})
$tooltip.SetToolTip($btnChangeDNS, "Change the DNS settings for your network adapter.| DNS Domain Name System turns website names like google.com into IP addresses.")

# Change IP Button (with Auto-Gateway Detection)
$btnChangeIP = New-Object System.Windows.Forms.Button
$btnChangeIP.Text = "Change IP"
$btnChangeIP.Size = '160,40'
$btnChangeIP.Location = '10,280'
#$btnChangeIP.FlatStyle = "Flat"
$sidebarPanel.Controls.Add($btnChangeIP)

$btnChangeIP.Add_Click({
    # Try to auto-detect gateway from IPv4 routes
    $gateway = (Get-NetRoute -DestinationPrefix "0.0.0.0/0" |
                Where-Object { $_.NextHop -ne "0.0.0.0" -and $_.NextHop -ne "::" } |
                Select-Object -ExpandProperty NextHop -First 1)

    if (-not $gateway) {
        $gateway = "192.168.1.1"  # Fallback
    }

    $subnet = "255.255.255.0"

    $ipForm = New-Object System.Windows.Forms.Form
    $ipForm.Text = "Manual IP Configuration"
    $ipForm.Size = New-Object System.Drawing.Size(350, 250)
    $ipForm.StartPosition = "CenterParent"

    # IP Address Label/Input
    $lblIP = New-Object System.Windows.Forms.Label
    $lblIP.Text = "IP Address:"
    $lblIP.Location = '10,20'
    $lblIP.Size = '100,20'
    $ipForm.Controls.Add($lblIP)

    $txtIP = New-Object System.Windows.Forms.TextBox
    $txtIP.Location = '120,20'
    $txtIP.Size = '200,20'
    $txtIP.Text = "192.168.1.100"
    $ipForm.Controls.Add($txtIP)

    # Subnet
    $lblSubnet = New-Object System.Windows.Forms.Label
    $lblSubnet.Text = "Subnet Mask:"
    $lblSubnet.Location = '10,60'
    $lblSubnet.Size = '100,20'
    $ipForm.Controls.Add($lblSubnet)

    $txtSubnet = New-Object System.Windows.Forms.TextBox
    $txtSubnet.Location = '120,60'
    $txtSubnet.Size = '200,20'
    $txtSubnet.Text = $subnet
    $ipForm.Controls.Add($txtSubnet)

    # Gateway
    $lblGateway = New-Object System.Windows.Forms.Label
    $lblGateway.Text = "Gateway:"
    $lblGateway.Location = '10,100'
    $lblGateway.Size = '100,20'
    $ipForm.Controls.Add($lblGateway)

    $txtGateway = New-Object System.Windows.Forms.TextBox
    $txtGateway.Location = '120,100'
    $txtGateway.Size = '200,20'
    $txtGateway.Text = $gateway
    $ipForm.Controls.Add($txtGateway)

    # Apply Button
    $btnApply = New-Object System.Windows.Forms.Button
    $btnApply.Text = "Apply"
    $btnApply.Size = '80,30'
    $btnApply.Location = '120,140'
    $btnApply.Add_Click({
        $ip = $txtIP.Text
        $subnet = $txtSubnet.Text
        $gw = $txtGateway.Text
        $adapter = "Ethernet"

        if ($ip -and $subnet -and $gw) {
            $cmd = "netsh interface ip set address name=`"$adapter`" static $ip $subnet $gw"
            Invoke-Expression $cmd
            $outputBox.AppendText("IP set to: $ip`r`nGateway: $gw`r`n")
            $ipForm.Close()
        } else {
            [System.Windows.Forms.MessageBox]::Show("Please fill out all fields.", "Missing Info")
        }
    })
    $ipForm.Controls.Add($btnApply)

    $ipForm.ShowDialog()
})
$tooltip.SetToolTip($btnChangeIP, "Change the IP settings for your network adapter.")

# Random IP Button
$btnRandomIP = New-Object System.Windows.Forms.Button
$btnRandomIP.Text = "Randomize IP"
$btnRandomIP.Size = '160,40'
$btnRandomIP.Location = '10,330'
$btnRandomIP.Add_Click({
    $msg = "This will generate a random static IP address on your local network (192.168.x.x).`r`nEnsure it does not conflict with another device. Continue?"
    if ([System.Windows.Forms.MessageBox]::Show($msg, "Random IP", "YesNo", "Warning") -eq "Yes") {
        $rand = New-Object System.Random
        $ip = "192.168." + $rand.Next(1,255) + "." + $rand.Next(2,254)
        $subnet = "255.255.255.0"
        $gateway = "192.168." + $rand.Next(1,255) + ".1"
        $adapter = "Ethernet"  # Change this if needed
        $command = 'netsh interface ip set address name="' + $adapter + '" static ' + $ip + ' ' + $subnet + ' ' + $gateway
        Invoke-Expression $command
        $outputBox.AppendText("Random IP applied: $ip`r`nGateway: $gateway`r`n")
    } else {
        $outputBox.AppendText("Random IP assignment canceled.`r`n")
    }
})
$sidebarPanel.Controls.Add($btnRandomIP)

$tooltip.SetToolTip($btnRandomIP, "Randomizes the IP address on your local network.")

# Revert to DHCP Button
$btnDHCP = New-Object System.Windows.Forms.Button
$btnDHCP.Text = "Revert to DHCP"
$btnDHCP.Size = '160,40'
$btnDHCP.Location = '10,380'
$btnDHCP.Add_Click({
    $msg = "This will revert your IP settings back to automatic DHCP assignment. Proceed?"
    if ([System.Windows.Forms.MessageBox]::Show($msg, "DHCP Mode", "YesNo", "Question") -eq "Yes") {
        $adapter = "Ethernet"
        Invoke-Expression "netsh interface ip set address name=\"$adapter\" source=dhcp"
        Invoke-Expression "netsh interface ip set dns name=\"$adapter\" source=dhcp"
        $outputBox.AppendText("Network settings reverted to DHCP.`r`n")
    } else {
        $outputBox.AppendText("Reverting to DHCP canceled.`r`n")
    }
})
$sidebarPanel.Controls.Add($btnDHCP)

$tooltip.SetToolTip($btnDHCP, "Reverts the IP settings back to automatic DHCP assignment.")

# Show Network Info Button
$btnShowNet = New-Object System.Windows.Forms.Button
$btnShowNet.Text = "Show Network Info"
$btnShowNet.Size = '160,40'
$btnShowNet.Location = '10,430'
$btnShowNet.Add_Click({
    $outputBox.Clear()
    $output = Get-NetIPConfiguration | Format-List | Out-String
    $outputBox.AppendText($output)
})

$sidebarPanel.Controls.Add($btnShowNet)

$tooltip.SetToolTip($btnShowNet, "Displays detailed network information for all adapters.")

$btnFlushDNS = New-Object System.Windows.Forms.Button
$btnFlushDNS.Text = "Flush DNS"
$btnFlushDNS.Size = '160,40'
$btnFlushDNS.Location = "10,480"
$btnFlushDNS.Add_Click({
    $msg = "This will flush the DNS resolver cache. Useful for testing DNS changes. Do you want to proceed?"
    $response = [System.Windows.Forms.MessageBox]::Show($msg, "Flush DNS", "YesNo", "Information")
    if ($response -eq "Yes") {
        ipconfig /flushdns | Out-Null
        $outputBox.AppendText("DNS cache flushed.`r`n")
    } else {
        $outputBox.AppendText("Flush DNS canceled.`r`n")
    }
})
$sidebarPanel.Controls.Add($btnFlushDNS)

$tooltip.SetToolTip($btnFlushDNS, "Flushes the DNS resolver cache.")

# $lblVamp= New-Object System.Windows.Forms.Label
# $lblVamp.Text = "Vampire"+"Lore"
# $lblVamp.Location = '100,750'
# $lblVamp.Size = '160,20'
# #$lblVamp.Dock = 'Bottom'
# $sidebarPanel.Controls.Add($lblVamp)


# --- Utilities Tab with Tweaks ---
$tabUtilities = New-Object System.Windows.Forms.TabPage
$tabUtilities.Text = "Utilities"
$tabUtilities.BackColor = '#aaaaaa'
$tabUtilities.AutoScroll = $true
$tabs.TabPages.Add($tabUtilities)

# Add watermark label to Utilities tab
$lblWatermarkUtilities = New-Object System.Windows.Forms.Label
$lblWatermarkUtilities.Text = "Created by vampirelore"
$lblWatermarkUtilities.Location = '10,700'
$lblWatermarkUtilities.ForeColor = 'Gray'
$lblWatermarkUtilities.Font = New-Object System.Drawing.Font("Arial", 8, [System.Drawing.FontStyle]::Italic)
$tabUtilities.Controls.Add($lblWatermarkUtilities)

# Add hidden tooltip watermark to Utilities tab
$lblWatermarkTip = New-Object System.Windows.Forms.Label
$lblWatermarkTip.Text = " "
$lblWatermarkTip.Size = '10,10'
$lblWatermarkTip.Location = '1,1'
$tabUtilities.Controls.Add($lblWatermarkTip)

$tooltip = New-Object System.Windows.Forms.ToolTip
$tooltip.SetToolTip($lblWatermarkTip, "vampirelore")

# Output Box for Utilities Tab
$outputUtilities = New-Object System.Windows.Forms.TextBox
$outputUtilities.Multiline = $true
$outputUtilities.ScrollBars = "Both"
$outputUtilities.ReadOnly = $true
$outputUtilities.Size = '570,650'
$outputUtilities.Location = '190,30'
$outputUtilities.Font = New-Object System.Drawing.Font("Consolas", 10)
$outputUtilities.BackColor = 'Black'
$outputUtilities.ForeColor = 'Lime'
$tabUtilities.Controls.Add($outputUtilities)


$btnUninstall = New-Object System.Windows.Forms.Button
$btnUninstall.Text = "Uninstall Program"
$btnUninstall.Size = '160,40'
$btnUninstall.Location = '850,30'
$btnUninstall.Add_Click({

    $registryPaths = @(
        "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*",
        "HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*",
        "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*"
    )
    $apps = foreach ($path in $registryPaths) {
        Get-ItemProperty $path -ErrorAction SilentlyContinue |
        Where-Object { $_.DisplayName -and $_.UninstallString } |
        Select-Object DisplayName, UninstallString
    }

    if (-not $apps) {
        [System.Windows.Forms.MessageBox]::Show("No uninstallable applications found.", "Info")
        return
    }

    # Create Form
    $formSelect = New-Object System.Windows.Forms.Form
    $formSelect.Text = "Select Program to Uninstall"
    $formSelect.Size = New-Object System.Drawing.Size(500, 500)
    $formSelect.StartPosition = "CenterScreen"

    $listBox = New-Object System.Windows.Forms.ListBox
    $listBox.Size = '460,360'
    $listBox.Location = '10,10'
    $listBox.Sorted = $true
    $apps | ForEach-Object { $listBox.Items.Add($_.DisplayName) }
    $formSelect.Controls.Add($listBox)

    $btnOK = New-Object System.Windows.Forms.Button
    $btnOK.Text = "Uninstall"
    $btnOK.Location = '100,400'
    $btnOK.Size = '100,30'
    $btnOK.Add_Click({
        if ($listBox.SelectedItem) {
            $formSelect.DialogResult = [System.Windows.Forms.DialogResult]::OK
            $formSelect.Close()
        } else {
            [System.Windows.Forms.MessageBox]::Show("Please select an application to uninstall.", "No Selection")
        }
    })
    $formSelect.Controls.Add($btnOK)

    $btnCancel = New-Object System.Windows.Forms.Button
    $btnCancel.Text = "Cancel"
    $btnCancel.Location = '250,400'
    $btnCancel.Size = '100,30'
    $btnCancel.Add_Click({ $formSelect.Close() })
    $formSelect.Controls.Add($btnCancel)

    # Show dialog
    if ($formSelect.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
        $selectedApp = $listBox.SelectedItem
        $appToRemove = $apps | Where-Object { $_.DisplayName -eq $selectedApp }

        if ($appToRemove) {
            $confirm = [System.Windows.Forms.MessageBox]::Show(
                "Are you sure you want to uninstall $selectedApp?",
                "Confirm Uninstall", "YesNo", "Question"
            )
            if ($confirm -eq "Yes") {
                $outputUtilities.AppendText("Uninstalling: $selectedApp`r`n")
                Start-Process "cmd.exe" -ArgumentList "/c $($appToRemove.UninstallString)" -Verb RunAs
                $outputUtilities.AppendText("$selectedApp uninstall command launched.`r`n")
            } else {
                $outputUtilities.AppendText("Uninstall canceled by user.`r`n")
            }
        } else {
            [System.Windows.Forms.MessageBox]::Show("Application not found.", "Error")
        }
    } else {
        $outputUtilities.AppendText("Uninstall window closed without action.`r`n")
    }
})
$tabUtilities.Controls.Add($btnUninstall)

$tooltip.SetToolTip($btnUninstall, "Uninstalls a selected program from the system.")

$y=40

# Checkbox: Disable Hibernation
$chkHiber = New-Object System.Windows.Forms.CheckBox
$chkHiber.Text = "Disable Hibernation"
$chkHiber.Location = "10,$y"
$chkHiber.Size = '160,20'
$tabUtilities.Controls.Add($chkHiber)

$tooltip.SetToolTip($chkHiber, "Disables hibernation to free up disk space.")

# Checkbox: Disable Telemetry
$y += 40
$chkTelemetry = New-Object System.Windows.Forms.CheckBox
$chkTelemetry.Text = "Disable Telemetry"
$chkTelemetry.Location = "10,$y"
$chkTelemetry.Size = '160,20'
$tabUtilities.Controls.Add($chkTelemetry)

$tooltip.SetToolTip($chkTelemetry, "Disables telemetry to enhance privacy.")

# Checkbox: Disable Tracking
$y += 40
$chkTrack = New-Object System.Windows.Forms.CheckBox
$chkTrack.Text = "Disable Tracking"
$chkTrack.Location = "10,$y"
$chkTrack.Size = '160,20'
$tabUtilities.Controls.Add($chkTrack)

$tooltip.SetToolTip($chkTrack, "Disables tracking features to enhance privacy.")

# Checkbox: Disable Background Apps
$y += 40
$chkBakgrnd = New-Object System.Windows.Forms.CheckBox
$chkBakgrnd.Text = "Disable Background Apps"
$chkBakgrnd.Location = "10,$y"
$chkBakgrnd.Size = '160,20'
$tabUtilities.Controls.Add($chkBakgrnd)

$tooltip.SetToolTip($chkBakgrnd, "Disables background apps to improve performance.")

# Checkbox: Debloat Edge
$y += 40
$chkEdge = New-Object System.Windows.Forms.CheckBox
$chkEdge.Text = "Debloat Edge"
$chkEdge.Location = "10,$y"
$chkEdge.Size = '160,20'
$tabUtilities.Controls.Add($chkEdge)

$tooltip.SetToolTip($chkEdge, "Removes Microsoft Edge from the system.")

# Checkbox: Enable Ultimate Performance
$y += 40
$chkPerf = New-Object System.Windows.Forms.CheckBox
$chkPerf.Text = "Enable Ultimate Performance"
$chkPerf.Location = "10,$y"
$chkPerf.Size = '160,30'
$tabUtilities.Controls.Add($chkPerf)

$tooltip.SetToolTip($chkPerf, "Enables the Ultimate Performance power plan for maximum performance.")

# Label
$lblTweaks = New-Object System.Windows.Forms.Label
$lblTweaks.Text = "Chose Your Tweaks:"
$lblTweaks.Location = '10,10'
$lblTweaks.Size = '160,20'
$tabUtilities.Controls.Add($lblTweaks)


# Run Selected Tweaks Button
$btnRunTweaks = New-Object System.Windows.Forms.Button
$btnRunTweaks.Text = "Run Selected Tweaks"
$btnRunTweaks.Size = '160,40'
$btnRunTweaks.Location = '850,80'
$btnRunTweaks.Add_Click({
    $outputUtilities.Clear()

    if ($chkHiber.Checked) {
        powercfg -h off
        $outputUtilities.AppendText("Hibernation disabled.`r`n")
    }

    if ($chkTelemetry.Checked) {
        $telemetryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
        if (-not (Test-Path $telemetryPath)) {
            New-Item -Path $telemetryPath -Force | Out-Null
        }
        Set-ItemProperty -Path $telemetryPath -Name "AllowTelemetry" -Value 0 -Force
        $outputUtilities.AppendText("Telemetry disabled.`r`n")
    }

    if ($chkTrack.Checked) {
        $trackPaths = @(
            "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors",
            "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection",
            "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System"
        )
        foreach ($path in $trackPaths) {
            if (-not (Test-Path $path)) {
                New-Item -Path $path -Force | Out-Null
            }
        }
        Set-ItemProperty -Path $trackPaths[0] -Name "DisableLocation" -Value 1 -Force
        Set-ItemProperty -Path $trackPaths[1] -Name "AllowTelemetry" -Value 0 -Force
        Set-ItemProperty -Path $trackPaths[2] -Name "EnableLUA" -Value 0 -Force
        $outputUtilities.AppendText("Tracking disabled.`r`n")
    }

    if ($chkEdge.Checked) {
        Get-AppxPackage *Microsoft.MicrosoftEdge* | Remove-AppxPackage
        $outputUtilities.AppendText("Microsoft Edge removed.`r`n")
    }

    if ($chkBakgrnd.Checked) {
        Get-AppxPackage -AllUsers | Where-Object { $_.Name -notlike "*Microsoft.WindowsStore*" } | Remove-AppxPackage
        $outputUtilities.AppendText("Background apps disabled.`r`n")
    }

    if ($chkPerf.Checked) {
        powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
        $outputUtilities.AppendText("Ultimate Performance Plan enabled.`r`n")
    }

    # Disable Cortana + Connected User Experience
    $searchPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"
    if (-not (Test-Path $searchPath)) {
        New-Item -Path $searchPath -Force | Out-Null
    }
    Set-ItemProperty -Path $searchPath -Name "AllowCortana" -Value 0 -Force
    Set-ItemProperty -Path $searchPath -Name "ConnectedUserExperience" -Value 0 -Force

    $outputUtilities.AppendText("Tweaks applied successfully.`r`n")
})
$tabUtilities.Controls.Add($btnRunTweaks)

$tooltip.SetToolTip($btnRunTweaks, "Applies the selected tweaks to the system.")

# Label
$lblInstall = New-Object System.Windows.Forms.Label
$lblInstall.Text = "Chose Your Install:"
$lblInstall.Location = '10,280'
$lblInstall.Size = '160,20'
$tabUtilities.Controls.Add($lblInstall)

# Your checkbox next to it
$chkChrome = New-Object System.Windows.Forms.CheckBox
$chkChrome.Text = "Chrome Installer"
$chkChrome.Location = '10,310'
$chkChrome.Size = '160,20'
$tabUtilities.Controls.Add($chkChrome)

$tooltip.SetToolTip($chkChrome, "Opens the Chrome installer link.")


# Checkbox for Chris Titus Tool (shifted right of the icon)
$chkChri = New-Object System.Windows.Forms.CheckBox
$chkChri.Text = 'Chris Titus Tool'
$chkChri.Size = '160,20'
$chkChri.Location = '10,340'
$tabUtilities.Controls.Add($chkChri)

$tooltip.SetToolTip($chkChri, "Opens the Chris Titus Tool installer link.")


$chkDebloater = New-Object System.Windows.Forms.CheckBox
$chkDebloater.Text = 'Debloater'
$chkDebloater.Size = '160,20'
$chkDebloater.Location = '10,370'
$tabUtilities.Controls.Add($chkDebloater)

$tooltip.SetToolTip($chkDebloater, "Opens the Windows 10 Debloater installer link.")

$chkBrowser = New-Object System.Windows.Forms.CheckBox
$chkBrowser.Text = 'Chromium Browser'
$chkBrowser.Size = '160,20'
$chkBrowser.Location = '10,400'
$tabUtilities.Controls.Add($chkBrowser)

$tooltip.SetToolTip($chkBrowser, "Opens the Chromium Browser installer link.")

$chkWinget = New-Object System.Windows.Forms.CheckBox
$chkWinget.Text = 'Winget'
$chkWinget.Size = '160,20'
$chkWinget.Location = '10,430'
$tabUtilities.Controls.Add($chkWinget)

$tooltip.SetToolTip($chkWinget, "Opens the Winget installer link.")

$chkMal = New-Object System.Windows.Forms.CheckBox
$chkMal.Text = 'Malwarebytes'
$chkMal.Size = '160,20'
$chkMal.Location = '10,460'
$tabUtilities.Controls.Add($chkMal)

$tooltip.SetToolTip($chkMal, "Opens the Malwarebytes installer link.")

$chkPtoys = New-Object System.Windows.Forms.CheckBox
$chkPtoys.Text = 'PowerToys'
$chkPtoys.Size = '160,20'
$chkPtoys.Location = '10,490'
$tabUtilities.Controls.Add($chkPtoys)

$tooltip.SetToolTip($chkPtoys, "Opens the PowerToys installer link.")

$chkCPUZ = New-Object System.Windows.Forms.CheckBox
$chkCPUZ.Text = 'CPU-Z'
$chkCPUZ.Size = '160,20'
$chkCPUZ.Location = '10,520'
$tabUtilities.Controls.Add($chkCPUZ)

$tooltip.SetToolTip($chkCPUZ, "Opens the CPU-Z installer link.")

$chkCCleaner = New-Object System.Windows.Forms.CheckBox
$chkCCleaner.Text = 'CCleaner'
$chkCCleaner.Size = '160,20'
$chkCCleaner.Location = '10,550'
$tabUtilities.Controls.Add($chkCCleaner)

$tooltip.SetToolTip($chkCCleaner, "Opens the CCleaner installer link.")

# Install Button
$btnInstall = New-Object System.Windows.Forms.Button
$btnInstall.Text = "Install Selected"
$btnInstall.Size = '160,40'
$btnInstall.Location = '850,130'
$btnInstall.Add_Click({
    $outputUtilities.Clear()
    $outputUtilities.AppendText("Installing selected tools...`r`n")

    if ($chkChrome.Checked) {
        Start-Process "https://www.google.com/chrome/" -UseShellExecute
        $outputUtilities.AppendText("Chrome installer opened.`r`n")
    }

    if ($chkChri.Checked) {
        $script = 'irm https://christitus.com/win | iex'
        Start-Process "powershell.exe" -ArgumentList "-NoProfile -WindowStyle Hidden -Command $script" -Verb RunAs
        $outputUtilities.AppendText("Chris Titus Tool installer started.`r`n")
    }

    if ($chkDebloater.Checked) {
        $script = 'irm https://git.io/debloat | iex'
        Start-Process "powershell.exe" -ArgumentList "-NoProfile -WindowStyle Hidden -Command $script" -Verb RunAs
        $outputUtilities.AppendText("Windows Debloater script started.`r`n")
    }

    if ($chkBrowser.Checked) {
        $msg = "This application is licensed to you by its owner.`r`n" +
               "Microsoft nor I will be responsible for this install. You must update it on your own to the latest version. " +
               "It doesn't come with all Chrome features at hand and ready to run.`r`n`r`n" +
               "Do you still want to install Chromium Browser via winget?"
    
        $response = [System.Windows.Forms.MessageBox]::Show($msg, "Chromium Browser Install", "YesNo", "Warning")
    
        if ($response -eq "Yes") {
            Start-Process "cmd.exe" -ArgumentList '/c winget install --id=eloston.ungoogled-chromium -e' -NoNewWindow
            $outputUtilities.AppendText("Chromium Browser installer launched via winget.`r`n")
        } else {
            $outputUtilities.AppendText("Chromium Browser installation was canceled by user.`r`n")
        }
    }
    

    if ($chkWinget.Checked) {
        Start-Process "powershell" -ArgumentList '-Command', 'winget install --id=eloston.ungoogled-chromium -e --accept-package-agreements --accept-source-agreements' -Verb RunAs
        $outputUtilities.AppendText("Winget installer started.`r`n")
    }

    if ($chkMal.Checked) {
        Start-Process "powershell" -ArgumentList '-Command', 'winget install --id=Malwarebytes.Malwarebytes -e --accept-package-agreements --accept-source-agreements' -Verb RunAs
        $outputUtilities.AppendText("Malwarebytes installer started.`r`n")
    }

    if ($chkPtoys.Checked) {
        Start-Process "powershell" -ArgumentList '-Command', 'winget install --id=Microsoft.PowerToys -e --accept-package-agreements --accept-source-agreements' -Verb RunAs
        $outputUtilities.AppendText("PowerToys installer started.`r`n")
    }

    if ($chkCPUZ.Checked) {
        Start-Process "powershell" -ArgumentList '-Command', 'winget install --id=CPUID.CPUID -e --accept-package-agreements --accept-source-agreements' -Verb RunAs
        $outputUtilities.AppendText("CPU-Z installer started.`r`n")
    }

    if ($chkCCleaner.Checked) {
        Start-Process "powershell" -ArgumentList '-Command', 'winget install --id=Piriform.CCleaner -e --accept-package-agreements --accept-source-agreements' -Verb RunAs
        $outputUtilities.AppendText("CCleaner installer started.`r`n")
    }

    $outputUtilities.AppendText("Installation process initiated.`r`n")    
})
$tabUtilities.Controls.Add($btnInstall)

$tooltip.SetToolTip($btnInstall, "Installs the selected tools using the appropriate installer links. | Please install one iteam at a time to avoid any possible conflicts.")

#--System
$tabSys = New-Object System.Windows.Forms.TabPage
$tabSys.Text = " System Info "
$tabSys.BackColor = '#aaaaaa'
$tabSys.AutoScroll = $true
$tabs.TabPages.Add($tabSys)

# Add watermark label to Utilities tab
$lblWatermarkSys = New-Object System.Windows.Forms.Label
$lblWatermarkSys.Text = "Created by vampirelore"
$lblWatermarkSys.Location = '10,700'
$lblWatermarkSys.ForeColor = 'Gray'
$lblWatermarkSys.Font = New-Object System.Drawing.Font("Arial", 8, [System.Drawing.FontStyle]::Italic)
$tabSys.Controls.Add($lblWatermarkSys)

# Add hidden tooltip watermark to Utilities tab
$lblWatermarkTip = New-Object System.Windows.Forms.Label
$lblWatermarkTip.Text = " "
$lblWatermarkTip.Size = '10,10'
$lblWatermarkTip.Location = '1,1'
$tabSys.Controls.Add($lblWatermarkTip)

$tooltip = New-Object System.Windows.Forms.ToolTip
$tooltip.SetToolTip($lblWatermarkTip, "vampirelore")


#Output Box for System Tab
$outputSys = New-Object System.Windows.Forms.TextBox
$outputSys.Multiline = $true
$outputSys.ScrollBars = "Both"
$outputSys.ReadOnly = $true
$outputSys.Size = '570,650'
$outputSys.Location = '190,30'
$outputSys.Font = New-Object System.Drawing.Font("Consolas", 10)
$outputSys.BackColor = 'Black'
$outputSys.ForeColor = 'Lime'
$tabSys.Controls.Add($outputSys)

# Systeminfo Button
$btnSysInfo = New-Object System.Windows.Forms.Button
$btnSysInfo.Text = "System Info"
$btnSysInfo.Size = '160,40'
$btnSysInfo.Location = '10,30'
$btnSysInfo.Add_Click({
    $output = systeminfo
    $outputSys.Text = $output -join "`r`n"
})

$tooltip.SetToolTip($btnSysInfo, "Displays detailed system information.")

#Energy Report Button
$btnEnergy = New-Object System.Windows.Forms.Button
$btnEnergy.Text = "Energy Report"
$btnEnergy.Size = '160,40'
$btnEnergy.Location = '10,80'
$btnEnergy.Add_Click({
    powercfg /energy
    Start-Process "C:\Windows\System32\energy-report.html"
    $outputSys.Text = "Energy report opened in your browser."
})

$tooltip.SetToolTip($btnEnergy, "Generates an energy report for the system.")

$btnBattery = New-Object System.Windows.Forms.Button
$btnBattery.Text = "Battery Report"
$btnBattery.Size = '160,40'
$btnBattery.Location = '10,130'
$btnBattery.Add_Click({
    $reportPath = "$env:USERPROFILE\\Documents\\battery-report.html"

    powercfg /batteryreport /output "$reportPath"
    Start-Sleep -Seconds 2

    if (Test-Path $reportPath) {
        Start-Process $reportPath  # You can also use "msedge.exe" if you prefer
        $outputSys.Text = "Battery report opened from Documents folder."
    } else {
        $outputSys.Text = "Battery report could not be generated. Make sure you're running as Administrator."
    }
})

$tooltip.SetToolTip($btnBattery, "Generates a battery report for the system in HTML.")

$btnDism = New-Object System.Windows.Forms.Button
$btnDism.Text = "System Repair"
$btnDism.Size = '160,40'
$btnDism.Location = '10,180'
$btnDism.Add_Click({
    $msg = " | When should you run this System Repair (DISM)?`r`n`r`n" +
           " | After Windows updates fail or won’t install`r`n" +
           " | When 'sfc /scannow' found issues but couldn’t fix them`r`n" +
           " | If the PC feels weird/glitchy but malware scans are clean`r`n`r`n" +
           " | This scan may take several minutes. Do you want to continue?"
           
    $response = [System.Windows.Forms.MessageBox]::Show($msg, "System Repair Tool", "YesNo", "Information")

    if ($response -eq "Yes") {
        $outputSys.Clear()
        $outputSys.AppendText("Running DISM... Please wait.`r`n`r`n")
        $result = dism /online /cleanup-image /restorehealth
        $outputSys.AppendText($result -join "`r`n")
    } else {
        $outputSys.AppendText("System Repair was canceled.`r`n")
    }
})

$tooltip.SetToolTip($btnDism, "Runs the DISM tool to repair system image issues.")

# Label
$lblScan = New-Object System.Windows.Forms.Label
$lblScan.Text = "Choose Scan Type:"
$lblScan.Location = '850,230'
$lblScan.Size = '160,20'
$tabSys.Controls.Add($lblScan)

# ComboBox
$cmbScanType = New-Object System.Windows.Forms.ComboBox
$cmbScanType.Items.AddRange(@("Quick Scan", "Full Scan", "Custom Folder Scan"))
$cmbScanType.SelectedIndex = 0
$cmbScanType.Location = '850,250'
$cmbScanType.Size = '160,25'
$tabSys.Controls.Add($cmbScanType)

# Scan Button
$btnScan = New-Object System.Windows.Forms.Button
$btnScan.Text = "Scan for Malware"
$btnScan.Size = '160,40'
$btnScan.Location = '850,290'
$btnScan.Add_Click({
    $outputSys.Clear()
    $scanType = $cmbScanType.SelectedItem.ToString()

    $exePath = "$env:ProgramFiles\Windows Defender\MpCmdRun.exe"
    if (!(Test-Path $exePath)) {
        $outputSys.AppendText("Windows Defender not found on this system.`r`n")
        return
    }

    switch ($scanType) {
        "Quick Scan" {
            $outputSys.AppendText("Running Quick Scan...`r`n`r`n")
            Start-Process $exePath -ArgumentList "-Scan -ScanType 1" -NoNewWindow -Wait
        }
        "Full Scan" {
            $outputSys.AppendText("Running Full Scan (this may take a while)...`r`n`r`n")
            Start-Process $exePath -ArgumentList "-Scan -ScanType 2" -NoNewWindow -Wait
        }
        "Custom Folder Scan" {
            $folderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
            if ($folderBrowser.ShowDialog() -eq "OK") {
                $path = $folderBrowser.SelectedPath
                $outputSys.AppendText("Scanning folder:`r`n$path`r`n`r`n")
                Start-Process $exePath -ArgumentList "-Scan -ScanType 3 -File `"$path`"" -NoNewWindow -Wait
            } else {
                $outputSys.AppendText("Custom scan canceled.`r`n")
            }
        }
    }

    $outputSys.AppendText("Scan completed.`r`n")
})

$tooltip.SetToolTip($btnScan, "Runs a malware scan using Windows Defender.")

# BIOS Access Button
$btnBIOS = New-Object System.Windows.Forms.Button
$btnBIOS.Text = "Enter BIOS"
$btnBIOS.Size = '160,40'
$btnBIOS.Location = '10,320'
$btnBIOS.Add_Click({
    try {
        shutdown /r /fw /f /t 0
        $tabSys.AppendText("Attempting to restart into firmware settings (UEFI)...`r`n")
    } catch {
        $msg = "This system may not support firmware-based restart or encountered an error.`r`n" +
               "Would you like to try a legacy-compatible method instead?"
        $response = [System.Windows.Forms.MessageBox]::Show($msg, "BIOS Access Error", "YesNo", "Warning")

        if ($response -eq "Yes") {
            Start-Process "cmd.exe" -ArgumentList "/c shutdown /r /f /t 0" -Verb RunAs
            $tabSys.AppendText("Fallback BIOS reboot command issued.`r`n")
        } else {
            $tabSys.AppendText("BIOS access cancelled by user.`r`n")
        }
    }
})
$tabSys.Controls.Add($btnBIOS)

$tooltip.SetToolTip($btnBIOS, "Restarts Computer into BIOS/UEFI settings.")

$sfcButton = New-Object System.Windows.Forms.Button
$sfcButton.Text = "SFC Scan"
$sfcButton.Size = '160,40'
$sfcButton.Location = '10,380'
$sfcButton.Add_Click({
    $outputSys.Clear()
    $outputSys.AppendText("Running System File Checker (sfc /scannow)...`r`n")
    Start-Process "cmd.exe" -ArgumentList "/c sfc /scannow" -NoNewWindow -Wait
    $outputSys.AppendText("SFC Scan completed.`r`n")
})
$tabSys.Controls.Add($sfcButton)

$tooltip.SetToolTip($sfcButton, "Runs the System File Checker to repair system files.")

$cleanupButton = New-Object System.Windows.Forms.Button
$cleanupButton.Text = "Clear Temp Files"
$cleanupButton.Size = '160,40'
$cleanupButton.Location = '10,430'
$cleanupButton.Add_Click({
    $outputSys.Clear()
    $outputSys.AppendText("Cleaning temp files...`r`n")
    Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
    $outputSys.AppendText("Temporary files removed.`r`n")
})
$tabSys.Controls.Add($cleanupButton)

$tooltip.SetToolTip($cleanupButton, "Clears temporary files from the system.")

$godModeButton = New-Object System.Windows.Forms.Button
$godModeButton.Text = "Open System Tools"
$godModeButton.Size = '160,40'
$godModeButton.Location = '10,480'
$godModeButton.Add_Click({
    $msg = "'God Mode' gives access to 200+ hidden Windows settings in one folder.`r`n`r`n" +
           "It includes admin tools, system tweaks, and control panel items.`r`n" +
           "Use carefully - changes can affect system behavior.`r`n`r`n" +
           "Do you want to open the System Tools folder on your Desktop?"
    
    $response = [System.Windows.Forms.MessageBox]::Show($msg, "God Mode", "YesNo", "Information")

    if ($response -eq "Yes") {
        $folder = "$env:USERPROFILE\Desktop\SystemTools.{ED7BA470-8E54-465E-825C-99712043E01C}"
        if (!(Test-Path $folder)) {
            New-Item -Path $folder -ItemType Directory | Out-Null
        }
        Start-Process $folder
        $outputSys.AppendText("System Tools folder opened on Desktop.`r`n")
    } else {
        $outputSys.AppendText("God Mode was canceled.`r`n")
    }
})
$tabSys.Controls.Add($godModeButton)

$tooltip.SetToolTip($godModeButton, "Opens the 'god Mode' folder with system tools and settings.")


$installedButton = New-Object System.Windows.Forms.Button
$installedButton.Text = "List Installed Apps"
$installedButton.Size = '160,40'
$installedButton.Location = '10,530'
$installedButton.Add_Click({
    $outputSys.Clear()
    $apps = Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName
    $apps += Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName
    $outputSys.AppendText("Installed Programs:`r`n`r`n")
    foreach ($app in $apps) {
        if ($app.DisplayName) { $outputSys.AppendText("$($app.DisplayName)`r`n") }
    }
})
$tabSys.Controls.Add($installedButton)

$tooltip.SetToolTip($installedButton, "Lists all installed applications on the system.")

# Add controls to the System tab
$tabSys.Controls.Add($sfcButton)
$tabSys.Controls.Add($cleanupButton)
$tabSys.Controls.Add($installedButton)
$tabSys.Controls.Add($godModeButton)
$tabSys.Controls.Add($lblTweaks)
$tabSys.Controls.Add($btnScan)
$tabSys.Controls.Add($btnDism)
$tabSys.Controls.Add($btnEnergy)
$tabSys.Controls.Add($btnSysInfo)
$tabSys.Controls.Add($btnBattery)


# Developer Tab Setup with Confirmation Popups

# Create Developer Tab
$tabDev = New-Object System.Windows.Forms.TabPage
$tabDev.Text = "Developer"
$tabDev.BackColor = '#aaaaaa'
$tabDev.AutoScroll = $true
$tabs.TabPages.Add($tabDev)

# Add watermark label to Utilities tab
$lblWatermarkDev = New-Object System.Windows.Forms.Label
$lblWatermarkDEv.Text = "Created by vampirelore"
$lblWatermarkDev.Location = '10,700'
$lblWatermarkDev.ForeColor = 'Gray'
$lblWatermarkDev.Font = New-Object System.Drawing.Font("Arial", 8, [System.Drawing.FontStyle]::Italic)
$tabDev.Controls.Add($lblWatermarkDev)

# Add hidden tooltip watermark to Utilities tab
$lblWatermarkTip = New-Object System.Windows.Forms.Label
$lblWatermarkTip.Text = " "
$lblWatermarkTip.Size = '10,10'
$lblWatermarkTip.Location = '1,1'
$tabDev.Controls.Add($lblWatermarkTip)

$tooltip = New-Object System.Windows.Forms.ToolTip
$tooltip.SetToolTip($lblWatermarkTip, "vamp"+"ire"+"lore")

# Output TextBox for Developer Tab
$outputDev = New-Object System.Windows.Forms.TextBox
$outputDev.Multiline = $true
$outputDev.ScrollBars = "Both"
$outputDev.ReadOnly = $true
$outputDev.Size = '570,650'
$outputDev.Location = '190,30'
$outputDev.Font = New-Object System.Drawing.Font("Consolas", 10)
$outputDev.BackColor = 'Black'
$outputDev.ForeColor = 'Lime'
$tabDev.Controls.Add($outputDev)

# Y-position tracker
$y = 30

# Button: Install VS Code
$btnVSCode = New-Object System.Windows.Forms.Button
$btnVSCode.Text = "Install VS Code"
$btnVSCode.Size = '160,40'
$btnVSCode.Location = "10,$y"
$btnVSCode.Add_Click({
    $msg = "Visual Studio Code is a lightweight but powerful code editor. Useful for scripting, development, and debugging. Do you want to install it?"
    $response = [System.Windows.Forms.MessageBox]::Show($msg, "Install VS Code", "YesNo", "Information")
    if ($response -eq "Yes") {
        Start-Process "powershell" -ArgumentList '-Command', 'winget install --id=Microsoft.VisualStudioCode -e --accept-package-agreements --accept-source-agreements' -Verb RunAs
        $outputDev.AppendText("VS Code installer started.`r`n")
    } else {
        $outputDev.AppendText("VS Code installation canceled.`r`n")
    }
})
$tabDev.Controls.Add($btnVSCode)

$tooltip.SetToolTip($btnVSCode, "Installs Visual Studio Code, a popular code editor.")

# Button: Install Git
$y += 50
$btnGit = New-Object System.Windows.Forms.Button
$btnGit.Text = "Install Git"
$btnGit.Size = '160,40'
$btnGit.Location = "10,$y"
$btnGit.Add_Click({
    $msg = "Git is a version control system used to track code changes. Required for using GitHub or managing code. Do you want to install it?"
    $response = [System.Windows.Forms.MessageBox]::Show($msg, "Install Git", "YesNo", "Information")
    if ($response -eq "Yes") {
        Start-Process "powershell" -ArgumentList '-Command', 'winget install --id=Git.Git -e --accept-package-agreements --accept-source-agreements' -Verb RunAs
        $outputDev.AppendText("Git installer started.`r`n")
    } else {
        $outputDev.AppendText("Git installation canceled.`r`n")
    }
})
$tabDev.Controls.Add($btnGit)

$tooltip.SetToolTip($btnGit, "Installs Git, a version control system for tracking code changes.")

# Button: Install Node.js
$y += 50
$btnNode = New-Object System.Windows.Forms.Button
$btnNode.Text = "Install Node.js"
$btnNode.Size = '160,40'
$btnNode.Location = "10,$y"
$btnNode.Add_Click({
    $msg = "Node.js allows you to run JavaScript outside of a browser and is used for web apps and backend tools. Do you want to install it?"
    $response = [System.Windows.Forms.MessageBox]::Show($msg, "Install Node.js", "YesNo", "Information")
    if ($response -eq "Yes") {
        Start-Process "powershell" -ArgumentList '-Command', 'winget install --id=OpenJS.NodeJS -e --accept-package-agreements --accept-source-agreements' -Verb RunAs
        $outputDev.AppendText("Node.js installer started.`r`n")
    } else {
        $outputDev.AppendText("Node.js installation canceled.`r`n")
    } 
})
$tabDev.Controls.Add($btnNode)

$tooltip.SetToolTip($btnNode, "Installs Node.js, a JavaScript runtime for server-side development.")

$btnFileExt = New-Object System.Windows.Forms.Button
$btnFileExt.Text = "Show File Extensions"
$btnFileExt.Size = '160,40'
$btnFileExt.Location = "10,$($y + 50)"
$btnFileExt.Add_Click({
    $msg = "This will show file extensions for known file types in Windows Explorer. Do you want to proceed?"
    $response = [System.Windows.Forms.MessageBox]::Show($msg, "Show File Extensions", "YesNo", "Information")
    if ($response -eq "Yes") {
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name HideFileExt -Value 0
        $outputDev.AppendText("File extensions are now visible.`r`n")
    } else {
        $outputDev.AppendText("Show file extensions canceled.`r`n")
    }
})
$tabDev.Controls.Add($btnFileExt)

$tooltip.SetToolTip($btnFileExt, "Shows file extensions for known file types in Windows Explorer.")

$btnHdnFiles = New-Object System.Windows.Forms.Button
$btnHdnFiles.Text = "Show Hidden Files"
$btnHdnFiles.Size = '160,40'
$btnHdnFiles.Location = "10,$($y + 100)"
$btnHdnFiles.Add_Click({
    $msg = "This will show hidden files and folders in Windows Explorer. Do you want to proceed?"
    $response = [System.Windows.Forms.MessageBox]::Show($msg, "Show Hidden Files", "YesNo", "Information")
    if ($response -eq "Yes") {
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name Hidden -Value 1
        $outputDev.AppendText("Hidden files are now visible.`r`n")
    } else {
        $outputDev.AppendText("Show hidden files canceled.`r`n")
    }
})
$tabDev.Controls.Add($btnHdnFiles)

$tooltip.SetToolTip($btnHdnFiles, "Shows hidden files and folders in Windows Explorer.")



# Create Read Me Tab
$tabReadMe = New-Object System.Windows.Forms.TabPage
$tabReadMe.Text = "Read Me"
$tabReadMe.BackColor = '#dddddd'
$tabReadMe.AutoScroll = $true
$tabs.TabPages.Add($tabReadMe)

# Create TextBox to display readme content
$readmeBox = New-Object System.Windows.Forms.TextBox
$readmeBox.Multiline = $true
$readmeBox.ReadOnly = $true
$readmeBox.ScrollBars = "Vertical"
$readmeBox.Dock = "Fill"
$readmeBox.Font = New-Object System.Drawing.Font("Segoe UI", 10)
$readmeBox.BackColor = 'Black'
$readmeBox.ForeColor = 'Green'

$readmeBox.Text = @"

# ************************************************************************************
#   __      __                         _                   _                    
#   \ \    / /                        (_)                 | |                   
#    \ \  / /  _ _   _ __ ___   _ __  _ _ __ ___          | |       ___    _ __   ___ 
#     \ \/ /  / _` | | '_ ` _ \ | '_ \| || '__/ _ \       | |      / _ \  | '__/ /  _ \
#      \  /  / (_| | |  | | | | | |_) | || | |  __/       | |___  | (_) | | |   |   __/
#       \/   \__,_ | | _| |_| |_| .__/|_||_|  \___|       |______\ \___/  |_|    \___|
#          _____   _____      _ | |_      _                                   
#         |  __ \ / ____|    | ||_| |    | |                                  
#         | |__) | |   ______| |__| | ___| |_ __   ___ _ __                   
#         |  ___/| |  |______|  __  |/ _ \ | '_ \ / _ \ '__|                  
#         | |    | |____     | |  | |  __/ | |_) |  __/ |                     
#         |_|     \_____|    |_|  |_|\___|_| .__/ \___|_|                     
#                                          | |                                
#                                          |_|           
# ************************************************************************************


PC Healer - Tools by Vampirelore
=================================

This PowerShell GUI toolbox is designed to provide quick access to a range of helpful system utilities, tweaks, and diagnostics — all in one script-driven interface.

📦 FEATURES
----------
• WiFi tools: Show/export profiles, DNS/IP settings, revert DHCP, etc.
• System tools: Battery & energy reports, SFC & DISM repair, malware scanning
• Developer tools: Git, VS Code, Node.js, file extensions visibility
• Utility tweaks: Disable telemetry, debloat apps, optimize performance
• Uninstall programs via GUI
• BIOS reboot support (UEFI and legacy)
• Tooltips and guided confirmations throughout

⚠️ REQUIREMENTS
---------------
• Windows 10 or 11
• Administrator privileges (for full functionality)
• PowerShell 5.1 or later (recommended)
• Internet connection is not required but will be needed (for installing optional tools)

🔒 WATERMARK VALIDATION
------------------------
This script includes a watermark verification check to protect the author's identity.
To run the script successfully, it must contain at least **3 unique instances** of the `vampirelore` watermark, including alternate formats like:
- VampireLore
- vampire-lore
- "vamp" + "irelore"

This ensures the script remains attributed to its creator.

🛡️ SECURITY & SOURCE
---------------------
This script is *not* obfuscated or compiled into EXE. You can inspect, customize, and improve upon it freely. All code is visible and open-source. Just don't remove credit!

📝 CREDITS
----------
Author: Vampirelore  
Tool Version: 3.0  
Script language: PowerShell + Windows Forms (.NET)

💡 TIPS
-------
• Hover over buttons for usage info.
• Use scrollbars if screen size is small.
• If a feature does not launch, try running as Administrator.

---

Thank you for using PC Healer.

# PC Healer Toolbox - Created by Vampirelore
# Licensed under GNU GPL v3
# This script is open-source. You are free to use, share, and improve it,
# as long as any modifications remain .bat and stay open sourced also give credit to the original author.

Generated for public release: Year | {2025} Month | {April}

💡 Tip:
Run as Administrator for full access to all system functions.

💀 Created with heart and code by: vampirelore
"@


$tabReadMe.Controls.Add($readmeBox)

# Show the form
$form.ShowDialog()