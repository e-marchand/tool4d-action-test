//%attributes = {}




var $message : Text
$message:="🎉 "



var $r : Real
var $startupParam : Text
var $config : Object
$r:=Get database parameter:C643(User param value:K37:94; $startupParam)
If (Length:C16($startupParam)>1)
	
	$config:=JSON Parse:C1218($startupParam)
	
	$message+=$config.name || "hello"
	$message+=" "
	$message+=$config.word || "world"
	
Else 
	$message+="hello"
	$message+=" "
	$message+="world"
End if 


LOG EVENT:C667(Into system standard outputs:K38:9; "🎉 hello world")