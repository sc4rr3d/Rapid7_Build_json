<#
Script written by SC4RR3D
Version: 1.1
Last Update: 24/08/2019
#>

# Input file
$cve_file = "D:\Scripts\CVE_List\2019.01.txt"

# Output file
$out_file = "D:\Scripts\JSON\2019.08.json"

# First 5 lines of the .json file.
# Sets the description, name varibles
# Change the name string to what you want to see the dynamic group called in Rapid7 Nexpose
$start_json = @"
{
    "description": "Monthly Microsoft OS Patching Compliance",
    "name": "2019.01.MS.OS (Patch Tuesday)",
    "searchCriteria": {
        "filters": [
"@

# This string starts the cve line
$begin_cve_line = @"
                { "field": "cve", "operator": "is", "value": "
"@

# This line ends the cve line
$end_cve_line = @"
" }, 
"@

# This line ends  the .json file and sets the type
$end_json = @"
        ],
        "match": "any"
    },
    "type": "dynamic"
}
"@
<#
Main logic of the script
#>

# read in the cve list
$cvelist = Get-Content $cve_file

# write the first part of the .json file
Set-Content -Path $out_file -Value $start_json -force

# for loop, read each cve in cvelist add new lines to .json file

foreach ($cve in $cvelist) {
Add-Content $out_file $begin_cve_line$cve$end_cve_line
}

# Correct the last line by removing the trailing comma
$lastcve = (Get-Content $out_file -Tail 1) -replace ' },',' }'

# Read in the .json file except the last line because we need to remove it to correct it.
$json_file = Get-Content $out_file | select -SkipLast 1

# Start writing the file to disk
Set-Content $out_file $json_file

# add in the corrected last line
Add-Content $out_file $lastcve

# end the .json file
Add-Content $out_file $end_json

#end of script