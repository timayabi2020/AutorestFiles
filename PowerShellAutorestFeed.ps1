$FeedName = "LocalForkedAutorest"
$UserName = "AzDoUsername"
$Repositories = Get-PSRepository
$Count = 0
$SourceLocation = "https://pkgs.dev.azure.com/microsoftgraph/_packaging/LocalForkedAutorest/nuget/v2"
ForEach($Item in $Repositories)
{
	if($Item.Name -eq $FeedName)
	{
		$Count++
		Break
	}
}
if($Count -eq 0)
{
	#Connect and register feed
	$PatToken = $env:PS_Preview_Feed_PAT | ConvertTo-SecureString -AsPlainText -Force
	$CredsAzureDevopsServices = New-Object System.Management.Automation.PSCredential($UserName, $PatToken)
	Register-PSRepository -Name $FeedName -SourceLocation $SourceLocation -PublishLocation $SourceLocation -InstallationPolicy Trusted -Credential $CredsAzureDevopsServices
	Register-PackageSource -Name $FeedName -Location $SourceLocation -ProviderName NuGet -Trusted -SkipValidate -Credential $CredsAzureDevopsServices
}
