Add-Type -AssemblyName PresentationFramework
Add-Type -assembly System.Windows.forms
[AppDomain]::CurrentDomain.GetAssemblies().GetTypes() | where-object { $_.Namespace -contains "System.Windows.Forms" }


#Form
$form = New-Object System.Windows.Forms.Form
#textbox
$Textbox = New-Object System.Windows.Forms.TextBox
#Button
$Button = New-Object System.Windows.Forms.Button
#label
$Label = New-Object System.Windows.Forms.Label
#Checkbox
$Checkbox = new-object System.Windows.Forms.checkbox
#combobox
$ComboBox = New-Object System.Windows.Forms.ComboBox


$combo = ($form, $textbox, $button, $label, $checkbox, $combobox) | Get-Member | Where-Object { $_.membertype -eq "Property " }

$unique = $combo | Select-Object -Unique 

$uniqueobject = @()
$Commonobject = @()

Foreach ($item in $unique) {
    [int32]$count = ($combo | Where-Object { $_.name -like $item.name }).count
    if ($count -eq 1) {
        Write-Debug "The item $($item.name) is Unique and linked to $($item.TypeName)"
        $uniqueobject += New-Object psobject -property @{Type = $item.TypeName; Name = $item.Name }
    }
    else {
        $Collection = $combo | Where-Object { $_.name -like $item.name }
        $commonName = $Collection | Select-Object -Unique -ExpandProperty Name
        $Commonobject += New-Object psobject -property @{Type = ($Collection.TypeName -join ","); Name = $commonName }

    }
}

$uniqueobject | Out-GridView
$Commonobject | Out-GridView




