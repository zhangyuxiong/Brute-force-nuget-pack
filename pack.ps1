param(
[string]$Path=$(throw "Parameter missing:-path Path"),
[string]$Out,
#nuspec or csproj
[string]$type="csproj"
)

if([string]::IsNullOrWhiteSpace($Out))
{
	$Out=$Path
}
if(!(Test-Path $Out))
{
	New-Item $Out -type directory
}
$nugetexe=Join-Path $PSScriptRoot ".nuget\nuget.exe"
#循环目录下的 nuspec 打包nuget
Get-ChildItem $Path -filte "*.$type" -r | % -process {
	$filepath=$_.fullname
	Write-Host $filepath
	&$nugetexe pack $filepath -o $Path
}




