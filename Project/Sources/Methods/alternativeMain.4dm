//%attributes = {}

var $env : Object

$env:=New object:C1471
var $pos : Integer
var $line : Text
var $in; $out; $err : Text

If (Is Windows:C1573)
	SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE"; "true")
End if 

LAUNCH EXTERNAL PROCESS:C811((Is Windows:C1573) ? "cmd /C SET" : "/usr/bin/env"; $in; $out; $err)

LOG EVENT:C667(Into system standard outputs:K38:9; $out)


For each ($line; Split string:C1554($out; (Is Windows:C1573) ? Char:C90(Carriage return:K15:38) : Char:C90(Line feed:K15:40); sk ignore empty strings:K86:1))
	$pos:=Position:C15("="; $line)
	If ($pos>0)
		$env[Substring:C12($line; 1; $pos-1)]:=Substring:C12($line; $pos+1)
		If (Is Windows:C1573 && (Length:C16($line)>0) && ($line[[1]]="'") && ($line[[Length:C16($line)]]="'"))  //  if window, remove  leading and trailig quote '
			$env[Substring:C12($line; 1; $pos-1)]:=Substring:C12($line; $pos+2; Length:C16($line)-$pos-2)
		End if 
	Else 
		$env[$line]:=""
	End if 
End for each 


If ($env["GITHUB_EVENT_PATH"]#Null:C1517)
	var $eventFile : 4D:C1709.File
	$eventFile:=(Is Windows:C1573) ? File:C1566(String:C10($env["GITHUB_EVENT_PATH"]); fk platform path:K87:2) : File:C1566(String:C10($env["GITHUB_EVENT_PATH"]))
	$env.event:=JSON Parse:C1218($eventFile.getText())
End if 


LOG EVENT:C667(Into system standard outputs:K38:9; JSON Stringify:C1217($env; *))