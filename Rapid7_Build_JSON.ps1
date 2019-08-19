﻿$file = "D:\Scripts\JSON\2019.01.json"
$cvefile = "D:\Scripts\CVE_List\2019.01.txt"
$String1 = @"
{
    "description": "Monthly Microsoft OS Patching Compliance",
    "name": "2019.01.MS.OS (Patch Tuesday)",
    "searchCriteria": {
        "filters": [
"@
$string3 = @"
        ],
        "match": "any"
    },
    "type": "dynamic"
}
"@
$string4 = @"
                { "field": "cve", "operator": "is", "value": "
"@
$string5 = @"
" }, 
"@
$cvelist = Get-Content $cvefile
Set-Content -Path $file -Value $string1 -force
foreach ($cve in $cvelist) {
Add-Content $file $string4$cve$string5
}
Add-Content $file $string3