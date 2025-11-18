# --- BENIGN PAYLOAD SCRIPT (For Educational Simulation) ---
# This script simulates the actions of a malicious payload using harmless commands.
# It is designed to be run with administrative privileges (obtained via the hypothetical UAC bypass).

# --- [Phase 1: Reconnaissance & Information Gathering] ---
# A real attacker would silently gather data about the system, user, and network.
# We will simulate this by getting some system info and saving it to a visible text file.

$reconFile = "C:\Users\Public\Documents\System_Audit.txt"
Add-Content -Path $reconFile -Value "--- System Reconnaissance Report ---"
Add-Content -Path $reconFile -Value "Audit Timestamp: $(Get-Date)"
Add-Content -Path $reconFile -Value "Computer Name: $env:COMPUTERNAME"
Add-Content -Path $reconFile -Value "Current User: $env:USERNAME"
Add-Content -Path $reconFile -Value "Operating System: $(Get-ComputerInfo -Property OsName, OsVersion).OsName"
Add-Content -Path $reconFile -Value "--- Network Configuration ---"
Get-NetIPAddress | Out-File -FilePath $reconFile -Append

# MALICIOUS EQUIVALENT: A real attacker would run commands like `whoami /all`, `ipconfig /all`, `net user`,
# and scan for sensitive files (`*.docx`, `*.pdf`, etc.), then send this data to their server instead of a local file.


# --- [Phase 2: Establish Persistence] ---
# An attacker wants their code to survive a reboot. A common way is using a Scheduled Task.
# We will create a task that does something harmless: it opens Notepad every time the user logs on.

$taskName = "BenignReminder"
$taskAction = New-ScheduledTaskAction -Execute "notepad.exe"
$taskTrigger = New-ScheduledTaskTrigger -AtLogOn
Register-ScheduledTask -TaskName $taskName -Action $taskAction -Trigger $taskTrigger -Force

# MALICIOUS EQUIVALENT: Instead of "notepad.exe", the attacker would point this task back to their
# malicious script, ensuring they regain control every time the computer is started.


# --- [Phase 3: Action on Objectives] ---
# This is where the attacker would execute their main goal (steal data, deploy ransomware, etc.).
# We will simulate this by creating a "warning" file on the user's desktop.

$warningFile = "$env:USERPROFILE\Desktop\SECURITY_AUDIT_NOTICE.txt"
$warningMessage = @"
Your system has been accessed by a simulated security audit script.
In a real attack, this file could have been a ransomware note.

This demonstrates the importance of:
1. Physical device security.
2. Keeping your system patched and updated.
3. Using modern endpoint security software.
"@
Set-Content -Path $warningFile -Value $warningMessage

# MALICIOUS EQUIVALENT: This is the most dangerous part. The attacker could use PowerShell commands
# like `Encrypt-File`, `Copy-Item` to an external server, or `Remove-Item -Recurse -Force` to delete data.


# --- [Phase 4: Cleanup (Optional)] ---
# Some attackers might try to hide their initial entry point.
# This is often skipped if the goal is noisy, like ransomware.

# For our simulation, we'll leave the evidence in place for educational review.

# --- End of Script ---