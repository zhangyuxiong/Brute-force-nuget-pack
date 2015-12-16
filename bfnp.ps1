<#
.EXAMPLE
.\bfnp.ps1 -Path target dll's directory  -out  out nuget package  directory 

.NOTES
Brute force nuget pack

#>
param(
[Parameter(Position=0,Mandatory=0,HelpMessage="target dll directory")]
[string]$Path=$(throw "Parameter missing:-path Path"),
[Parameter(Position=0,Mandatory=0,HelpMessage="nuget package out directory")]
[string]$Out=$(throw "Parameter missing:-path Out"),
[string]$Auth="anonymous",
[string]$projectUrl="HTTP://PROJECTURL",
[string]$defaultVersion="1.0.0.0"
)

Get-ChildItem "$Path\\*.dll" |
  Select-Object -ExpandProperty VersionInfo | % -process{
    write-host $_.ProductName
    #$id=$_.ProductName
    $fileName=$_.FileName
    $version=$_.Productversion
    $company= $_.CompanyName
    $copyright= $_.LegalCopyright
    $FileDescription=$_.FileDescription
    #原使用ProductName，但发现竟然有dll没有，部分dll的ProductName是短名称或缩写 囧！
    $id=$_.OriginalFilename
    $id=$id.Replace(".dll","")
    if([string]::IsNullOrWhiteSpace($version))
    {
      $version=$defaultVersion
    }
    if([string]::IsNullOrWhiteSpace($company))
    {
      $company=$Auth
    }
    if([string]::IsNullOrWhiteSpace($copyright))
    {
      $copyright=" Copyright © $company 2015"
    }
    if([string]::IsNullOrWhiteSpace($FileDescription))
    {
      $FileDescription=$id
    }
   
     
    write-host "filename=$fileName id=$id version=$version"
    $outpath="$Out\$id"
    if (!(Test-Path $outpath)){
        New-Item "$outpath\bin" -type directory
        Copy-Item $fileName "$outpath\bin"
      }
#warning：  Assembly not inside a framework folder.
$SpecTemplate=(
'<?xml version="1.0"?>
<package >
<metadata>
    <id>{0}</id>
    <version>{1}</version>
    <title>{0}</title>
    <authors>{2}</authors>
    <projectUrl>{3}</projectUrl>
    <description>{4}</description>
    <copyright>{5}</copyright>
  </metadata>
  <files>
    <file src="bin\*.dll" target="lib" />
  </files>
</package>' -f $id,$version, $company,$projectUrl,$FileDescription,$copyright)
        $SpecTemplate | out-file -filepath "$outpath\package.nuspec"         
    
}

$packps=Join-Path $PSScriptRoot "pack.ps1"
Write-Host $packps -path $Path -outPath $Out -type "nuspec"

&$packps -path $Out -outPath $Out -type "nuspec"

