$StartTime=(Get-Date).AddHours(-72)
$Alerts=@()

#check failed logons
$Failed = Get-WinEvent -FilterHashtable @{
LogName ='Security'
Id=4625
StartTime=$StartTime
}
if($Failed.count -gt 5){
$Alerts+="Multiple failed logons detected"
}

#check log clearing(1102)
$LogCleared =Get-WinEvent -FilterHashtable @{
LogName ='Security'
Id=1102
StartTime=$StartTime
}
if($LogCleared){
$Alerts+="Security Log was cleared"
}
#export Report
if($Alerts.count -gt 0){
$Date=Get-Date -Format "yyyyMMdd_HHmm"
$Alerts | Out-File "D:\Autotask\Alert_$Date.txt"
}