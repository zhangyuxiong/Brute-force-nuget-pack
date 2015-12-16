# 蛮力打包nuget

## 说明

目前包含两个脚本：
* bfnp.ps1 用于无法找到源码的dll打包
* pack.ps1 用于打包指定目录下所有nuspec,csproj(默认为csproj)

## bfnp.ps1使用说明

### 说明

* 根据目标目录下的所有dll，在输出目录中生成nuspec及nupkg
* 包含调用pack.ps1

### 使用方法

	
```PowerShell
.\bfnp.ps1 -Path dll所在目录  -out 输出nuget包文件的目录
```

### 参数

    
```PowerShell
#-Path dll所在目录
[Parameter(Position=0,Mandatory=0,HelpMessage="target dll directory")]
[string]$Path=$(throw "Parameter missing:-path Path"),
#-Out 输出目录
[Parameter(Position=0,Mandatory=0,HelpMessage="nuget package out directory")]
[string]$Out=$(throw "Parameter missing:-path Out"),
#-Auth 默认作者，会优先使用dll中的，如果没有使用默认
[string]$Auth="anonymous",
#-projectUrl 项目地址
[string]$projectUrl="HTTP://PROJECTURL",
#-defaultVersion 默认版本号
[string]$defaultVersion="1.0.0.0"
```
	
## pack.ps1使用说明

### 使用方法


```PowerShell
.\pack.ps1 -Path 目标目录  -out 输出nuget包文件的目录
```

### 参数

```PowerShell
#-Path dll所在目录
[string]$Path=$(throw "Parameter missing:-path Path"),
#-Out dll所在目录
[string]$Out,
#-type 目标文件类型 nuspec or csproj 默认为csproj
[string]$Type="csproj"
```