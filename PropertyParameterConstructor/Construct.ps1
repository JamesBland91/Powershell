Add-Type -assembly System.Windows.Forms

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
#Groupbox
$GroupBox = New-Object System.Windows.Forms.GroupBox
#RadioButton
$RadioButton = New-Object System.Windows.Forms.RadioButton



#added some comment text for Github


$combo = ($form, $textbox, $button, $label, $checkbox, $combobox, $GroupBox, $RadioButton) | Get-Member | Where-Object { $_.membertype -eq "Property " }

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
        $Commonobject += New-Object psobject -property @{Type = $Collection.TypeName; Name = $commonName }

    }
}

$uniqueobject | Out-GridView
$Commonobject | Out-GridView

$AllClassesinNamespace = [AppDomain]::CurrentDomain.GetAssemblies().GetTypes()  | Where-Object { $_.Basetype -match 'System.Windows.Forms' }

$ClassNames = $AllClassesinNamespace.basetype | Where-Object { $_.basetype -match "System.Windows.Forms" } | Select-Object -Unique -ExpandProperty Name


$form = New-Object System.Windows.Forms.

$confirmedobjects = @()

foreach ($item in $ClassNames) {

    $command = '$object = New-Object System.Windows.Forms.' + $item
    $scriptBlock = [Scriptblock]::Create($command)
    Invoke-Command -ScriptBlock $scriptBlock
    if ($?) {
        $confirmedobjects += $item
    }

}



foreach ($obj in $confirmedobjects) {
    $command = '$object = New-Object System.Windows.Forms.' + $obj
    $scriptBlock = [Scriptblock]::Create($command)
    Invoke-Command -ScriptBlock $scriptBlock
    $combo
    $object 
}


$combo += $object | Get-Member | Where-Object { $_.membertype -eq "Property " }

#provides definition also which indicates the type of input for some  
$form | Get-Member | Where-Object { $_.membertype -eq "Property " }

($form.text).gettype()

(($form.text).gettype()).Name




#name, type, foundin, unique

#Determine the form objects that can be created. 

#Create form object and extract the property information

#Create list of all unique properties to check against the form object

#write

class FormProperty {
    [String] $name;
    [string] $type;
    [string] $foundin;
    [bool] $unique;

    FormProperty([String] $name, [string] $type, [string] $foundin, [bool] $unique) {
        $this.name = $name
        $this.type = $type
        $this.foundin = $foundin
        $this.unique = $unique
    }
}





$i = 1
$output = @()
for ($i = 0; $i -lt 10; $i++) {

 
    [string]$test = "Hello$i"
    $output += [FormProperty]::New("testname", $test, "Foundin, found in etc", $true)

}


