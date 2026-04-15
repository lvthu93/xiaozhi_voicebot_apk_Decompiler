param(
    [string]$Mac
)

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

Write-Host "================ TẠP HÓA PC ================"


if (-not $Mac) {
    Write-Host "Usage: powershell -ExecutionPolicy Bypass -File .\xiaozhi.ps1 <mac>"
    exit 1
}

$UUID = [guid]::NewGuid().ToString()

# body JSON
$Body = @{
    mac_address = $Mac
    uuid        = $UUID
} | ConvertTo-Json

# headers
$Headers = @{
    "Device-Id" = $Mac
    "Client-Id" = $UUID
    "Content-Type" = "application/json"
}

# call API
try {
    $Response = Invoke-RestMethod -Uri "https://api.tenclass.net/xiaozhi/ota/activate" `
        -Method Post `
        -Headers $Headers `
        -Body $Body `
        -ErrorAction Stop
}
catch {
    Write-Host "❌ Lỗi gọi API: $_"
    exit 1
}

# parse device_id
$DeviceId = $null
if ($Response.device_id) {
    $DeviceId = $Response.device_id
} else {
    # fallback regex nếu response là string
    $DeviceId = [regex]::Match(($Response | Out-String), '"device_id"\s*:\s*(\d+)').Groups[1].Value
}

if ($DeviceId) {
    Write-Host "📡 MAC: $Mac"
    Write-Host "🔑 UUID: $UUID"
    Write-Host "✅ DEVICE ID: $DeviceId"
} else {
    Write-Host "📦 $Response"
    Write-Host "❌ Không có DEVICE ID (có thể API đã thay đổi)"
}

Write-Host "============= Shop.TapHoaPC.Com ============="