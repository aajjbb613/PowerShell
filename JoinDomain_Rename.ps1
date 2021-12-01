$name = Read-Host 'Input the computer's name LK-XXX'
Add-Computer -DomainName Laurysen.local -newname $name -Restart
