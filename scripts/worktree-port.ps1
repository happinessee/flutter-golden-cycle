<#
worktree-port.ps1 - Windows-native port allocator (mirrors worktree-port.sh).

Usage: pwsh scripts/worktree-port.ps1 <worktree-name>
Output: integer in [PortFloor, PortFloor + Buckets - 1]
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$Name
)

# TODO(user): keep these in sync with worktree-port.sh - cross-platform determinism depends on it.
$PortFloor = 8080
$Buckets   = 100

$bytes = [System.Text.Encoding]::UTF8.GetBytes($Name)
$sha   = [System.Security.Cryptography.SHA256]::Create()
try {
    $hashBytes = $sha.ComputeHash($bytes)
} finally {
    $sha.Dispose()
}

# Take first 4 bytes -> unsigned int -> mod Buckets (matches POSIX's "first 8 hex chars" = first 4 bytes).
$n = [BitConverter]::ToUInt32($hashBytes, 0)
$bucket = [int]($n % [uint32]$Buckets)
$port   = $PortFloor + $bucket
Write-Output $port
