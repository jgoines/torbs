#Region
#AutoIt3Wrapper_Icon=icons\dead.ico
#AutoIt3Wrapper_res_requestedExecutionLevel=asInvoker
#EndRegion
Func _HEXTOSTRING($STRHEX)
	If StringLeft($STRHEX, 2) = "0x" Then Return BinaryToString($STRHEX)
	Return BinaryToString("0x" & $STRHEX)
EndFunc
Func _STRINGBETWEEN($S_STRING, $S_START, $S_END, $V_CASE = -1)
	Local $S_CASE = ""
	If $V_CASE = Default Or $V_CASE = -1 Then $S_CASE = "(?i)"
	Local $S_PATTERN_ESCAPE = "(\.|\||\*|\?|\+|\(|\)|\{|\}|\[|\]|\^|\$|\\)"
	$S_START = StringRegExpReplace($S_START, $S_PATTERN_ESCAPE, "\\$1")
	$S_END = StringRegExpReplace($S_END, $S_PATTERN_ESCAPE, "\\$1")
	If $S_START = "" Then $S_START = "\A"
	If $S_END = "" Then $S_END = "\z"
	Local $A_RET = StringRegExp($S_STRING, "(?s)" & $S_CASE & $S_START & "(.*?)" & $S_END, 3)
	If @error Then Return SetError(1, 0, 0)
	Return $A_RET
EndFunc
Func _STRINGENCRYPT($I_ENCRYPT, $S_ENCRYPTTEXT, $S_ENCRYPTPASSWORD, $I_ENCRYPTLEVEL = 1)
	If $I_ENCRYPT <> 0 And $I_ENCRYPT <> 1 Then
		SetError(1, 0, "")
	ElseIf $S_ENCRYPTTEXT = "" Or $S_ENCRYPTPASSWORD = "" Then
		SetError(1, 0, "")
	Else
		If Number($I_ENCRYPTLEVEL) <= 0 Or Int($I_ENCRYPTLEVEL) <> $I_ENCRYPTLEVEL Then $I_ENCRYPTLEVEL = 1
		Local $V_ENCRYPTMODIFIED
		Local $I_ENCRYPTCOUNTH
		Local $I_ENCRYPTCOUNTG
		Local $V_ENCRYPTSWAP
		Local $AV_ENCRYPTBOX[256][2]
		Local $I_ENCRYPTCOUNTA
		Local $I_ENCRYPTCOUNTB
		Local $I_ENCRYPTCOUNTC
		Local $I_ENCRYPTCOUNTD
		Local $I_ENCRYPTCOUNTE
		Local $V_ENCRYPTCIPHER
		Local $V_ENCRYPTCIPHERBY
		If $I_ENCRYPT = 1 Then
			For $I_ENCRYPTCOUNTF = 0 To $I_ENCRYPTLEVEL Step 1
				$I_ENCRYPTCOUNTG = ""
				$I_ENCRYPTCOUNTH = ""
				$V_ENCRYPTMODIFIED = ""
				For $I_ENCRYPTCOUNTG = 1 To StringLen($S_ENCRYPTTEXT)
					If $I_ENCRYPTCOUNTH = StringLen($S_ENCRYPTPASSWORD) Then
						$I_ENCRYPTCOUNTH = 1
					Else
						$I_ENCRYPTCOUNTH += 1
					EndIf
					$V_ENCRYPTMODIFIED = $V_ENCRYPTMODIFIED & Chr(BitXOR(Asc(StringMid($S_ENCRYPTTEXT, $I_ENCRYPTCOUNTG, 1)), Asc(StringMid($S_ENCRYPTPASSWORD, $I_ENCRYPTCOUNTH, 1)), 255))
				Next
				$S_ENCRYPTTEXT = $V_ENCRYPTMODIFIED
				$I_ENCRYPTCOUNTA = ""
				$I_ENCRYPTCOUNTB = 0
				$I_ENCRYPTCOUNTC = ""
				$I_ENCRYPTCOUNTD = ""
				$I_ENCRYPTCOUNTE = ""
				$V_ENCRYPTCIPHERBY = ""
				$V_ENCRYPTCIPHER = ""
				$V_ENCRYPTSWAP = ""
				$AV_ENCRYPTBOX = ""
				Local $AV_ENCRYPTBOX[256][2]
				For $I_ENCRYPTCOUNTA = 0 To 255
					$AV_ENCRYPTBOX[$I_ENCRYPTCOUNTA][1] = Asc(StringMid($S_ENCRYPTPASSWORD, Mod($I_ENCRYPTCOUNTA, StringLen($S_ENCRYPTPASSWORD)) + 1, 1))
					$AV_ENCRYPTBOX[$I_ENCRYPTCOUNTA][0] = $I_ENCRYPTCOUNTA
				Next
				For $I_ENCRYPTCOUNTA = 0 To 255
					$I_ENCRYPTCOUNTB = Mod(($I_ENCRYPTCOUNTB + $AV_ENCRYPTBOX[$I_ENCRYPTCOUNTA][0] + $AV_ENCRYPTBOX[$I_ENCRYPTCOUNTA][1]), 256)
					$V_ENCRYPTSWAP = $AV_ENCRYPTBOX[$I_ENCRYPTCOUNTA][0]
					$AV_ENCRYPTBOX[$I_ENCRYPTCOUNTA][0] = $AV_ENCRYPTBOX[$I_ENCRYPTCOUNTB][0]
					$AV_ENCRYPTBOX[$I_ENCRYPTCOUNTB][0] = $V_ENCRYPTSWAP
				Next
				For $I_ENCRYPTCOUNTA = 1 To StringLen($S_ENCRYPTTEXT)
					$I_ENCRYPTCOUNTC = Mod(($I_ENCRYPTCOUNTC + 1), 256)
					$I_ENCRYPTCOUNTD = Mod(($I_ENCRYPTCOUNTD + $AV_ENCRYPTBOX[$I_ENCRYPTCOUNTC][0]), 256)
					$I_ENCRYPTCOUNTE = $AV_ENCRYPTBOX[Mod(($AV_ENCRYPTBOX[$I_ENCRYPTCOUNTC][0] + $AV_ENCRYPTBOX[$I_ENCRYPTCOUNTD][0]), 256)][0]
					$V_ENCRYPTCIPHERBY = BitXOR(Asc(StringMid($S_ENCRYPTTEXT, $I_ENCRYPTCOUNTA, 1)), $I_ENCRYPTCOUNTE)
					$V_ENCRYPTCIPHER &= Hex($V_ENCRYPTCIPHERBY, 2)
				Next
				$S_ENCRYPTTEXT = $V_ENCRYPTCIPHER
			Next
		Else
			For $I_ENCRYPTCOUNTF = 0 To $I_ENCRYPTLEVEL Step 1
				$I_ENCRYPTCOUNTB = 0
				$I_ENCRYPTCOUNTC = ""
				$I_ENCRYPTCOUNTD = ""
				$I_ENCRYPTCOUNTE = ""
				$V_ENCRYPTCIPHERBY = ""
				$V_ENCRYPTCIPHER = ""
				$V_ENCRYPTSWAP = ""
				$AV_ENCRYPTBOX = ""
				Local $AV_ENCRYPTBOX[256][2]
				For $I_ENCRYPTCOUNTA = 0 To 255
					$AV_ENCRYPTBOX[$I_ENCRYPTCOUNTA][1] = Asc(StringMid($S_ENCRYPTPASSWORD, Mod($I_ENCRYPTCOUNTA, StringLen($S_ENCRYPTPASSWORD)) + 1, 1))
					$AV_ENCRYPTBOX[$I_ENCRYPTCOUNTA][0] = $I_ENCRYPTCOUNTA
				Next
				For $I_ENCRYPTCOUNTA = 0 To 255
					$I_ENCRYPTCOUNTB = Mod(($I_ENCRYPTCOUNTB + $AV_ENCRYPTBOX[$I_ENCRYPTCOUNTA][0] + $AV_ENCRYPTBOX[$I_ENCRYPTCOUNTA][1]), 256)
					$V_ENCRYPTSWAP = $AV_ENCRYPTBOX[$I_ENCRYPTCOUNTA][0]
					$AV_ENCRYPTBOX[$I_ENCRYPTCOUNTA][0] = $AV_ENCRYPTBOX[$I_ENCRYPTCOUNTB][0]
					$AV_ENCRYPTBOX[$I_ENCRYPTCOUNTB][0] = $V_ENCRYPTSWAP
				Next
				For $I_ENCRYPTCOUNTA = 1 To StringLen($S_ENCRYPTTEXT) Step 2
					$I_ENCRYPTCOUNTC = Mod(($I_ENCRYPTCOUNTC + 1), 256)
					$I_ENCRYPTCOUNTD = Mod(($I_ENCRYPTCOUNTD + $AV_ENCRYPTBOX[$I_ENCRYPTCOUNTC][0]), 256)
					$I_ENCRYPTCOUNTE = $AV_ENCRYPTBOX[Mod(($AV_ENCRYPTBOX[$I_ENCRYPTCOUNTC][0] + $AV_ENCRYPTBOX[$I_ENCRYPTCOUNTD][0]), 256)][0]
					$V_ENCRYPTCIPHERBY = BitXOR(Dec(StringMid($S_ENCRYPTTEXT, $I_ENCRYPTCOUNTA, 2)), $I_ENCRYPTCOUNTE)
					$V_ENCRYPTCIPHER = $V_ENCRYPTCIPHER & Chr($V_ENCRYPTCIPHERBY)
				Next
				$S_ENCRYPTTEXT = $V_ENCRYPTCIPHER
				$I_ENCRYPTCOUNTG = ""
				$I_ENCRYPTCOUNTH = ""
				$V_ENCRYPTMODIFIED = ""
				For $I_ENCRYPTCOUNTG = 1 To StringLen($S_ENCRYPTTEXT)
					If $I_ENCRYPTCOUNTH = StringLen($S_ENCRYPTPASSWORD) Then
						$I_ENCRYPTCOUNTH = 1
					Else
						$I_ENCRYPTCOUNTH += 1
					EndIf
					$V_ENCRYPTMODIFIED &= Chr(BitXOR(Asc(StringMid($S_ENCRYPTTEXT, $I_ENCRYPTCOUNTG, 1)), Asc(StringMid($S_ENCRYPTPASSWORD, $I_ENCRYPTCOUNTH, 1)), 255))
				Next
				$S_ENCRYPTTEXT = $V_ENCRYPTMODIFIED
			Next
		EndIf
		Return $S_ENCRYPTTEXT
	EndIf
EndFunc
Func _STRINGEXPLODE($SSTRING, $SDELIMITER, $ILIMIT = 0)
	If $ILIMIT > 0 Then
		$SSTRING = StringReplace($SSTRING, $SDELIMITER, Chr(0), $ILIMIT)
		$SDELIMITER = Chr(0)
	ElseIf $ILIMIT < 0 Then
		Local $IINDEX = StringInStr($SSTRING, $SDELIMITER, 0, $ILIMIT)
		If $IINDEX Then
			$SSTRING = StringLeft($SSTRING, $IINDEX - 1)
		EndIf
	EndIf
	Return StringSplit($SSTRING, $SDELIMITER, 3)
EndFunc
Func _STRINGINSERT($S_STRING, $S_INSERTSTRING, $I_POSITION)
	Local $I_LENGTH, $S_START, $S_END
	If $S_STRING = "" OR (Not IsString($S_STRING)) Then
		Return SetError(1, 0, $S_STRING)
	ElseIf $S_INSERTSTRING = "" OR (Not IsString($S_STRING)) Then
		Return SetError(2, 0, $S_STRING)
	Else
		$I_LENGTH = StringLen($S_STRING)
		IF (Abs($I_POSITION) > $I_LENGTH) OR (Not IsInt($I_POSITION)) Then
			Return SetError(3, 0, $S_STRING)
		EndIf
	EndIf
	If $I_POSITION = 0 Then
		Return $S_INSERTSTRING & $S_STRING
	ElseIf $I_POSITION > 0 Then
		$S_START = StringLeft($S_STRING, $I_POSITION)
		$S_END = StringRight($S_STRING, $I_LENGTH - $I_POSITION)
		Return $S_START & $S_INSERTSTRING & $S_END
	ElseIf $I_POSITION < 0 Then
		$S_START = StringLeft($S_STRING, Abs($I_LENGTH + $I_POSITION))
		$S_END = StringRight($S_STRING, Abs($I_POSITION))
		Return $S_START & $S_INSERTSTRING & $S_END
	EndIf
EndFunc
Func _STRINGPROPER($S_STRING)
	Local $IX = 0
	Local $CAPNEXT = 1
	Local $S_NSTR = ""
	Local $S_CURCHAR
	For $IX = 1 To StringLen($S_STRING)
		$S_CURCHAR = StringMid($S_STRING, $IX, 1)
		Select
			Case $CAPNEXT = 1
				If StringRegExp($S_CURCHAR, "[a-zA-Zﾀ-囿棔]") Then
					$S_CURCHAR = StringUpper($S_CURCHAR)
					$CAPNEXT = 0
				EndIf
			Case Not StringRegExp($S_CURCHAR, "[a-zA-Zﾀ-囿棔]")
				$CAPNEXT = 1
			Case Else
				$S_CURCHAR = StringLower($S_CURCHAR)
		EndSelect
		$S_NSTR &= $S_CURCHAR
	Next
	Return $S_NSTR
EndFunc
Func _STRINGREPEAT($SSTRING, $IREPEATCOUNT)
	Local $SRESULT
	Select
		Case Not StringIsInt($IREPEATCOUNT)
			SetError(1)
			Return ""
		Case StringLen($SSTRING) < 1
			SetError(1)
			Return ""
		Case $IREPEATCOUNT <= 0
			SetError(1)
			Return ""
		Case Else
			For $ICOUNT = 1 To $IREPEATCOUNT
				$SRESULT &= $SSTRING
			Next
			Return $SRESULT
	EndSelect
EndFunc
Func _STRINGREVERSE($S_STRING)
	Local $I_LEN = StringLen($S_STRING)
	If $I_LEN < 1 Then Return SetError(1, 0, "")
	Local $T_CHARS = DllStructCreate("char[" & $I_LEN + 1 & "]")
	DllStructSetData($T_CHARS, 1, $S_STRING)
	Local $A_REV = DllCall("msvcrt.dll", "ptr:cdecl", "_strrev", "ptr", DllStructGetPtr($T_CHARS))
	If @error Or $A_REV[0] = 0 Then Return SetError(2, 0, "")
	Return DllStructGetData($T_CHARS, 1)
EndFunc
Func _STRINGTOHEX($STRCHAR)
	Return Hex(StringToBinary($STRCHAR))
EndFunc
Func _ARRAYADD(ByRef $AVARRAY, $VVALUE)
	If Not IsArray($AVARRAY) Then Return SetError(1, 0, -1)
	If UBound($AVARRAY, 0) <> 1 Then Return SetError(2, 0, -1)
	Local $IUBOUND = UBound($AVARRAY)
	ReDim $AVARRAY[$IUBOUND + 1]
	$AVARRAY[$IUBOUND] = $VVALUE
	Return $IUBOUND
EndFunc
Func _ARRAYBINARYSEARCH(Const ByRef $AVARRAY, $VVALUE, $ISTART = 0, $IEND = 0)
	If Not IsArray($AVARRAY) Then Return SetError(1, 0, -1)
	If UBound($AVARRAY, 0) <> 1 Then Return SetError(5, 0, -1)
	Local $IUBOUND = UBound($AVARRAY) - 1
	If $IEND < 1 Or $IEND > $IUBOUND Then $IEND = $IUBOUND
	If $ISTART < 0 Then $ISTART = 0
	If $ISTART > $IEND Then Return SetError(4, 0, -1)
	Local $IMID = Int(($IEND + $ISTART) / 2)
	If $AVARRAY[$ISTART] > $VVALUE Or $AVARRAY[$IEND] < $VVALUE Then Return SetError(2, 0, -1)
	While $ISTART <= $IMID And $VVALUE <> $AVARRAY[$IMID]
		If $VVALUE < $AVARRAY[$IMID] Then
			$IEND = $IMID - 1
		Else
			$ISTART = $IMID + 1
		EndIf
		$IMID = Int(($IEND + $ISTART) / 2)
	WEnd
	If $ISTART > $IEND Then Return SetError(3, 0, -1)
	Return $IMID
EndFunc
Func _ARRAYCOMBINATIONS(ByRef $AVARRAY, $ISET, $SDELIM = "")
	If Not IsArray($AVARRAY) Then Return SetError(1, 0, 0)
	If UBound($AVARRAY, 0) <> 1 Then Return SetError(2, 0, 0)
	Local $IN = UBound($AVARRAY)
	Local $IR = $ISET
	Local $AIDX[$IR]
	For $I = 0 To $IR - 1
		$AIDX[$I] = $I
	Next
	Local $ITOTAL = __ARRAY_COMBINATIONS($IN, $IR)
	Local $ILEFT = $ITOTAL
	Local $ARESULT[$ITOTAL + 1]
	$ARESULT[0] = $ITOTAL
	Local $ICOUNT = 1
	While $ILEFT > 0
		__ARRAY_GETNEXT($IN, $IR, $ILEFT, $ITOTAL, $AIDX)
		For $I = 0 To $ISET - 1
			$ARESULT[$ICOUNT] &= $AVARRAY[$AIDX[$I]] & $SDELIM
		Next
		If $SDELIM <> "" Then $ARESULT[$ICOUNT] = StringTrimRight($ARESULT[$ICOUNT], 1)
		$ICOUNT += 1
	WEnd
	Return $ARESULT
EndFunc
Func _ARRAYCONCATENATE(ByRef $AVARRAYTARGET, Const ByRef $AVARRAYSOURCE, $ISTART = 0)
	If Not IsArray($AVARRAYTARGET) Then Return SetError(1, 0, 0)
	If Not IsArray($AVARRAYSOURCE) Then Return SetError(2, 0, 0)
	If UBound($AVARRAYTARGET, 0) <> 1 Then
		If UBound($AVARRAYSOURCE, 0) <> 1 Then Return SetError(5, 0, 0)
		Return SetError(3, 0, 0)
	EndIf
	If UBound($AVARRAYSOURCE, 0) <> 1 Then Return SetError(4, 0, 0)
	Local $IUBOUNDTARGET = UBound($AVARRAYTARGET) - $ISTART, $IUBOUNDSOURCE = UBound($AVARRAYSOURCE)
	ReDim $AVARRAYTARGET[$IUBOUNDTARGET + $IUBOUNDSOURCE]
	For $I = $ISTART To $IUBOUNDSOURCE - 1
		$AVARRAYTARGET[$IUBOUNDTARGET + $I] = $AVARRAYSOURCE[$I]
	Next
	Return $IUBOUNDTARGET + $IUBOUNDSOURCE
EndFunc
Func _ARRAYCREATE($V_0, $V_1 = 0, $V_2 = 0, $V_3 = 0, $V_4 = 0, $V_5 = 0, $V_6 = 0, $V_7 = 0, $V_8 = 0, $V_9 = 0, $V_10 = 0, $V_11 = 0, $V_12 = 0, $V_13 = 0, $V_14 = 0, $V_15 = 0, $V_16 = 0, $V_17 = 0, $V_18 = 0, $V_19 = 0, $V_20 = 0)
	Local $AV_ARRAY[21] = [$V_0, $V_1, $V_2, $V_3, $V_4, $V_5, $V_6, $V_7, $V_8, $V_9, $V_10, $V_11, $V_12, $V_13, $V_14, $V_15, $V_16, $V_17, $V_18, $V_19, $V_20]
	ReDim $AV_ARRAY[@NumParams]
	Return $AV_ARRAY
EndFunc
Func _ARRAYDELETE(ByRef $AVARRAY, $IELEMENT)
	If Not IsArray($AVARRAY) Then Return SetError(1, 0, 0)
	Local $IUBOUND = UBound($AVARRAY, 1) - 1
	If Not $IUBOUND Then
		$AVARRAY = ""
		Return 0
	EndIf
	If $IELEMENT < 0 Then $IELEMENT = 0
	If $IELEMENT > $IUBOUND Then $IELEMENT = $IUBOUND
	Switch UBound($AVARRAY, 0)
		Case 1
			For $I = $IELEMENT To $IUBOUND - 1
				$AVARRAY[$I] = $AVARRAY[$I + 1]
			Next
			ReDim $AVARRAY[$IUBOUND]
		Case 2
			Local $ISUBMAX = UBound($AVARRAY, 2) - 1
			For $I = $IELEMENT To $IUBOUND - 1
				For $J = 0 To $ISUBMAX
					$AVARRAY[$I][$J] = $AVARRAY[$I + 1][$J]
				Next
			Next
			ReDim $AVARRAY[$IUBOUND][$ISUBMAX + 1]
		Case Else
			Return SetError(3, 0, 0)
	EndSwitch
	Return $IUBOUND
EndFunc
Func _ARRAYDISPLAY(Const ByRef $AVARRAY, $STITLE = "Array: ListView Display", $IITEMLIMIT = -1, $ITRANSPOSE = 0, $SSEPARATOR = "", $SREPLACE = "|", $SHEADER = "")
	If Not IsArray($AVARRAY) Then Return SetError(1, 0, 0)
	Local $IDIMENSION = UBound($AVARRAY, 0), $IUBOUND = UBound($AVARRAY, 1) - 1, $ISUBMAX = UBound($AVARRAY, 2) - 1
	If $IDIMENSION > 2 Then Return SetError(2, 0, 0)
	If $SSEPARATOR = "" Then $SSEPARATOR = Chr(124)
	If _ARRAYSEARCH($AVARRAY, $SSEPARATOR, 0, 0, 0, 1) <> -1 Then
		For $X = 1 To 255
			If $X >= 32 And $X <= 127 Then ContinueLoop
			Local $SFIND = _ARRAYSEARCH($AVARRAY, Chr($X), 0, 0, 0, 1)
			If $SFIND = -1 Then
				$SSEPARATOR = Chr($X)
				ExitLoop
			EndIf
		Next
	EndIf
	Local $VTMP, $IBUFFER = 64
	Local $ICOLLIMIT = 250
	Local $IONEVENTMODE = Opt("GUIOnEventMode", 0), $SDATASEPARATORCHAR = Opt("GUIDataSeparatorChar", $SSEPARATOR)
	If $ISUBMAX < 0 Then $ISUBMAX = 0
	If $ITRANSPOSE Then
		$VTMP = $IUBOUND
		$IUBOUND = $ISUBMAX
		$ISUBMAX = $VTMP
	EndIf
	If $ISUBMAX > $ICOLLIMIT Then $ISUBMAX = $ICOLLIMIT
	If $IITEMLIMIT < 1 Then $IITEMLIMIT = $IUBOUND
	If $IUBOUND > $IITEMLIMIT Then $IUBOUND = $IITEMLIMIT
	If $SHEADER = "" Then
		$SHEADER = "Row  "
		For $I = 0 To $ISUBMAX
			$SHEADER &= $SSEPARATOR & "Col " & $I
		Next
	EndIf
	Local $AVARRAYTEXT[$IUBOUND + 1]
	For $I = 0 To $IUBOUND
		$AVARRAYTEXT[$I] = "[" & $I & "]"
		For $J = 0 To $ISUBMAX
			If $IDIMENSION = 1 Then
				If $ITRANSPOSE Then
					$VTMP = $AVARRAY[$J]
				Else
					$VTMP = $AVARRAY[$I]
				EndIf
			Else
				If $ITRANSPOSE Then
					$VTMP = $AVARRAY[$J][$I]
				Else
					$VTMP = $AVARRAY[$I][$J]
				EndIf
			EndIf
			$VTMP = StringReplace($VTMP, $SSEPARATOR, $SREPLACE, 0, 1)
			$AVARRAYTEXT[$I] &= $SSEPARATOR & $VTMP
			$VTMP = StringLen($VTMP)
			If $VTMP > $IBUFFER Then $IBUFFER = $VTMP
		Next
	Next
	$IBUFFER += 1
	Local Const $_ARRAYCONSTANT_GUI_DOCKBORDERS = 102
	Local Const $_ARRAYCONSTANT_GUI_DOCKBOTTOM = 64
	Local Const $_ARRAYCONSTANT_GUI_DOCKHEIGHT = 512
	Local Const $_ARRAYCONSTANT_GUI_DOCKLEFT = 2
	Local Const $_ARRAYCONSTANT_GUI_DOCKRIGHT = 4
	Local Const $_ARRAYCONSTANT_GUI_EVENT_CLOSE = -3
	Local Const $_ARRAYCONSTANT_LVIF_PARAM = 4
	Local Const $_ARRAYCONSTANT_LVIF_TEXT = 1
	Local Const $_ARRAYCONSTANT_LVM_GETCOLUMNWIDTH = (4096 + 29)
	Local Const $_ARRAYCONSTANT_LVM_GETITEMCOUNT = (4096 + 4)
	Local Const $_ARRAYCONSTANT_LVM_GETITEMSTATE = (4096 + 44)
	Local Const $_ARRAYCONSTANT_LVM_INSERTITEMW = (4096 + 77)
	Local Const $_ARRAYCONSTANT_LVM_SETEXTENDEDLISTVIEWSTYLE = (4096 + 54)
	Local Const $_ARRAYCONSTANT_LVM_SETITEMW = (4096 + 76)
	Local Const $_ARRAYCONSTANT_LVS_EX_FULLROWSELECT = 32
	Local Const $_ARRAYCONSTANT_LVS_EX_GRIDLINES = 1
	Local Const $_ARRAYCONSTANT_LVS_SHOWSELALWAYS = 8
	Local Const $_ARRAYCONSTANT_WS_EX_CLIENTEDGE = 512
	Local Const $_ARRAYCONSTANT_WS_MAXIMIZEBOX = 65536
	Local Const $_ARRAYCONSTANT_WS_MINIMIZEBOX = 131072
	Local Const $_ARRAYCONSTANT_WS_SIZEBOX = 262144
	Local Const $_ARRAYCONSTANT_TAGLVITEM = "int Mask;int Item;int SubItem;int State;int StateMask;ptr Text;int TextMax;int Image;int Param;int Indent;int GroupID;int Columns;ptr pColumns"
	Local $IADDMASK = BitOR($_ARRAYCONSTANT_LVIF_TEXT, $_ARRAYCONSTANT_LVIF_PARAM)
	Local $TBUFFER = DllStructCreate("wchar Text[" & $IBUFFER & "]"), $PBUFFER = DllStructGetPtr($TBUFFER)
	Local $TITEM = DllStructCreate($_ARRAYCONSTANT_TAGLVITEM), $PITEM = DllStructGetPtr($TITEM)
	DllStructSetData($TITEM, "Param", 0)
	DllStructSetData($TITEM, "Text", $PBUFFER)
	DllStructSetData($TITEM, "TextMax", $IBUFFER)
	Local $IWIDTH = 640, $IHEIGHT = 480
	Local $HGUI = GUICreate($STITLE, $IWIDTH, $IHEIGHT, Default, Default, BitOR($_ARRAYCONSTANT_WS_SIZEBOX, $_ARRAYCONSTANT_WS_MINIMIZEBOX, $_ARRAYCONSTANT_WS_MAXIMIZEBOX))
	Local $AIGUISIZE = WinGetClientSize($HGUI)
	Local $HLISTVIEW = GUICtrlCreateListView($SHEADER, 0, 0, $AIGUISIZE[0], $AIGUISIZE[1] - 26, $_ARRAYCONSTANT_LVS_SHOWSELALWAYS)
	Local $HCOPY = GUICtrlCreateButton("Copy Selected", 3, $AIGUISIZE[1] - 23, $AIGUISIZE[0] - 6, 20)
	GUICtrlSetResizing($HLISTVIEW, $_ARRAYCONSTANT_GUI_DOCKBORDERS)
	GUICtrlSetResizing($HCOPY, $_ARRAYCONSTANT_GUI_DOCKLEFT + $_ARRAYCONSTANT_GUI_DOCKRIGHT + $_ARRAYCONSTANT_GUI_DOCKBOTTOM + $_ARRAYCONSTANT_GUI_DOCKHEIGHT)
	GUICtrlSendMsg($HLISTVIEW, $_ARRAYCONSTANT_LVM_SETEXTENDEDLISTVIEWSTYLE, $_ARRAYCONSTANT_LVS_EX_GRIDLINES, $_ARRAYCONSTANT_LVS_EX_GRIDLINES)
	GUICtrlSendMsg($HLISTVIEW, $_ARRAYCONSTANT_LVM_SETEXTENDEDLISTVIEWSTYLE, $_ARRAYCONSTANT_LVS_EX_FULLROWSELECT, $_ARRAYCONSTANT_LVS_EX_FULLROWSELECT)
	GUICtrlSendMsg($HLISTVIEW, $_ARRAYCONSTANT_LVM_SETEXTENDEDLISTVIEWSTYLE, $_ARRAYCONSTANT_WS_EX_CLIENTEDGE, $_ARRAYCONSTANT_WS_EX_CLIENTEDGE)
	Local $AITEM
	For $I = 0 To $IUBOUND
		If GUICtrlCreateListViewItem($AVARRAYTEXT[$I], $HLISTVIEW) = 0 Then
			$AITEM = StringSplit($AVARRAYTEXT[$I], $SSEPARATOR)
			DllStructSetData($TBUFFER, "Text", $AITEM[1])
			DllStructSetData($TITEM, "Item", $I)
			DllStructSetData($TITEM, "SubItem", 0)
			DllStructSetData($TITEM, "Mask", $IADDMASK)
			GUICtrlSendMsg($HLISTVIEW, $_ARRAYCONSTANT_LVM_INSERTITEMW, 0, $PITEM)
			DllStructSetData($TITEM, "Mask", $_ARRAYCONSTANT_LVIF_TEXT)
			For $J = 2 To $AITEM[0]
				DllStructSetData($TBUFFER, "Text", $AITEM[$J])
				DllStructSetData($TITEM, "SubItem", $J - 1)
				GUICtrlSendMsg($HLISTVIEW, $_ARRAYCONSTANT_LVM_SETITEMW, 0, $PITEM)
			Next
		EndIf
	Next
	$IWIDTH = 0
	For $I = 0 To $ISUBMAX + 1
		$IWIDTH += GUICtrlSendMsg($HLISTVIEW, $_ARRAYCONSTANT_LVM_GETCOLUMNWIDTH, $I, 0)
	Next
	If $IWIDTH < 250 Then $IWIDTH = 230
	$IWIDTH += 20
	If $IWIDTH > @DesktopWidth Then $IWIDTH = @DesktopWidth - 100
	WinMove($HGUI, "", (@DesktopWidth - $IWIDTH) / 2, Default, $IWIDTH)
	GUISetState(@SW_SHOW, $HGUI)
	While 1
		Switch GUIGetMsg()
			Case $_ARRAYCONSTANT_GUI_EVENT_CLOSE
				ExitLoop
			Case $HCOPY
				Local $SCLIP = ""
				Local $AICURITEMS[1] = [0]
				For $I = 0 To GUICtrlSendMsg($HLISTVIEW, $_ARRAYCONSTANT_LVM_GETITEMCOUNT, 0, 0)
					If GUICtrlSendMsg($HLISTVIEW, $_ARRAYCONSTANT_LVM_GETITEMSTATE, $I, 2) Then
						$AICURITEMS[0] += 1
						ReDim $AICURITEMS[$AICURITEMS[0] + 1]
						$AICURITEMS[$AICURITEMS[0]] = $I
					EndIf
				Next
				If Not $AICURITEMS[0] Then
					For $SITEM In $AVARRAYTEXT
						$SCLIP &= $SITEM & @CRLF
					Next
				Else
					For $I = 1 To UBound($AICURITEMS) - 1
						$SCLIP &= $AVARRAYTEXT[$AICURITEMS[$I]] & @CRLF
					Next
				EndIf
				ClipPut($SCLIP)
		EndSwitch
	WEnd
	GUIDelete($HGUI)
	Opt("GUIOnEventMode", $IONEVENTMODE)
	Opt("GUIDataSeparatorChar", $SDATASEPARATORCHAR)
	Return 1
EndFunc
Func _ARRAYFINDALL(Const ByRef $AVARRAY, $VVALUE, $ISTART = 0, $IEND = 0, $ICASE = 0, $IPARTIAL = 0, $ISUBITEM = 0)
	$ISTART = _ARRAYSEARCH($AVARRAY, $VVALUE, $ISTART, $IEND, $ICASE, $IPARTIAL, 1, $ISUBITEM)
	If @error Then Return SetError(@error, 0, -1)
	Local $IINDEX = 0, $AVRESULT[UBound($AVARRAY)]
	Do
		$AVRESULT[$IINDEX] = $ISTART
		$IINDEX += 1
		$ISTART = _ARRAYSEARCH($AVARRAY, $VVALUE, $ISTART + 1, $IEND, $ICASE, $IPARTIAL, 1, $ISUBITEM)
	Until @error
	ReDim $AVRESULT[$IINDEX]
	Return $AVRESULT
EndFunc
Func _ARRAYINSERT(ByRef $AVARRAY, $IELEMENT, $VVALUE = "")
	If Not IsArray($AVARRAY) Then Return SetError(1, 0, 0)
	If UBound($AVARRAY, 0) <> 1 Then Return SetError(2, 0, 0)
	Local $IUBOUND = UBound($AVARRAY) + 1
	ReDim $AVARRAY[$IUBOUND]
	For $I = $IUBOUND - 1 To $IELEMENT + 1 Step -1
		$AVARRAY[$I] = $AVARRAY[$I - 1]
	Next
	$AVARRAY[$IELEMENT] = $VVALUE
	Return $IUBOUND
EndFunc
Func _ARRAYMAX(Const ByRef $AVARRAY, $ICOMPNUMERIC = 0, $ISTART = 0, $IEND = 0)
	Local $IRESULT = _ARRAYMAXINDEX($AVARRAY, $ICOMPNUMERIC, $ISTART, $IEND)
	If @error Then Return SetError(@error, 0, "")
	Return $AVARRAY[$IRESULT]
EndFunc
Func _ARRAYMAXINDEX(Const ByRef $AVARRAY, $ICOMPNUMERIC = 0, $ISTART = 0, $IEND = 0)
	If Not IsArray($AVARRAY) Or UBound($AVARRAY, 0) <> 1 Then Return SetError(1, 0, -1)
	If UBound($AVARRAY, 0) <> 1 Then Return SetError(3, 0, -1)
	Local $IUBOUND = UBound($AVARRAY) - 1
	If $IEND < 1 Or $IEND > $IUBOUND Then $IEND = $IUBOUND
	If $ISTART < 0 Then $ISTART = 0
	If $ISTART > $IEND Then Return SetError(2, 0, -1)
	Local $IMAXINDEX = $ISTART
	If $ICOMPNUMERIC Then
		For $I = $ISTART To $IEND
			If Number($AVARRAY[$IMAXINDEX]) < Number($AVARRAY[$I]) Then $IMAXINDEX = $I
		Next
	Else
		For $I = $ISTART To $IEND
			If $AVARRAY[$IMAXINDEX] < $AVARRAY[$I] Then $IMAXINDEX = $I
		Next
	EndIf
	Return $IMAXINDEX
EndFunc
Func _ARRAYMIN(Const ByRef $AVARRAY, $ICOMPNUMERIC = 0, $ISTART = 0, $IEND = 0)
	Local $IRESULT = _ARRAYMININDEX($AVARRAY, $ICOMPNUMERIC, $ISTART, $IEND)
	If @error Then Return SetError(@error, 0, "")
	Return $AVARRAY[$IRESULT]
EndFunc
Func _ARRAYMININDEX(Const ByRef $AVARRAY, $ICOMPNUMERIC = 0, $ISTART = 0, $IEND = 0)
	If Not IsArray($AVARRAY) Then Return SetError(1, 0, -1)
	If UBound($AVARRAY, 0) <> 1 Then Return SetError(3, 0, -1)
	Local $IUBOUND = UBound($AVARRAY) - 1
	If $IEND < 1 Or $IEND > $IUBOUND Then $IEND = $IUBOUND
	If $ISTART < 0 Then $ISTART = 0
	If $ISTART > $IEND Then Return SetError(2, 0, -1)
	Local $IMININDEX = $ISTART
	If $ICOMPNUMERIC Then
		For $I = $ISTART To $IEND
			If Number($AVARRAY[$IMININDEX]) > Number($AVARRAY[$I]) Then $IMININDEX = $I
		Next
	Else
		For $I = $ISTART To $IEND
			If $AVARRAY[$IMININDEX] > $AVARRAY[$I] Then $IMININDEX = $I
		Next
	EndIf
	Return $IMININDEX
EndFunc
Func _ARRAYPERMUTE(ByRef $AVARRAY, $SDELIM = "")
	If Not IsArray($AVARRAY) Then Return SetError(1, 0, 0)
	If UBound($AVARRAY, 0) <> 1 Then Return SetError(2, 0, 0)
	Local $ISIZE = UBound($AVARRAY), $IFACTORIAL = 1, $AIDX[$ISIZE], $ARESULT[1], $ICOUNT = 1
	For $I = 0 To $ISIZE - 1
		$AIDX[$I] = $I
	Next
	For $I = $ISIZE To 1 Step -1
		$IFACTORIAL *= $I
	Next
	ReDim $ARESULT[$IFACTORIAL + 1]
	$ARESULT[0] = $IFACTORIAL
	__ARRAY_EXETERINTERNAL($AVARRAY, 0, $ISIZE, $SDELIM, $AIDX, $ARESULT, $ICOUNT)
	Return $ARESULT
EndFunc
Func _ARRAYPOP(ByRef $AVARRAY)
	IF (Not IsArray($AVARRAY)) Then Return SetError(1, 0, "")
	If UBound($AVARRAY, 0) <> 1 Then Return SetError(2, 0, "")
	Local $IUBOUND = UBound($AVARRAY) - 1, $SLASTVAL = $AVARRAY[$IUBOUND]
	If Not $IUBOUND Then
		$AVARRAY = ""
	Else
		ReDim $AVARRAY[$IUBOUND]
	EndIf
	Return $SLASTVAL
EndFunc
Func _ARRAYPUSH(ByRef $AVARRAY, $VVALUE, $IDIRECTION = 0)
	IF (Not IsArray($AVARRAY)) Then Return SetError(1, 0, 0)
	If UBound($AVARRAY, 0) <> 1 Then Return SetError(3, 0, 0)
	Local $IUBOUND = UBound($AVARRAY) - 1
	If IsArray($VVALUE) Then
		Local $IUBOUNDS = UBound($VVALUE)
		IF ($IUBOUNDS - 1) > $IUBOUND Then Return SetError(2, 0, 0)
		If $IDIRECTION Then
			For $I = $IUBOUND To $IUBOUNDS Step -1
				$AVARRAY[$I] = $AVARRAY[$I - $IUBOUNDS]
			Next
			For $I = 0 To $IUBOUNDS - 1
				$AVARRAY[$I] = $VVALUE[$I]
			Next
		Else
			For $I = 0 To $IUBOUND - $IUBOUNDS
				$AVARRAY[$I] = $AVARRAY[$I + $IUBOUNDS]
			Next
			For $I = 0 To $IUBOUNDS - 1
				$AVARRAY[$I + $IUBOUND - $IUBOUNDS + 1] = $VVALUE[$I]
			Next
		EndIf
	Else
		If $IDIRECTION Then
			For $I = $IUBOUND To 1 Step -1
				$AVARRAY[$I] = $AVARRAY[$I - 1]
			Next
			$AVARRAY[0] = $VVALUE
		Else
			For $I = 0 To $IUBOUND - 1
				$AVARRAY[$I] = $AVARRAY[$I + 1]
			Next
			$AVARRAY[$IUBOUND] = $VVALUE
		EndIf
	EndIf
	Return 1
EndFunc
Func _ARRAYREVERSE(ByRef $AVARRAY, $ISTART = 0, $IEND = 0)
	If Not IsArray($AVARRAY) Then Return SetError(1, 0, 0)
	If UBound($AVARRAY, 0) <> 1 Then Return SetError(3, 0, 0)
	Local $VTMP, $IUBOUND = UBound($AVARRAY) - 1
	If $IEND < 1 Or $IEND > $IUBOUND Then $IEND = $IUBOUND
	If $ISTART < 0 Then $ISTART = 0
	If $ISTART > $IEND Then Return SetError(2, 0, 0)
	For $I = $ISTART To Int(($ISTART + $IEND - 1) / 2)
		$VTMP = $AVARRAY[$I]
		$AVARRAY[$I] = $AVARRAY[$IEND]
		$AVARRAY[$IEND] = $VTMP
		$IEND -= 1
	Next
	Return 1
EndFunc
Func _ARRAYSEARCH(Const ByRef $AVARRAY, $VVALUE, $ISTART = 0, $IEND = 0, $ICASE = 0, $IPARTIAL = 0, $IFORWARD = 1, $ISUBITEM = -1)
	If Not IsArray($AVARRAY) Then Return SetError(1, 0, -1)
	If UBound($AVARRAY, 0) > 2 Or UBound($AVARRAY, 0) < 1 Then Return SetError(2, 0, -1)
	Local $IUBOUND = UBound($AVARRAY) - 1
	If $IEND < 1 Or $IEND > $IUBOUND Then $IEND = $IUBOUND
	If $ISTART < 0 Then $ISTART = 0
	If $ISTART > $IEND Then Return SetError(4, 0, -1)
	Local $ISTEP = 1
	If Not $IFORWARD Then
		Local $ITMP = $ISTART
		$ISTART = $IEND
		$IEND = $ITMP
		$ISTEP = -1
	EndIf
	Switch UBound($AVARRAY, 0)
		Case 1
			If Not $IPARTIAL Then
				If Not $ICASE Then
					For $I = $ISTART To $IEND Step $ISTEP
						If $AVARRAY[$I] = $VVALUE Then Return $I
					Next
				Else
					For $I = $ISTART To $IEND Step $ISTEP
						If $AVARRAY[$I] == $VVALUE Then Return $I
					Next
				EndIf
			Else
				For $I = $ISTART To $IEND Step $ISTEP
					If StringInStr($AVARRAY[$I], $VVALUE, $ICASE) > 0 Then Return $I
				Next
			EndIf
		Case 2
			Local $IUBOUNDSUB = UBound($AVARRAY, 2) - 1
			If $ISUBITEM > $IUBOUNDSUB Then $ISUBITEM = $IUBOUNDSUB
			If $ISUBITEM < 0 Then
				$ISUBITEM = 0
			Else
				$IUBOUNDSUB = $ISUBITEM
			EndIf
			For $J = $ISUBITEM To $IUBOUNDSUB
				If Not $IPARTIAL Then
					If Not $ICASE Then
						For $I = $ISTART To $IEND Step $ISTEP
							If $AVARRAY[$I][$J] = $VVALUE Then Return $I
						Next
					Else
						For $I = $ISTART To $IEND Step $ISTEP
							If $AVARRAY[$I][$J] == $VVALUE Then Return $I
						Next
					EndIf
				Else
					For $I = $ISTART To $IEND Step $ISTEP
						If StringInStr($AVARRAY[$I][$J], $VVALUE, $ICASE) > 0 Then Return $I
					Next
				EndIf
			Next
		Case Else
			Return SetError(7, 0, -1)
	EndSwitch
	Return SetError(6, 0, -1)
EndFunc
Func _ARRAYSORT(ByRef $AVARRAY, $IDESCENDING = 0, $ISTART = 0, $IEND = 0, $ISUBITEM = 0)
	If Not IsArray($AVARRAY) Then Return SetError(1, 0, 0)
	Local $IUBOUND = UBound($AVARRAY) - 1
	If $IEND < 1 Or $IEND > $IUBOUND Then $IEND = $IUBOUND
	If $ISTART < 0 Then $ISTART = 0
	If $ISTART > $IEND Then Return SetError(2, 0, 0)
	Switch UBound($AVARRAY, 0)
		Case 1
			__ARRAYQUICKSORT1D($AVARRAY, $ISTART, $IEND)
			If $IDESCENDING Then _ARRAYREVERSE($AVARRAY, $ISTART, $IEND)
		Case 2
			Local $ISUBMAX = UBound($AVARRAY, 2) - 1
			If $ISUBITEM > $ISUBMAX Then Return SetError(3, 0, 0)
			If $IDESCENDING Then
				$IDESCENDING = -1
			Else
				$IDESCENDING = 1
			EndIf
			__ARRAYQUICKSORT2D($AVARRAY, $IDESCENDING, $ISTART, $IEND, $ISUBITEM, $ISUBMAX)
		Case Else
			Return SetError(4, 0, 0)
	EndSwitch
	Return 1
EndFunc
Func __ARRAYQUICKSORT1D(ByRef $AVARRAY, ByRef $ISTART, ByRef $IEND)
	If $IEND <= $ISTART Then Return
	Local $VTMP
	IF ($IEND - $ISTART) < 15 Then
		Local $VCUR
		For $I = $ISTART + 1 To $IEND
			$VTMP = $AVARRAY[$I]
			If IsNumber($VTMP) Then
				For $J = $I - 1 To $ISTART Step -1
					$VCUR = $AVARRAY[$J]
					IF ($VTMP >= $VCUR And IsNumber($VCUR)) OR (Not IsNumber($VCUR) And StringCompare($VTMP, $VCUR) >= 0) Then ExitLoop
					$AVARRAY[$J + 1] = $VCUR
				Next
			Else
				For $J = $I - 1 To $ISTART Step -1
					IF (StringCompare($VTMP, $AVARRAY[$J]) >= 0) Then ExitLoop
					$AVARRAY[$J + 1] = $AVARRAY[$J]
				Next
			EndIf
			$AVARRAY[$J + 1] = $VTMP
		Next
		Return
	EndIf
	Local $L = $ISTART, $R = $IEND, $VPIVOT = $AVARRAY[Int(($ISTART + $IEND) / 2)], $FNUM = IsNumber($VPIVOT)
	Do
		If $FNUM Then
			WHILE ($AVARRAY[$L] < $VPIVOT And IsNumber($AVARRAY[$L])) OR (Not IsNumber($AVARRAY[$L]) And StringCompare($AVARRAY[$L], $VPIVOT) < 0)
				$L += 1
			WEnd
			WHILE ($AVARRAY[$R] > $VPIVOT And IsNumber($AVARRAY[$R])) OR (Not IsNumber($AVARRAY[$R]) And StringCompare($AVARRAY[$R], $VPIVOT) > 0)
				$R -= 1
			WEnd
		Else
			WHILE (StringCompare($AVARRAY[$L], $VPIVOT) < 0)
				$L += 1
			WEnd
			WHILE (StringCompare($AVARRAY[$R], $VPIVOT) > 0)
				$R -= 1
			WEnd
		EndIf
		If $L <= $R Then
			$VTMP = $AVARRAY[$L]
			$AVARRAY[$L] = $AVARRAY[$R]
			$AVARRAY[$R] = $VTMP
			$L += 1
			$R -= 1
		EndIf
	Until $L > $R
	__ARRAYQUICKSORT1D($AVARRAY, $ISTART, $R)
	__ARRAYQUICKSORT1D($AVARRAY, $L, $IEND)
EndFunc
Func __ARRAYQUICKSORT2D(ByRef $AVARRAY, ByRef $ISTEP, ByRef $ISTART, ByRef $IEND, ByRef $ISUBITEM, ByRef $ISUBMAX)
	If $IEND <= $ISTART Then Return
	Local $VTMP, $L = $ISTART, $R = $IEND, $VPIVOT = $AVARRAY[Int(($ISTART + $IEND) / 2)][$ISUBITEM], $FNUM = IsNumber($VPIVOT)
	Do
		If $FNUM Then
			WHILE ($ISTEP * ($AVARRAY[$L][$ISUBITEM] - $VPIVOT) < 0 And IsNumber($AVARRAY[$L][$ISUBITEM])) OR (Not IsNumber($AVARRAY[$L][$ISUBITEM]) And $ISTEP * StringCompare($AVARRAY[$L][$ISUBITEM], $VPIVOT) < 0)
				$L += 1
			WEnd
			WHILE ($ISTEP * ($AVARRAY[$R][$ISUBITEM] - $VPIVOT) > 0 And IsNumber($AVARRAY[$R][$ISUBITEM])) OR (Not IsNumber($AVARRAY[$R][$ISUBITEM]) And $ISTEP * StringCompare($AVARRAY[$R][$ISUBITEM], $VPIVOT) > 0)
				$R -= 1
			WEnd
		Else
			WHILE ($ISTEP * StringCompare($AVARRAY[$L][$ISUBITEM], $VPIVOT) < 0)
				$L += 1
			WEnd
			WHILE ($ISTEP * StringCompare($AVARRAY[$R][$ISUBITEM], $VPIVOT) > 0)
				$R -= 1
			WEnd
		EndIf
		If $L <= $R Then
			For $I = 0 To $ISUBMAX
				$VTMP = $AVARRAY[$L][$I]
				$AVARRAY[$L][$I] = $AVARRAY[$R][$I]
				$AVARRAY[$R][$I] = $VTMP
			Next
			$L += 1
			$R -= 1
		EndIf
	Until $L > $R
	__ARRAYQUICKSORT2D($AVARRAY, $ISTEP, $ISTART, $R, $ISUBITEM, $ISUBMAX)
	__ARRAYQUICKSORT2D($AVARRAY, $ISTEP, $L, $IEND, $ISUBITEM, $ISUBMAX)
EndFunc
Func _ARRAYSWAP(ByRef $VITEM1, ByRef $VITEM2)
	Local $VTMP = $VITEM1
	$VITEM1 = $VITEM2
	$VITEM2 = $VTMP
EndFunc
Func _ARRAYTOCLIP(Const ByRef $AVARRAY, $ISTART = 0, $IEND = 0)
	Local $SRESULT = _ARRAYTOSTRING($AVARRAY, @CR, $ISTART, $IEND)
	If @error Then Return SetError(@error, 0, 0)
	Return ClipPut($SRESULT)
EndFunc
Func _ARRAYTOSTRING(Const ByRef $AVARRAY, $SDELIM = "|", $ISTART = 0, $IEND = 0)
	If Not IsArray($AVARRAY) Then Return SetError(1, 0, "")
	If UBound($AVARRAY, 0) <> 1 Then Return SetError(3, 0, "")
	Local $SRESULT, $IUBOUND = UBound($AVARRAY) - 1
	If $IEND < 1 Or $IEND > $IUBOUND Then $IEND = $IUBOUND
	If $ISTART < 0 Then $ISTART = 0
	If $ISTART > $IEND Then Return SetError(2, 0, "")
	For $I = $ISTART To $IEND
		$SRESULT &= $AVARRAY[$I] & $SDELIM
	Next
	Return StringTrimRight($SRESULT, StringLen($SDELIM))
EndFunc
Func _ARRAYTRIM(ByRef $AVARRAY, $ITRIMNUM, $IDIRECTION = 0, $ISTART = 0, $IEND = 0)
	If Not IsArray($AVARRAY) Then Return SetError(1, 0, 0)
	If UBound($AVARRAY, 0) <> 1 Then Return SetError(2, 0, 0)
	Local $IUBOUND = UBound($AVARRAY) - 1
	If $IEND < 1 Or $IEND > $IUBOUND Then $IEND = $IUBOUND
	If $ISTART < 0 Then $ISTART = 0
	If $ISTART > $IEND Then Return SetError(5, 0, 0)
	If $IDIRECTION Then
		For $I = $ISTART To $IEND
			$AVARRAY[$I] = StringTrimRight($AVARRAY[$I], $ITRIMNUM)
		Next
	Else
		For $I = $ISTART To $IEND
			$AVARRAY[$I] = StringTrimLeft($AVARRAY[$I], $ITRIMNUM)
		Next
	EndIf
	Return 1
EndFunc
Func _ARRAYUNIQUE($AARRAY, $IDIMENSION = 1, $IBASE = 0, $ICASE = 0, $VDELIM = "|")
	Local $IUBOUNDDIM
	If $VDELIM = "|" Then $VDELIM = Chr(1)
	If Not IsArray($AARRAY) Then Return SetError(1, 0, 0)
	If Not $IDIMENSION > 0 Then
		Return SetError(3, 0, 0)
	Else
		$IUBOUNDDIM = UBound($AARRAY, 1)
		If @error Then Return SetError(3, 0, 0)
		If $IDIMENSION > 1 Then
			Local $AARRAYTMP[1]
			For $I = 0 To $IUBOUNDDIM - 1
				_ARRAYADD($AARRAYTMP, $AARRAY[$I][$IDIMENSION - 1])
			Next
			_ARRAYDELETE($AARRAYTMP, 0)
		Else
			If UBound($AARRAY, 0) = 1 Then
				Dim $AARRAYTMP[1]
				For $I = 0 To $IUBOUNDDIM - 1
					_ARRAYADD($AARRAYTMP, $AARRAY[$I])
				Next
				_ARRAYDELETE($AARRAYTMP, 0)
			Else
				Dim $AARRAYTMP[1]
				For $I = 0 To $IUBOUNDDIM - 1
					_ARRAYADD($AARRAYTMP, $AARRAY[$I][$IDIMENSION - 1])
				Next
				_ARRAYDELETE($AARRAYTMP, 0)
			EndIf
		EndIf
	EndIf
	Local $SHOLD
	For $ICC = $IBASE To UBound($AARRAYTMP) - 1
		If Not StringInStr($VDELIM & $SHOLD, $VDELIM & $AARRAYTMP[$ICC] & $VDELIM, $ICASE) Then $SHOLD &= $AARRAYTMP[$ICC] & $VDELIM
	Next
	If $SHOLD Then
		$AARRAYTMP = StringSplit(StringTrimRight($SHOLD, StringLen($VDELIM)), $VDELIM, 1)
		Return $AARRAYTMP
	EndIf
	Return SetError(2, 0, 0)
EndFunc
Func __ARRAY_EXETERINTERNAL(ByRef $AVARRAY, $ISTART, $ISIZE, $SDELIM, ByRef $AIDX, ByRef $ARESULT, ByRef $ICOUNT)
	If $ISTART == $ISIZE - 1 Then
		For $I = 0 To $ISIZE - 1
			$ARESULT[$ICOUNT] &= $AVARRAY[$AIDX[$I]] & $SDELIM
		Next
		If $SDELIM <> "" Then $ARESULT[$ICOUNT] = StringTrimRight($ARESULT[$ICOUNT], 1)
		$ICOUNT += 1
	Else
		Local $ITEMP
		For $I = $ISTART To $ISIZE - 1
			$ITEMP = $AIDX[$I]
			$AIDX[$I] = $AIDX[$ISTART]
			$AIDX[$ISTART] = $ITEMP
			__ARRAY_EXETERINTERNAL($AVARRAY, $ISTART + 1, $ISIZE, $SDELIM, $AIDX, $ARESULT, $ICOUNT)
			$AIDX[$ISTART] = $AIDX[$I]
			$AIDX[$I] = $ITEMP
		Next
	EndIf
EndFunc
Func __ARRAY_COMBINATIONS($IN, $IR)
	Local $I_TOTAL = 1
	For $I = $IR To 1 Step -1
		$I_TOTAL *= ($IN / $I)
		$IN -= 1
	Next
	Return Round($I_TOTAL)
EndFunc
Func __ARRAY_GETNEXT($IN, $IR, ByRef $ILEFT, $ITOTAL, ByRef $AIDX)
	If $ILEFT == $ITOTAL Then
		$ILEFT -= 1
		Return
	EndIf
	Local $I = $IR - 1
	While $AIDX[$I] == $IN - $IR + $I
		$I -= 1
	WEnd
	$AIDX[$I] += 1
	For $J = $I + 1 To $IR - 1
		$AIDX[$J] = $AIDX[$I] + $J - $I
	Next
	$ILEFT -= 1
EndFunc
Global Const $FW_DONTCARE = 0
Global Const $FW_THIN = 100
Global Const $FW_EXTRALIGHT = 200
Global Const $FW_ULTRALIGHT = 200
Global Const $FW_LIGHT = 300
Global Const $FW_NORMAL = 400
Global Const $FW_REGULAR = 400
Global Const $FW_MEDIUM = 500
Global Const $FW_SEMIBOLD = 600
Global Const $FW_DEMIBOLD = 600
Global Const $FW_BOLD = 700
Global Const $FW_EXTRABOLD = 800
Global Const $FW_ULTRABOLD = 800
Global Const $FW_HEAVY = 900
Global Const $FW_BLACK = 900
Global Const $CF_EFFECTS = 256
Global Const $CF_PRINTERFONTS = 2
Global Const $CF_SCREENFONTS = 1
Global Const $CF_NOSCRIPTSEL = 8388608
Global Const $CF_INITTOLOGFONTSTRUCT = 64
Global Const $LOGPIXELSX = 88
Global Const $LOGPIXELSY = 90
Global Const $ANSI_CHARSET = 0
Global Const $BALTIC_CHARSET = 186
Global Const $CHINESEBIG5_CHARSET = 136
Global Const $DEFAULT_CHARSET = 1
Global Const $EASTEUROPE_CHARSET = 238
Global Const $GB2312_CHARSET = 134
Global Const $GREEK_CHARSET = 161
Global Const $HANGEUL_CHARSET = 129
Global Const $MAC_CHARSET = 77
Global Const $OEM_CHARSET = 255
Global Const $RUSSIAN_CHARSET = 204
Global Const $SHIFTJIS_CHARSET = 128
Global Const $SYMBOL_CHARSET = 2
Global Const $TURKISH_CHARSET = 162
Global Const $VIETNAMESE_CHARSET = 163
Global Const $OUT_CHARACTER_PRECIS = 2
Global Const $OUT_DEFAULT_PRECIS = 0
Global Const $OUT_DEVICE_PRECIS = 5
Global Const $OUT_OUTLINE_PRECIS = 8
Global Const $OUT_PS_ONLY_PRECIS = 10
Global Const $OUT_RASTER_PRECIS = 6
Global Const $OUT_STRING_PRECIS = 1
Global Const $OUT_STROKE_PRECIS = 3
Global Const $OUT_TT_ONLY_PRECIS = 7
Global Const $OUT_TT_PRECIS = 4
Global Const $CLIP_CHARACTER_PRECIS = 1
Global Const $CLIP_DEFAULT_PRECIS = 0
Global Const $CLIP_EMBEDDED = 128
Global Const $CLIP_LH_ANGLES = 16
Global Const $CLIP_MASK = 15
Global Const $CLIP_STROKE_PRECIS = 2
Global Const $CLIP_TT_ALWAYS = 32
Global Const $ANTIALIASED_QUALITY = 4
Global Const $DEFAULT_QUALITY = 0
Global Const $DRAFT_QUALITY = 1
Global Const $NONANTIALIASED_QUALITY = 3
Global Const $PROOF_QUALITY = 2
Global Const $DEFAULT_PITCH = 0
Global Const $FIXED_PITCH = 1
Global Const $VARIABLE_PITCH = 2
Global Const $FF_DECORATIVE = 80
Global Const $FF_DONTCARE = 0
Global Const $FF_MODERN = 48
Global Const $FF_ROMAN = 16
Global Const $FF_SCRIPT = 64
Global Const $FF_SWISS = 32
Global Const $TAGPOINT = "long X;long Y"
Global Const $TAGRECT = "long Left;long Top;long Right;long Bottom"
Global Const $TAGSIZE = "long X;long Y"
Global Const $TAGMARGINS = "int cxLeftWidth;int cxRightWidth;int cyTopHeight;int cyBottomHeight"
Global Const $TAGFILETIME = "dword Lo;dword Hi"
Global Const $TAGSYSTEMTIME = "word Year;word Month;word Dow;word Day;word Hour;word Minute;word Second;word MSeconds"
Global Const $TAGTIME_ZONE_INFORMATION = "long Bias;wchar StdName[32];word StdDate[8];long StdBias;wchar DayName[32];word DayDate[8];long DayBias"
Global Const $TAGNMHDR = "hwnd hWndFrom;uint_ptr IDFrom;INT Code"
Global Const $TAGCOMBOBOXEXITEM = "uint Mask;int_ptr Item;ptr Text;int TextMax;int Image;int SelectedImage;int OverlayImage;" & "int Indent;lparam Param"
Global Const $TAGNMCBEDRAGBEGIN = $TAGNMHDR & ";int ItemID;ptr szText"
Global Const $TAGNMCBEENDEDIT = $TAGNMHDR & ";bool fChanged;int NewSelection;ptr szText;int Why"
Global Const $TAGNMCOMBOBOXEX = $TAGNMHDR & ";uint Mask;int_ptr Item;ptr Text;int TextMax;int Image;" & "int SelectedImage;int OverlayImage;int Indent;lparam Param"
Global Const $TAGDTPRANGE = "word MinYear;word MinMonth;word MinDOW;word MinDay;word MinHour;word MinMinute;" & "word MinSecond;word MinMSecond;word MaxYear;word MaxMonth;word MaxDOW;word MaxDay;word MaxHour;" & "word MaxMinute;word MaxSecond;word MaxMSecond;bool MinValid;bool MaxValid"
Global Const $TAGNMDATETIMECHANGE = $TAGNMHDR & ";dword Flag;" & $TAGSYSTEMTIME
Global Const $TAGNMDATETIMEFORMAT = $TAGNMHDR & ";ptr Format;" & $TAGSYSTEMTIME & ";ptr pDisplay;wchar Display[64]"
Global Const $TAGNMDATETIMEFORMATQUERY = $TAGNMHDR & ";ptr Format;long SizeX;long SizeY"
Global Const $TAGNMDATETIMEKEYDOWN = $TAGNMHDR & ";int VirtKey;ptr Format;" & $TAGSYSTEMTIME
Global Const $TAGNMDATETIMESTRING = $TAGNMHDR & ";ptr UserString;" & $TAGSYSTEMTIME & ";dword Flags"
Global Const $TAGEVENTLOGRECORD = "dword Length;dword Reserved;dword RecordNumber;dword TimeGenerated;dword TimeWritten;dword EventID;" & "word EventType;word NumStrings;word EventCategory;word ReservedFlags;dword ClosingRecordNumber;dword StringOffset;" & "dword UserSidLength;dword UserSidOffset;dword DataLength;dword DataOffset"
Global Const $TAGGDIPBITMAPDATA = "uint Width;uint Height;int Stride;int Format;ptr Scan0;uint_ptr Reserved"
Global Const $TAGGDIPENCODERPARAM = "byte GUID[16];dword Count;dword Type;ptr Values"
Global Const $TAGGDIPENCODERPARAMS = "dword Count;byte Params[0]"
Global Const $TAGGDIPRECTF = "float X;float Y;float Width;float Height"
Global Const $TAGGDIPSTARTUPINPUT = "uint Version;ptr Callback;bool NoThread;bool NoCodecs"
Global Const $TAGGDIPSTARTUPOUTPUT = "ptr HookProc;ptr UnhookProc"
Global Const $TAGGDIPIMAGECODECINFO = "byte CLSID[16];byte FormatID[16];ptr CodecName;ptr DllName;ptr FormatDesc;ptr FileExt;" & "ptr MimeType;dword Flags;dword Version;dword SigCount;dword SigSize;ptr SigPattern;ptr SigMask"
Global Const $TAGGDIPPENCODERPARAMS = "dword Count;byte Params[0]"
Global Const $TAGHDITEM = "uint Mask;int XY;ptr Text;handle hBMP;int TextMax;int Fmt;lparam Param;int Image;int Order;uint Type;ptr pFilter;uint State"
Global Const $TAGNMHDDISPINFO = $TAGNMHDR & ";int Item;uint Mask;ptr Text;int TextMax;int Image;lparam lParam"
Global Const $TAGNMHDFILTERBTNCLICK = $TAGNMHDR & ";int Item;" & $TAGRECT
Global Const $TAGNMHEADER = $TAGNMHDR & ";int Item;int Button;ptr pItem"
Global Const $TAGGETIPADDRESS = "byte Field4;byte Field3;byte Field2;byte Field1"
Global Const $TAGNMIPADDRESS = $TAGNMHDR & ";int Field;int Value"
Global Const $TAGLVFINDINFO = "uint Flags;ptr Text;lparam Param;" & $TAGPOINT & ";uint Direction"
Global Const $TAGLVHITTESTINFO = $TAGPOINT & ";uint Flags;int Item;int SubItem"
Global Const $TAGLVITEM = "uint Mask;int Item;int SubItem;uint State;uint StateMask;ptr Text;int TextMax;int Image;lparam Param;" & "int Indent;int GroupID;uint Columns;ptr pColumns"
Global Const $TAGNMLISTVIEW = $TAGNMHDR & ";int Item;int SubItem;uint NewState;uint OldState;uint Changed;" & "long ActionX;long ActionY;lparam Param"
Global Const $TAGNMLVCUSTOMDRAW = $TAGNMHDR & ";dword dwDrawStage;handle hdc;long Left;long Top;long Right;long Bottom;" & "dword_ptr dwItemSpec;uint uItemState;lparam lItemlParam" & ";dword clrText;dword clrTextBk;int iSubItem;dword dwItemType;dword clrFace;int iIconEffect;" & "int iIconPhase;int iPartId;int iStateId;long TextLeft;long TextTop;long TextRight;long TextBottom;uint uAlign"
Global Const $TAGNMLVDISPINFO = $TAGNMHDR & ";" & $TAGLVITEM
Global Const $TAGNMLVFINDITEM = $TAGNMHDR & ";" & $TAGLVFINDINFO
Global Const $TAGNMLVGETINFOTIP = $TAGNMHDR & ";dword Flags;ptr Text;int TextMax;int Item;int SubItem;lparam lParam"
Global Const $TAGNMITEMACTIVATE = $TAGNMHDR & ";int Index;int SubItem;uint NewState;uint OldState;uint Changed;" & $TAGPOINT & ";lparam lParam;uint KeyFlags"
Global Const $TAGNMLVKEYDOWN = $TAGNMHDR & ";align 1;word VKey;uint Flags"
Global Const $TAGNMLVSCROLL = $TAGNMHDR & ";int DX;int DY"
Global Const $TAGMCHITTESTINFO = "uint Size;" & $TAGPOINT & ";uint Hit;" & $TAGSYSTEMTIME
Global Const $TAGMCMONTHRANGE = "word MinYear;word MinMonth;word MinDOW;word MinDay;word MinHour;word MinMinute;word MinSecond;" & "word MinMSeconds;word MaxYear;word MaxMonth;word MaxDOW;word MaxDay;word MaxHour;word MaxMinute;word MaxSecond;" & "word MaxMSeconds;short Span"
Global Const $TAGMCRANGE = "word MinYear;word MinMonth;word MinDOW;word MinDay;word MinHour;word MinMinute;word MinSecond;" & "word MinMSeconds;word MaxYear;word MaxMonth;word MaxDOW;word MaxDay;word MaxHour;word MaxMinute;word MaxSecond;" & "word MaxMSeconds;short MinSet;short MaxSet"
Global Const $TAGMCSELRANGE = "word MinYear;word MinMonth;word MinDOW;word MinDay;word MinHour;word MinMinute;word MinSecond;" & "word MinMSeconds;word MaxYear;word MaxMonth;word MaxDOW;word MaxDay;word MaxHour;word MaxMinute;word MaxSecond;" & "word MaxMSeconds"
Global Const $TAGNMDAYSTATE = $TAGNMHDR & ";" & $TAGSYSTEMTIME & ";int DayState;ptr pDayState"
Global Const $TAGNMSELCHANGE = $TAGNMHDR & ";word BegYear;word BegMonth;word BegDOW;word BegDay;" & "word BegHour;word BegMinute;word BegSecond;word BegMSeconds;word EndYear;word EndMonth;word EndDOW;" & "word EndDay;word EndHour;word EndMinute;word EndSecond;word EndMSeconds"
Global Const $TAGNMOBJECTNOTIFY = $TAGNMHDR & ";int Item;ptr piid;ptr pObject;long Result"
Global Const $TAGNMTCKEYDOWN = $TAGNMHDR & ";word VKey;uint Flags"
Global Const $TAGTVITEM = "uint Mask;handle hItem;uint State;uint StateMask;ptr Text;int TextMax;int Image;int SelectedImage;" & "int Children;lparam Param"
Global Const $TAGTVITEMEX = $TAGTVITEM & ";int Integral"
Global Const $TAGNMTREEVIEW = $TAGNMHDR & ";uint Action;uint OldMask;handle OldhItem;uint OldState;uint OldStateMask;" & "ptr OldText;int OldTextMax;int OldImage;int OldSelectedImage;int OldChildren;lparam OldParam;uint NewMask;handle NewhItem;" & "uint NewState;uint NewStateMask;ptr NewText;int NewTextMax;int NewImage;int NewSelectedImage;int NewChildren;" & "lparam NewParam;long PointX;long PointY"
Global Const $TAGNMTVCUSTOMDRAW = $TAGNMHDR & ";dword DrawStage;handle HDC;long Left;long Top;long Right;long Bottom;" & "dword_ptr ItemSpec;uint ItemState;lparam ItemParam;dword ClrText;dword ClrTextBk;int Level"
Global Const $TAGNMTVDISPINFO = $TAGNMHDR & ";" & $TAGTVITEM
Global Const $TAGNMTVGETINFOTIP = $TAGNMHDR & ";ptr Text;int TextMax;handle hItem;lparam lParam"
Global Const $TAGTVHITTESTINFO = $TAGPOINT & ";uint Flags;handle Item"
Global Const $TAGNMTVKEYDOWN = $TAGNMHDR & ";word VKey;uint Flags"
Global Const $TAGNMMOUSE = $TAGNMHDR & ";dword_ptr ItemSpec;dword_ptr ItemData;" & $TAGPOINT & ";lparam HitInfo"
Global Const $TAGTOKEN_PRIVILEGES = "dword Count;int64 LUID;dword Attributes"
Global Const $TAGIMAGEINFO = "handle hBitmap;handle hMask;int Unused1;int Unused2;" & $TAGRECT
Global Const $TAGMENUINFO = "dword Size;INT Mask;dword Style;uint YMax;handle hBack;dword ContextHelpID;ulong_ptr MenuData"
Global Const $TAGMENUITEMINFO = "uint Size;uint Mask;uint Type;uint State;uint ID;handle SubMenu;handle BmpChecked;handle BmpUnchecked;" & "ulong_ptr ItemData;ptr TypeData;uint CCH;handle BmpItem"
Global Const $TAGREBARBANDINFO = "uint cbSize;uint fMask;uint fStyle;dword clrFore;dword clrBack;ptr lpText;uint cch;" & "int iImage;hwnd hwndChild;uint cxMinChild;uint cyMinChild;uint cx;handle hbmBack;uint wID;uint cyChild;uint cyMaxChild;" & "uint cyIntegral;uint cxIdeal;lparam lParam;uint cxHeader"
Global Const $TAGNMREBARAUTOBREAK = $TAGNMHDR & ";uint uBand;uint wID;lparam lParam;uint uMsg;uint fStyleCurrent;bool fAutoBreak"
Global Const $TAGNMRBAUTOSIZE = $TAGNMHDR & ";bool fChanged;long TargetLeft;long TargetTop;long TargetRight;long TargetBottom;" & "long ActualLeft;long ActualTop;long ActualRight;long ActualBottom"
Global Const $TAGNMREBAR = $TAGNMHDR & ";dword dwMask;uint uBand;uint fStyle;uint wID;laram lParam"
Global Const $TAGNMREBARCHEVRON = $TAGNMHDR & ";uint uBand;uint wID;lparam lParam;" & $TAGRECT & ";lparam lParamNM"
Global Const $TAGNMREBARCHILDSIZE = $TAGNMHDR & ";uint uBand;uint wID;long CLeft;long CTop;long CRight;long CBottom;" & "long BLeft;long BTop;long BRight;long BBottom"
Global Const $TAGCOLORSCHEME = "dword Size;dword BtnHighlight;dword BtnShadow"
Global Const $TAGNMTOOLBAR = $TAGNMHDR & ";int iItem;" & "int iBitmap;int idCommand;byte fsState;byte fsStyle;align;dword_ptr dwData;int_ptr iString" & ";int cchText;ptr pszText;" & $TAGRECT
Global Const $TAGNMTBHOTITEM = $TAGNMHDR & ";int idOld;int idNew;dword dwFlags"
Global Const $TAGTBBUTTON = "int Bitmap;int Command;byte State;byte Style;align;dword_ptr Param;int_ptr String"
Global Const $TAGTBBUTTONINFO = "uint Size;dword Mask;int Command;int Image;byte State;byte Style;word CX;dword_ptr Param;ptr Text;int TextMax"
Global Const $TAGNETRESOURCE = "dword Scope;dword Type;dword DisplayType;dword Usage;ptr LocalName;ptr RemoteName;ptr Comment;ptr Provider"
Global Const $TAGOVERLAPPED = "ulong_ptr Internal;ulong_ptr InternalHigh;dword Offset;dword OffsetHigh;handle hEvent"
Global Const $TAGOPENFILENAME = "dword StructSize;hwnd hwndOwner;handle hInstance;ptr lpstrFilter;ptr lpstrCustomFilter;" & "dword nMaxCustFilter;dword nFilterIndex;ptr lpstrFile;dword nMaxFile;ptr lpstrFileTitle;dword nMaxFileTitle;" & "ptr lpstrInitialDir;ptr lpstrTitle;dword Flags;word nFileOffset;word nFileExtension;ptr lpstrDefExt;lparam lCustData;" & "ptr lpfnHook;ptr lpTemplateName;ptr pvReserved;dword dwReserved;dword FlagsEx"
Global Const $TAGBITMAPINFO = "dword Size;long Width;long Height;word Planes;word BitCount;dword Compression;dword SizeImage;" & "long XPelsPerMeter;long YPelsPerMeter;dword ClrUsed;dword ClrImportant;dword RGBQuad"
Global Const $TAGBLENDFUNCTION = "byte Op;byte Flags;byte Alpha;byte Format"
Global Const $TAGGUID = "dword Data1;word Data2;word Data3;byte Data4[8]"
Global Const $TAGWINDOWPLACEMENT = "uint length; uint flags;uint showCmd;long ptMinPosition[2];long ptMaxPosition[2];long rcNormalPosition[4]"
Global Const $TAGWINDOWPOS = "hwnd hWnd;hwnd InsertAfter;int X;int Y;int CX;int CY;uint Flags"
Global Const $TAGSCROLLINFO = "uint cbSize;uint fMask;int  nMin;int  nMax;uint nPage;int  nPos;int  nTrackPos"
Global Const $TAGSCROLLBARINFO = "dword cbSize;" & $TAGRECT & ";int dxyLineButton;int xyThumbTop;" & "int xyThumbBottom;int reserved;dword rgstate[6]"
Global Const $TAGLOGFONT = "long Height;long Width;long Escapement;long Orientation;long Weight;byte Italic;byte Underline;" & "byte Strikeout;byte CharSet;byte OutPrecision;byte ClipPrecision;byte Quality;byte PitchAndFamily;wchar FaceName[32]"
Global Const $TAGKBDLLHOOKSTRUCT = "dword vkCode;dword scanCode;dword flags;dword time;ulong_ptr dwExtraInfo"
Global Const $TAGPROCESS_INFORMATION = "handle hProcess;handle hThread;dword ProcessID;dword ThreadID"
Global Const $TAGSTARTUPINFO = "dword Size;ptr Reserved1;ptr Desktop;ptr Title;dword X;dword Y;dword XSize;dword YSize;dword XCountChars;" & "dword YCountChars;dword FillAttribute;dword Flags;word ShowWindow;word Reserved2;ptr Reserved3;handle StdInput;" & "handle StdOutput;handle StdError"
Global Const $TAGSECURITY_ATTRIBUTES = "dword Length;ptr Descriptor;bool InheritHandle"
Global Const $TAGWIN32_FIND_DATA = "dword dwFileAttributes; dword ftCreationTime[2]; dword ftLastAccessTime[2]; dword ftLastWriteTime[2]; dword nFileSizeHigh; dword nFileSizeLow; dword dwReserved0; dword dwReserved1; wchar cFileName[260]; wchar cAlternateFileName[14]"
Func _WINAPI_GETLASTERROR($CURERR = @error, $CUREXT = @extended)
	Local $ARESULT = DllCall("kernel32.dll", "dword", "GetLastError")
	Return SetError($CURERR, $CUREXT, $ARESULT[0])
EndFunc
Func _WINAPI_SETLASTERROR($IERRCODE, $CURERR = @error, $CUREXT = @extended)
	DllCall("kernel32.dll", "none", "SetLastError", "dword", $IERRCODE)
	Return SetError($CURERR, $CUREXT)
EndFunc
Global Const $__MISCCONSTANT_CC_ANYCOLOR = 256
Global Const $__MISCCONSTANT_CC_FULLOPEN = 2
Global Const $__MISCCONSTANT_CC_RGBINIT = 1
Global Const $TAGCHOOSECOLOR = "dword Size;hwnd hWndOwnder;handle hInstance;dword rgbResult;ptr CustColors;dword Flags;lparam lCustData;" & "ptr lpfnHook;ptr lpTemplateName"
Global Const $TAGCHOOSEFONT = "dword Size;hwnd hWndOwner;handle hDC;ptr LogFont;int PointSize;dword Flags;dword rgbColors;lparam CustData;" & "ptr fnHook;ptr TemplateName;handle hInstance;ptr szStyle;word FontType;int SizeMin;int SizeMax"
Func _CHOOSECOLOR($IRETURNTYPE = 0, $ICOLORREF = 0, $IREFTYPE = 0, $HWNDOWNDER = 0)
	Local $CUSTCOLORS = "dword[16]"
	Local $TCHOOSE = DllStructCreate($TAGCHOOSECOLOR)
	Local $TCC = DllStructCreate($CUSTCOLORS)
	If $IREFTYPE = 1 Then
		$ICOLORREF = Int($ICOLORREF)
	ElseIf $IREFTYPE = 2 Then
		$ICOLORREF = Hex(String($ICOLORREF), 6)
		$ICOLORREF = "0x" & StringMid($ICOLORREF, 5, 2) & StringMid($ICOLORREF, 3, 2) & StringMid($ICOLORREF, 1, 2)
	EndIf
	DllStructSetData($TCHOOSE, "Size", DllStructGetSize($TCHOOSE))
	DllStructSetData($TCHOOSE, "hWndOwnder", $HWNDOWNDER)
	DllStructSetData($TCHOOSE, "rgbResult", $ICOLORREF)
	DllStructSetData($TCHOOSE, "CustColors", DllStructGetPtr($TCC))
	DllStructSetData($TCHOOSE, "Flags", BitOR($__MISCCONSTANT_CC_ANYCOLOR, $__MISCCONSTANT_CC_FULLOPEN, $__MISCCONSTANT_CC_RGBINIT))
	Local $ARESULT = DllCall("comdlg32.dll", "bool", "ChooseColor", "ptr", DllStructGetPtr($TCHOOSE))
	If @error Then Return SetError(@error, @extended, -1)
	If $ARESULT[0] = 0 Then Return SetError(-3, -3, -1)
	Local $COLOR_PICKED = DllStructGetData($TCHOOSE, "rgbResult")
	If $IRETURNTYPE = 1 Then
		Return "0x" & Hex(String($COLOR_PICKED), 6)
	ElseIf $IRETURNTYPE = 2 Then
		$COLOR_PICKED = Hex(String($COLOR_PICKED), 6)
		Return "0x" & StringMid($COLOR_PICKED, 5, 2) & StringMid($COLOR_PICKED, 3, 2) & StringMid($COLOR_PICKED, 1, 2)
	ElseIf $IRETURNTYPE = 0 Then
		Return $COLOR_PICKED
	Else
		Return SetError(-4, -4, -1)
	EndIf
EndFunc
Func _CHOOSEFONT($SFONTNAME = "Courier New", $IPOINTSIZE = 10, $ICOLORREF = 0, $IFONTWEIGHT = 0, $IITALIC = False, $IUNDERLINE = False, $ISTRIKETHRU = False, $HWNDOWNER = 0)
	Local $ITALIC = 0, $UNDERLINE = 0, $STRIKEOUT = 0
	Local $LNGDC = __MISC_GETDC(0)
	Local $LFHEIGHT = Round(($IPOINTSIZE * __MISC_GETDEVICECAPS($LNGDC, $LOGPIXELSX)) / 72, 0)
	__MISC_RELEASEDC(0, $LNGDC)
	Local $TCHOOSEFONT = DllStructCreate($TAGCHOOSEFONT)
	Local $TLOGFONT = DllStructCreate($TAGLOGFONT)
	DllStructSetData($TCHOOSEFONT, "Size", DllStructGetSize($TCHOOSEFONT))
	DllStructSetData($TCHOOSEFONT, "hWndOwner", $HWNDOWNER)
	DllStructSetData($TCHOOSEFONT, "LogFont", DllStructGetPtr($TLOGFONT))
	DllStructSetData($TCHOOSEFONT, "PointSize", $IPOINTSIZE)
	DllStructSetData($TCHOOSEFONT, "Flags", BitOR($CF_SCREENFONTS, $CF_PRINTERFONTS, $CF_EFFECTS, $CF_INITTOLOGFONTSTRUCT, $CF_NOSCRIPTSEL))
	DllStructSetData($TCHOOSEFONT, "rgbColors", $ICOLORREF)
	DllStructSetData($TCHOOSEFONT, "FontType", 0)
	DllStructSetData($TLOGFONT, "Height", $LFHEIGHT)
	DllStructSetData($TLOGFONT, "Weight", $IFONTWEIGHT)
	DllStructSetData($TLOGFONT, "Italic", $IITALIC)
	DllStructSetData($TLOGFONT, "Underline", $IUNDERLINE)
	DllStructSetData($TLOGFONT, "Strikeout", $ISTRIKETHRU)
	DllStructSetData($TLOGFONT, "FaceName", $SFONTNAME)
	Local $ARESULT = DllCall("comdlg32.dll", "bool", "ChooseFontW", "ptr", DllStructGetPtr($TCHOOSEFONT))
	If @error Then Return SetError(@error, @extended, -1)
	If $ARESULT[0] = 0 Then Return SetError(-3, -3, -1)
	Local $FONTNAME = DllStructGetData($TLOGFONT, "FaceName")
	If StringLen($FONTNAME) = 0 And StringLen($SFONTNAME) > 0 Then $FONTNAME = $SFONTNAME
	If DllStructGetData($TLOGFONT, "Italic") Then $ITALIC = 2
	If DllStructGetData($TLOGFONT, "Underline") Then $UNDERLINE = 4
	If DllStructGetData($TLOGFONT, "Strikeout") Then $STRIKEOUT = 8
	Local $ATTRIBUTES = BitOR($ITALIC, $UNDERLINE, $STRIKEOUT)
	Local $SIZE = DllStructGetData($TCHOOSEFONT, "PointSize") / 10
	Local $COLORREF = DllStructGetData($TCHOOSEFONT, "rgbColors")
	Local $WEIGHT = DllStructGetData($TLOGFONT, "Weight")
	Local $COLOR_PICKED = Hex(String($COLORREF), 6)
	Return StringSplit($ATTRIBUTES & "," & $FONTNAME & "," & $SIZE & "," & $WEIGHT & "," & $COLORREF & "," & "0x" & $COLOR_PICKED & "," & "0x" & StringMid($COLOR_PICKED, 5, 2) & StringMid($COLOR_PICKED, 3, 2) & StringMid($COLOR_PICKED, 1, 2), ",")
EndFunc
Func _CLIPPUTFILE($SFILE, $SSEPARATOR = "|")
	Local Const $GMEM_MOVEABLE = 2, $CF_HDROP = 15
	$SFILE &= $SSEPARATOR & $SSEPARATOR
	Local $NGLOBMEMSIZE = (StringLen($SFILE) + 20)
	Local $ARESULT = DllCall("user32.dll", "bool", "OpenClipboard", "hwnd", 0)
	If @error Or $ARESULT[0] = 0 Then Return SetError(1, _WINAPI_GETLASTERROR(), False)
	Local $IERROR = 0, $ILASTERROR = 0
	$ARESULT = DllCall("user32.dll", "bool", "EmptyClipboard")
	If @error Or Not $ARESULT[0] Then
		$IERROR = 2
		$ILASTERROR = _WINAPI_GETLASTERROR()
	Else
		$ARESULT = DllCall("kernel32.dll", "handle", "GlobalAlloc", "uint", $GMEM_MOVEABLE, "ulong_ptr", $NGLOBMEMSIZE)
		If @error Or Not $ARESULT[0] Then
			$IERROR = 3
			$ILASTERROR = _WINAPI_GETLASTERROR()
		Else
			Local $HGLOBAL = $ARESULT[0]
			$ARESULT = DllCall("kernel32.dll", "ptr", "GlobalLock", "handle", $HGLOBAL)
			If @error Or Not $ARESULT[0] Then
				$IERROR = 4
				$ILASTERROR = _WINAPI_GETLASTERROR()
			Else
				Local $HLOCK = $ARESULT[0]
				Local $DROPFILES = DllStructCreate("dword;ptr;int;int;int;char[" & StringLen($SFILE) + 1 & "]", $HLOCK)
				If @error Then Return SetError(5, 6, False)
				Local $TEMPSTRUCT = DllStructCreate("dword;ptr;int;int;int")
				DllStructSetData($DROPFILES, 1, DllStructGetSize($TEMPSTRUCT))
				DllStructSetData($DROPFILES, 2, 0)
				DllStructSetData($DROPFILES, 3, 0)
				DllStructSetData($DROPFILES, 4, 0)
				DllStructSetData($DROPFILES, 5, 0)
				DllStructSetData($DROPFILES, 6, $SFILE)
				For $I = 1 To StringLen($SFILE)
					If DllStructGetData($DROPFILES, 6, $I) = $SSEPARATOR Then DllStructSetData($DROPFILES, 6, Chr(0), $I)
				Next
				$ARESULT = DllCall("user32.dll", "handle", "SetClipboardData", "uint", $CF_HDROP, "handle", $HGLOBAL)
				If @error Or Not $ARESULT[0] Then
					$IERROR = 6
					$ILASTERROR = _WINAPI_GETLASTERROR()
				EndIf
				$ARESULT = DllCall("kernel32.dll", "bool", "GlobalUnlock", "handle", $HGLOBAL)
				IF (@error Or Not $ARESULT[0]) And Not $IERROR And _WINAPI_GETLASTERROR() Then
					$IERROR = 8
					$ILASTERROR = _WINAPI_GETLASTERROR()
				EndIf
			EndIf
			$ARESULT = DllCall("kernel32.dll", "ptr", "GlobalFree", "handle", $HGLOBAL)
			IF (@error Or Not $ARESULT[0]) And Not $IERROR Then
				$IERROR = 9
				$ILASTERROR = _WINAPI_GETLASTERROR()
			EndIf
		EndIf
	EndIf
	$ARESULT = DllCall("user32.dll", "bool", "CloseClipboard")
	IF (@error Or Not $ARESULT[0]) And Not $IERROR Then Return SetError(7, _WINAPI_GETLASTERROR(), False)
	If $IERROR Then Return SetError($IERROR, $ILASTERROR, False)
	Return True
EndFunc
Func _IIF($FTEST, $VTRUEVAL, $VFALSEVAL)
	If $FTEST Then
		Return $VTRUEVAL
	Else
		Return $VFALSEVAL
	EndIf
EndFunc
Func _MOUSETRAP($ILEFT = 0, $ITOP = 0, $IRIGHT = 0, $IBOTTOM = 0)
	Local $ARESULT
	If @NumParams == 0 Then
		$ARESULT = DllCall("user32.dll", "bool", "ClipCursor", "ptr", 0)
		If @error Or Not $ARESULT[0] Then Return SetError(1, _WINAPI_GETLASTERROR(), False)
	Else
		If @NumParams == 2 Then
			$IRIGHT = $ILEFT + 1
			$IBOTTOM = $ITOP + 1
		EndIf
		Local $TRECT = DllStructCreate($TAGRECT)
		DllStructSetData($TRECT, "Left", $ILEFT)
		DllStructSetData($TRECT, "Top", $ITOP)
		DllStructSetData($TRECT, "Right", $IRIGHT)
		DllStructSetData($TRECT, "Bottom", $IBOTTOM)
		$ARESULT = DllCall("user32.dll", "bool", "ClipCursor", "ptr", DllStructGetPtr($TRECT))
		If @error Or Not $ARESULT[0] Then Return SetError(2, _WINAPI_GETLASTERROR(), False)
	EndIf
	Return True
EndFunc
Func _SINGLETON($SOCCURENCENAME, $IFLAG = 0)
	Local Const $ERROR_ALREADY_EXISTS = 183
	Local Const $SECURITY_DESCRIPTOR_REVISION = 1
	Local $PSECURITYATTRIBUTES = 0
	If BitAND($IFLAG, 2) Then
		Local $TSECURITYDESCRIPTOR = DllStructCreate("dword[5]")
		Local $PSECURITYDESCRIPTOR = DllStructGetPtr($TSECURITYDESCRIPTOR)
		Local $ARET = DllCall("advapi32.dll", "bool", "InitializeSecurityDescriptor", "ptr", $PSECURITYDESCRIPTOR, "dword", $SECURITY_DESCRIPTOR_REVISION)
		If @error Then Return SetError(@error, @extended, 0)
		If $ARET[0] Then
			$ARET = DllCall("advapi32.dll", "bool", "SetSecurityDescriptorDacl", "ptr", $PSECURITYDESCRIPTOR, "bool", 1, "ptr", 0, "bool", 0)
			If @error Then Return SetError(@error, @extended, 0)
			If $ARET[0] Then
				Local $STRUCTSECURITYATTRIBUTES = DllStructCreate($TAGSECURITY_ATTRIBUTES)
				DllStructSetData($STRUCTSECURITYATTRIBUTES, 1, DllStructGetSize($STRUCTSECURITYATTRIBUTES))
				DllStructSetData($STRUCTSECURITYATTRIBUTES, 2, $PSECURITYDESCRIPTOR)
				DllStructSetData($STRUCTSECURITYATTRIBUTES, 3, 0)
				$PSECURITYATTRIBUTES = DllStructGetPtr($STRUCTSECURITYATTRIBUTES)
			EndIf
		EndIf
	EndIf
	Local $HANDLE = DllCall("kernel32.dll", "handle", "CreateMutexW", "ptr", $PSECURITYATTRIBUTES, "bool", 1, "wstr", $SOCCURENCENAME)
	If @error Then Return SetError(@error, @extended, 0)
	Local $LASTERROR = DllCall("kernel32.dll", "dword", "GetLastError")
	If @error Then Return SetError(@error, @extended, 0)
	If $LASTERROR[0] = $ERROR_ALREADY_EXISTS Then
		If BitAND($IFLAG, 1) Then
			Return SetError($LASTERROR[0], $LASTERROR[0], 0)
		Else
			Exit -1
		EndIf
	EndIf
	Return $HANDLE[0]
EndFunc
Func _ISPRESSED($SHEXKEY, $VDLL = "user32.dll")
	Local $A_R = DllCall($VDLL, "short", "GetAsyncKeyState", "int", "0x" & $SHEXKEY)
	If @error Then Return SetError(@error, @extended, False)
	Return BitAND($A_R[0], 32768) <> 0
EndFunc
Func _VERSIONCOMPARE($SVERSION1, $SVERSION2)
	If $SVERSION1 = $SVERSION2 Then Return 0
	Local $SEP = "."
	If StringInStr($SVERSION1, $SEP) = 0 Then $SEP = ","
	Local $AVERSION1 = StringSplit($SVERSION1, $SEP)
	Local $AVERSION2 = StringSplit($SVERSION2, $SEP)
	If UBound($AVERSION1) <> UBound($AVERSION2) Or UBound($AVERSION1) = 0 Then
		SetExtended(1)
		If $SVERSION1 > $SVERSION2 Then
			Return 1
		ElseIf $SVERSION1 < $SVERSION2 Then
			Return -1
		EndIf
	Else
		For $I = 1 To UBound($AVERSION1) - 1
			If StringIsDigit($AVERSION1[$I]) And StringIsDigit($AVERSION2[$I]) Then
				If Number($AVERSION1[$I]) > Number($AVERSION2[$I]) Then
					Return 1
				ElseIf Number($AVERSION1[$I]) < Number($AVERSION2[$I]) Then
					Return -1
				EndIf
			Else
				SetExtended(1)
				If $AVERSION1[$I] > $AVERSION2[$I] Then
					Return 1
				ElseIf $AVERSION1[$I] < $AVERSION2[$I] Then
					Return -1
				EndIf
			EndIf
		Next
	EndIf
	Return SetError(2, 0, 0)
EndFunc
Func __MISC_GETDC($HWND)
	Local $ARESULT = DllCall("User32.dll", "handle", "GetDC", "hwnd", $HWND)
	If @error Or Not $ARESULT[0] Then Return SetError(1, _WINAPI_GETLASTERROR(), 0)
	Return $ARESULT[0]
EndFunc
Func __MISC_GETDEVICECAPS($HDC, $IINDEX)
	Local $ARESULT = DllCall("GDI32.dll", "int", "GetDeviceCaps", "handle", $HDC, "int", $IINDEX)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func __MISC_RELEASEDC($HWND, $HDC)
	Local $ARESULT = DllCall("User32.dll", "int", "ReleaseDC", "hwnd", $HWND, "handle", $HDC)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0] <> 0
EndFunc
Global Const $GMEM_FIXED = 0
Global Const $GMEM_MOVEABLE = 2
Global Const $GMEM_NOCOMPACT = 16
Global Const $GMEM_NODISCARD = 32
Global Const $GMEM_ZEROINIT = 64
Global Const $GMEM_MODIFY = 128
Global Const $GMEM_DISCARDABLE = 256
Global Const $GMEM_NOT_BANKED = 4096
Global Const $GMEM_SHARE = 8192
Global Const $GMEM_DDESHARE = 8192
Global Const $GMEM_NOTIFY = 16384
Global Const $GMEM_LOWER = 4096
Global Const $GMEM_VALID_FLAGS = 32626
Global Const $GMEM_INVALID_HANDLE = 32768
Global Const $GPTR = $GMEM_FIXED + $GMEM_ZEROINIT
Global Const $GHND = $GMEM_MOVEABLE + $GMEM_ZEROINIT
Global Const $MEM_COMMIT = 4096
Global Const $MEM_RESERVE = 8192
Global Const $MEM_TOP_DOWN = 1048576
Global Const $MEM_SHARED = 134217728
Global Const $PAGE_NOACCESS = 1
Global Const $PAGE_READONLY = 2
Global Const $PAGE_READWRITE = 4
Global Const $PAGE_EXECUTE = 16
Global Const $PAGE_EXECUTE_READ = 32
Global Const $PAGE_EXECUTE_READWRITE = 64
Global Const $PAGE_GUARD = 256
Global Const $PAGE_NOCACHE = 512
Global Const $MEM_DECOMMIT = 16384
Global Const $MEM_RELEASE = 32768
Global Const $PROCESS_TERMINATE = 1
Global Const $PROCESS_CREATE_THREAD = 2
Global Const $PROCESS_SET_SESSIONID = 4
Global Const $PROCESS_VM_OPERATION = 8
Global Const $PROCESS_VM_READ = 16
Global Const $PROCESS_VM_WRITE = 32
Global Const $PROCESS_DUP_HANDLE = 64
Global Const $PROCESS_CREATE_PROCESS = 128
Global Const $PROCESS_SET_QUOTA = 256
Global Const $PROCESS_SET_INFORMATION = 512
Global Const $PROCESS_QUERY_INFORMATION = 1024
Global Const $PROCESS_SUSPEND_RESUME = 2048
Global Const $PROCESS_ALL_ACCESS = 2035711
Global Const $ERROR_NO_TOKEN = 1008
Global Const $SE_ASSIGNPRIMARYTOKEN_NAME = "SeAssignPrimaryTokenPrivilege"
Global Const $SE_AUDIT_NAME = "SeAuditPrivilege"
Global Const $SE_BACKUP_NAME = "SeBackupPrivilege"
Global Const $SE_CHANGE_NOTIFY_NAME = "SeChangeNotifyPrivilege"
Global Const $SE_CREATE_GLOBAL_NAME = "SeCreateGlobalPrivilege"
Global Const $SE_CREATE_PAGEFILE_NAME = "SeCreatePagefilePrivilege"
Global Const $SE_CREATE_PERMANENT_NAME = "SeCreatePermanentPrivilege"
Global Const $SE_CREATE_TOKEN_NAME = "SeCreateTokenPrivilege"
Global Const $SE_DEBUG_NAME = "SeDebugPrivilege"
Global Const $SE_ENABLE_DELEGATION_NAME = "SeEnableDelegationPrivilege"
Global Const $SE_IMPERSONATE_NAME = "SeImpersonatePrivilege"
Global Const $SE_INC_BASE_PRIORITY_NAME = "SeIncreaseBasePriorityPrivilege"
Global Const $SE_INCREASE_QUOTA_NAME = "SeIncreaseQuotaPrivilege"
Global Const $SE_LOAD_DRIVER_NAME = "SeLoadDriverPrivilege"
Global Const $SE_LOCK_MEMORY_NAME = "SeLockMemoryPrivilege"
Global Const $SE_MACHINE_ACCOUNT_NAME = "SeMachineAccountPrivilege"
Global Const $SE_MANAGE_VOLUME_NAME = "SeManageVolumePrivilege"
Global Const $SE_PROF_SINGLE_PROCESS_NAME = "SeProfileSingleProcessPrivilege"
Global Const $SE_REMOTE_SHUTDOWN_NAME = "SeRemoteShutdownPrivilege"
Global Const $SE_RESTORE_NAME = "SeRestorePrivilege"
Global Const $SE_SECURITY_NAME = "SeSecurityPrivilege"
Global Const $SE_SHUTDOWN_NAME = "SeShutdownPrivilege"
Global Const $SE_SYNC_AGENT_NAME = "SeSyncAgentPrivilege"
Global Const $SE_SYSTEM_ENVIRONMENT_NAME = "SeSystemEnvironmentPrivilege"
Global Const $SE_SYSTEM_PROFILE_NAME = "SeSystemProfilePrivilege"
Global Const $SE_SYSTEMTIME_NAME = "SeSystemtimePrivilege"
Global Const $SE_TAKE_OWNERSHIP_NAME = "SeTakeOwnershipPrivilege"
Global Const $SE_TCB_NAME = "SeTcbPrivilege"
Global Const $SE_UNSOLICITED_INPUT_NAME = "SeUnsolicitedInputPrivilege"
Global Const $SE_UNDOCK_NAME = "SeUndockPrivilege"
Global Const $SE_PRIVILEGE_ENABLED_BY_DEFAULT = 1
Global Const $SE_PRIVILEGE_ENABLED = 2
Global Const $SE_PRIVILEGE_REMOVED = 4
Global Const $SE_PRIVILEGE_USED_FOR_ACCESS = -2147483648
Global Const $TOKENUSER = 1
Global Const $TOKENGROUPS = 2
Global Const $TOKENPRIVILEGES = 3
Global Const $TOKENOWNER = 4
Global Const $TOKENPRIMARYGROUP = 5
Global Const $TOKENDEFAULTDACL = 6
Global Const $TOKENSOURCE = 7
Global Const $TOKENTYPE = 8
Global Const $TOKENIMPERSONATIONLEVEL = 9
Global Const $TOKENSTATISTICS = 10
Global Const $TOKENRESTRICTEDSIDS = 11
Global Const $TOKENSESSIONID = 12
Global Const $TOKENGROUPSANDPRIVILEGES = 13
Global Const $TOKENSESSIONREFERENCE = 14
Global Const $TOKENSANDBOXINERT = 15
Global Const $TOKENAUDITPOLICY = 16
Global Const $TOKENORIGIN = 17
Global Const $TOKENELEVATIONTYPE = 18
Global Const $TOKENLINKEDTOKEN = 19
Global Const $TOKENELEVATION = 20
Global Const $TOKENHASRESTRICTIONS = 21
Global Const $TOKENACCESSINFORMATION = 22
Global Const $TOKENVIRTUALIZATIONALLOWED = 23
Global Const $TOKENVIRTUALIZATIONENABLED = 24
Global Const $TOKENINTEGRITYLEVEL = 25
Global Const $TOKENUIACCESS = 26
Global Const $TOKENMANDATORYPOLICY = 27
Global Const $TOKENLOGONSID = 28
Global Const $TOKEN_ASSIGN_PRIMARY = 1
Global Const $TOKEN_DUPLICATE = 2
Global Const $TOKEN_IMPERSONATE = 4
Global Const $TOKEN_QUERY = 8
Global Const $TOKEN_QUERY_SOURCE = 16
Global Const $TOKEN_ADJUST_PRIVILEGES = 32
Global Const $TOKEN_ADJUST_GROUPS = 64
Global Const $TOKEN_ADJUST_DEFAULT = 128
Global Const $TOKEN_ADJUST_SESSIONID = 256
Func _SECURITY__ADJUSTTOKENPRIVILEGES($HTOKEN, $FDISABLEALL, $PNEWSTATE, $IBUFFERLEN, $PPREVSTATE = 0, $PREQUIRED = 0)
	Local $ARESULT = DllCall("advapi32.dll", "bool", "AdjustTokenPrivileges", "handle", $HTOKEN, "bool", $FDISABLEALL, "ptr", $PNEWSTATE, "dword", $IBUFFERLEN, "ptr", $PPREVSTATE, "ptr", $PREQUIRED)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _SECURITY__GETACCOUNTSID($SACCOUNT, $SSYSTEM = "")
	Local $AACCT = _SECURITY__LOOKUPACCOUNTNAME($SACCOUNT, $SSYSTEM)
	If @error Then Return SetError(@error, 0, 0)
	Return _SECURITY__STRINGSIDTOSID($AACCT[0])
EndFunc
Func _SECURITY__GETLENGTHSID($PSID)
	If Not _SECURITY__ISVALIDSID($PSID) Then Return SetError(-1, 0, 0)
	Local $ARESULT = DllCall("advapi32.dll", "dword", "GetLengthSid", "ptr", $PSID)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _SECURITY__GETTOKENINFORMATION($HTOKEN, $ICLASS)
	Local $ARESULT = DllCall("advapi32.dll", "bool", "GetTokenInformation", "handle", $HTOKEN, "int", $ICLASS, "ptr", 0, "dword", 0, "dword*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	If Not $ARESULT[0] Then Return 0
	Local $TBUFFER = DllStructCreate("byte[" & $ARESULT[5] & "]")
	Local $PBUFFER = DllStructGetPtr($TBUFFER)
	$ARESULT = DllCall("advapi32.dll", "bool", "GetTokenInformation", "handle", $HTOKEN, "int", $ICLASS, "ptr", $PBUFFER, "dword", $ARESULT[5], "dword*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	If Not $ARESULT[0] Then Return 0
	Return $TBUFFER
EndFunc
Func _SECURITY__IMPERSONATESELF($ILEVEL = 2)
	Local $ARESULT = DllCall("advapi32.dll", "bool", "ImpersonateSelf", "int", $ILEVEL)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _SECURITY__ISVALIDSID($PSID)
	Local $ARESULT = DllCall("advapi32.dll", "bool", "IsValidSid", "ptr", $PSID)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _SECURITY__LOOKUPACCOUNTNAME($SACCOUNT, $SSYSTEM = "")
	Local $TDATA = DllStructCreate("byte SID[256]")
	Local $PSID = DllStructGetPtr($TDATA, "SID")
	Local $ARESULT = DllCall("advapi32.dll", "bool", "LookupAccountNameW", "wstr", $SSYSTEM, "wstr", $SACCOUNT, "ptr", $PSID, "dword*", 256, "wstr", "", "dword*", 256, "int*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	If Not $ARESULT[0] Then Return 0
	Local $AACCT[3]
	$AACCT[0] = _SECURITY__SIDTOSTRINGSID($PSID)
	$AACCT[1] = $ARESULT[5]
	$AACCT[2] = $ARESULT[7]
	Return $AACCT
EndFunc
Func _SECURITY__LOOKUPACCOUNTSID($VSID)
	Local $PSID, $AACCT[3]
	If IsString($VSID) Then
		Local $TSID = _SECURITY__STRINGSIDTOSID($VSID)
		$PSID = DllStructGetPtr($TSID)
	Else
		$PSID = $VSID
	EndIf
	If Not _SECURITY__ISVALIDSID($PSID) Then Return SetError(-1, 0, 0)
	Local $ARESULT = DllCall("advapi32.dll", "bool", "LookupAccountSidW", "ptr", 0, "ptr", $PSID, "wstr", "", "dword*", 256, "wstr", "", "dword*", 256, "int*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	If Not $ARESULT[0] Then Return 0
	Local $AACCT[3]
	$AACCT[0] = $ARESULT[3]
	$AACCT[1] = $ARESULT[5]
	$AACCT[2] = $ARESULT[7]
	Return $AACCT
EndFunc
Func _SECURITY__LOOKUPPRIVILEGEVALUE($SSYSTEM, $SNAME)
	Local $ARESULT = DllCall("advapi32.dll", "int", "LookupPrivilegeValueW", "wstr", $SSYSTEM, "wstr", $SNAME, "int64*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetError(0, $ARESULT[0], $ARESULT[3])
EndFunc
Func _SECURITY__OPENPROCESSTOKEN($HPROCESS, $IACCESS)
	Local $ARESULT = DllCall("advapi32.dll", "int", "OpenProcessToken", "handle", $HPROCESS, "dword", $IACCESS, "ptr", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetError(0, $ARESULT[0], $ARESULT[3])
EndFunc
Func _SECURITY__OPENTHREADTOKEN($IACCESS, $HTHREAD = 0, $FOPENASSELF = False)
	If $HTHREAD = 0 Then $HTHREAD = DllCall("kernel32.dll", "handle", "GetCurrentThread")
	If @error Then Return SetError(@error, @extended, 0)
	Local $ARESULT = DllCall("advapi32.dll", "bool", "OpenThreadToken", "handle", $HTHREAD[0], "dword", $IACCESS, "int", $FOPENASSELF, "ptr*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetError(0, $ARESULT[0], $ARESULT[4])
EndFunc
Func _SECURITY__OPENTHREADTOKENEX($IACCESS, $HTHREAD = 0, $FOPENASSELF = False)
	Local $HTOKEN = _SECURITY__OPENTHREADTOKEN($IACCESS, $HTHREAD, $FOPENASSELF)
	If $HTOKEN = 0 Then
		If _WINAPI_GETLASTERROR() <> $ERROR_NO_TOKEN Then Return SetError(-3, _WINAPI_GETLASTERROR(), 0)
		If Not _SECURITY__IMPERSONATESELF() Then Return SetError(-1, _WINAPI_GETLASTERROR(), 0)
		$HTOKEN = _SECURITY__OPENTHREADTOKEN($IACCESS, $HTHREAD, $FOPENASSELF)
		If $HTOKEN = 0 Then Return SetError(-2, _WINAPI_GETLASTERROR(), 0)
	EndIf
	Return $HTOKEN
EndFunc
Func _SECURITY__SETPRIVILEGE($HTOKEN, $SPRIVILEGE, $FENABLE)
	Local $ILUID = _SECURITY__LOOKUPPRIVILEGEVALUE("", $SPRIVILEGE)
	If $ILUID = 0 Then Return SetError(-1, 0, False)
	Local $TCURRSTATE = DllStructCreate($TAGTOKEN_PRIVILEGES)
	Local $PCURRSTATE = DllStructGetPtr($TCURRSTATE)
	Local $ICURRSTATE = DllStructGetSize($TCURRSTATE)
	Local $TPREVSTATE = DllStructCreate($TAGTOKEN_PRIVILEGES)
	Local $PPREVSTATE = DllStructGetPtr($TPREVSTATE)
	Local $IPREVSTATE = DllStructGetSize($TPREVSTATE)
	Local $TREQUIRED = DllStructCreate("int Data")
	Local $PREQUIRED = DllStructGetPtr($TREQUIRED)
	DllStructSetData($TCURRSTATE, "Count", 1)
	DllStructSetData($TCURRSTATE, "LUID", $ILUID)
	If Not _SECURITY__ADJUSTTOKENPRIVILEGES($HTOKEN, False, $PCURRSTATE, $ICURRSTATE, $PPREVSTATE, $PREQUIRED) Then Return SetError(-2, @error, False)
	DllStructSetData($TPREVSTATE, "Count", 1)
	DllStructSetData($TPREVSTATE, "LUID", $ILUID)
	Local $IATTRIBUTES = DllStructGetData($TPREVSTATE, "Attributes")
	If $FENABLE Then
		$IATTRIBUTES = BitOR($IATTRIBUTES, $SE_PRIVILEGE_ENABLED)
	Else
		$IATTRIBUTES = BitAND($IATTRIBUTES, BitNOT($SE_PRIVILEGE_ENABLED))
	EndIf
	DllStructSetData($TPREVSTATE, "Attributes", $IATTRIBUTES)
	If Not _SECURITY__ADJUSTTOKENPRIVILEGES($HTOKEN, False, $PPREVSTATE, $IPREVSTATE, $PCURRSTATE, $PREQUIRED) Then Return SetError(-3, @error, False)
	Return True
EndFunc
Func _SECURITY__SIDTOSTRINGSID($PSID)
	If Not _SECURITY__ISVALIDSID($PSID) Then Return SetError(-1, 0, "")
	Local $ARESULT = DllCall("advapi32.dll", "int", "ConvertSidToStringSidW", "ptr", $PSID, "ptr*", 0)
	If @error Then Return SetError(@error, @extended, "")
	If Not $ARESULT[0] Then Return ""
	Local $TBUFFER = DllStructCreate("wchar Text[256]", $ARESULT[2])
	Local $SSID = DllStructGetData($TBUFFER, "Text")
	DllCall("Kernel32.dll", "ptr", "LocalFree", "ptr", $ARESULT[2])
	Return $SSID
EndFunc
Func _SECURITY__SIDTYPESTR($ITYPE)
	Switch $ITYPE
		Case 1
			Return "User"
		Case 2
			Return "Group"
		Case 3
			Return "Domain"
		Case 4
			Return "Alias"
		Case 5
			Return "Well Known Group"
		Case 6
			Return "Deleted Account"
		Case 7
			Return "Invalid"
		Case 8
			Return "Invalid"
		Case 9
			Return "Computer"
		Case Else
			Return "Unknown SID Type"
	EndSwitch
EndFunc
Func _SECURITY__STRINGSIDTOSID($SSID)
	Local $ARESULT = DllCall("advapi32.dll", "bool", "ConvertStringSidToSidW", "wstr", $SSID, "ptr*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	If Not $ARESULT[0] Then Return 0
	Local $ISIZE = _SECURITY__GETLENGTHSID($ARESULT[2])
	Local $TBUFFER = DllStructCreate("byte Data[" & $ISIZE & "]", $ARESULT[2])
	Local $TSID = DllStructCreate("byte Data[" & $ISIZE & "]")
	DllStructSetData($TSID, "Data", DllStructGetData($TBUFFER, "Data"))
	DllCall("kernel32.dll", "ptr", "LocalFree", "ptr", $ARESULT[2])
	Return $TSID
EndFunc
Global Const $TAGMEMMAP = "handle hProc;ulong_ptr Size;ptr Mem"
Func _MEMFREE(ByRef $TMEMMAP)
	Local $PMEMORY = DllStructGetData($TMEMMAP, "Mem")
	Local $HPROCESS = DllStructGetData($TMEMMAP, "hProc")
	Local $BRESULT = _MEMVIRTUALFREEEX($HPROCESS, $PMEMORY, 0, $MEM_RELEASE)
	DllCall("kernel32.dll", "bool", "CloseHandle", "handle", $HPROCESS)
	If @error Then Return SetError(@error, @extended, False)
	Return $BRESULT
EndFunc
Func _MEMGLOBALALLOC($IBYTES, $IFLAGS = 0)
	Local $ARESULT = DllCall("kernel32.dll", "handle", "GlobalAlloc", "uint", $IFLAGS, "ulong_ptr", $IBYTES)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _MEMGLOBALFREE($HMEM)
	Local $ARESULT = DllCall("kernel32.dll", "ptr", "GlobalFree", "handle", $HMEM)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _MEMGLOBALLOCK($HMEM)
	Local $ARESULT = DllCall("kernel32.dll", "ptr", "GlobalLock", "handle", $HMEM)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _MEMGLOBALSIZE($HMEM)
	Local $ARESULT = DllCall("kernel32.dll", "ulong_ptr", "GlobalSize", "handle", $HMEM)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _MEMGLOBALUNLOCK($HMEM)
	Local $ARESULT = DllCall("kernel32.dll", "bool", "GlobalUnlock", "handle", $HMEM)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _MEMINIT($HWND, $ISIZE, ByRef $TMEMMAP)
	Local $ARESULT = DllCall("User32.dll", "dword", "GetWindowThreadProcessId", "hwnd", $HWND, "dword*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Local $IPROCESSID = $ARESULT[2]
	If $IPROCESSID = 0 Then Return SetError(1, 0, 0)
	Local $IACCESS = BitOR($PROCESS_VM_OPERATION, $PROCESS_VM_READ, $PROCESS_VM_WRITE)
	Local $HPROCESS = __MEM_OPENPROCESS($IACCESS, False, $IPROCESSID, True)
	Local $IALLOC = BitOR($MEM_RESERVE, $MEM_COMMIT)
	Local $PMEMORY = _MEMVIRTUALALLOCEX($HPROCESS, 0, $ISIZE, $IALLOC, $PAGE_READWRITE)
	If $PMEMORY = 0 Then Return SetError(2, 0, 0)
	$TMEMMAP = DllStructCreate($TAGMEMMAP)
	DllStructSetData($TMEMMAP, "hProc", $HPROCESS)
	DllStructSetData($TMEMMAP, "Size", $ISIZE)
	DllStructSetData($TMEMMAP, "Mem", $PMEMORY)
	Return $PMEMORY
EndFunc
Func _MEMMOVEMEMORY($PSOURCE, $PDEST, $ILENGTH)
	DllCall("kernel32.dll", "none", "RtlMoveMemory", "ptr", $PDEST, "ptr", $PSOURCE, "ulong_ptr", $ILENGTH)
	If @error Then Return SetError(@error, @extended)
EndFunc
Func _MEMREAD(ByRef $TMEMMAP, $PSRCE, $PDEST, $ISIZE)
	Local $ARESULT = DllCall("kernel32.dll", "bool", "ReadProcessMemory", "handle", DllStructGetData($TMEMMAP, "hProc"), "ptr", $PSRCE, "ptr", $PDEST, "ulong_ptr", $ISIZE, "ulong_ptr*", 0)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _MEMWRITE(ByRef $TMEMMAP, $PSRCE, $PDEST = 0, $ISIZE = 0, $SSRCE = "ptr")
	If $PDEST = 0 Then $PDEST = DllStructGetData($TMEMMAP, "Mem")
	If $ISIZE = 0 Then $ISIZE = DllStructGetData($TMEMMAP, "Size")
	Local $ARESULT = DllCall("kernel32.dll", "bool", "WriteProcessMemory", "handle", DllStructGetData($TMEMMAP, "hProc"), "ptr", $PDEST, $SSRCE, $PSRCE, "ulong_ptr", $ISIZE, "ulong_ptr*", 0)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _MEMVIRTUALALLOC($PADDRESS, $ISIZE, $IALLOCATION, $IPROTECT)
	Local $ARESULT = DllCall("kernel32.dll", "ptr", "VirtualAlloc", "ptr", $PADDRESS, "ulong_ptr", $ISIZE, "dword", $IALLOCATION, "dword", $IPROTECT)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _MEMVIRTUALALLOCEX($HPROCESS, $PADDRESS, $ISIZE, $IALLOCATION, $IPROTECT)
	Local $ARESULT = DllCall("kernel32.dll", "ptr", "VirtualAllocEx", "handle", $HPROCESS, "ptr", $PADDRESS, "ulong_ptr", $ISIZE, "dword", $IALLOCATION, "dword", $IPROTECT)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _MEMVIRTUALFREE($PADDRESS, $ISIZE, $IFREETYPE)
	Local $ARESULT = DllCall("kernel32.dll", "bool", "VirtualFree", "ptr", $PADDRESS, "ulong_ptr", $ISIZE, "dword", $IFREETYPE)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _MEMVIRTUALFREEEX($HPROCESS, $PADDRESS, $ISIZE, $IFREETYPE)
	Local $ARESULT = DllCall("kernel32.dll", "bool", "VirtualFreeEx", "handle", $HPROCESS, "ptr", $PADDRESS, "ulong_ptr", $ISIZE, "dword", $IFREETYPE)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func __MEM_OPENPROCESS($IACCESS, $FINHERIT, $IPROCESSID, $FDEBUGPRIV = False)
	Local $ARESULT = DllCall("kernel32.dll", "handle", "OpenProcess", "dword", $IACCESS, "bool", $FINHERIT, "dword", $IPROCESSID)
	If @error Then Return SetError(@error, @extended, 0)
	If $ARESULT[0] Then Return $ARESULT[0]
	If Not $FDEBUGPRIV Then Return 0
	Local $HTOKEN = _SECURITY__OPENTHREADTOKENEX(BitOR($TOKEN_ADJUST_PRIVILEGES, $TOKEN_QUERY))
	If @error Then Return SetError(@error, @extended, 0)
	_SECURITY__SETPRIVILEGE($HTOKEN, "SeDebugPrivilege", True)
	Local $IERROR = @error
	Local $ILASTERROR = @extended
	Local $IRET = 0
	If Not @error Then
		$ARESULT = DllCall("kernel32.dll", "handle", "OpenProcess", "dword", $IACCESS, "bool", $FINHERIT, "dword", $IPROCESSID)
		$IERROR = @error
		$ILASTERROR = @extended
		If $ARESULT[0] Then $IRET = $ARESULT[0]
		_SECURITY__SETPRIVILEGE($HTOKEN, "SeDebugPrivilege", False)
		If @error Then
			$IERROR = @error
			$ILASTERROR = @extended
		EndIf
	EndIf
	DllCall("kernel32.dll", "bool", "CloseHandle", "handle", $HTOKEN)
	Return SetError($IERROR, $ILASTERROR, $IRET)
EndFunc
Global Const $FC_NOOVERWRITE = 0
Global Const $FC_OVERWRITE = 1
Global Const $FT_MODIFIED = 0
Global Const $FT_CREATED = 1
Global Const $FT_ACCESSED = 2
Global Const $FO_READ = 0
Global Const $FO_APPEND = 1
Global Const $FO_OVERWRITE = 2
Global Const $FO_BINARY = 16
Global Const $FO_UNICODE = 32
Global Const $FO_UTF16_LE = 32
Global Const $FO_UTF16_BE = 64
Global Const $FO_UTF8 = 128
Global Const $FO_UTF8_NOBOM = 256
Global Const $EOF = -1
Global Const $FD_FILEMUSTEXIST = 1
Global Const $FD_PATHMUSTEXIST = 2
Global Const $FD_MULTISELECT = 4
Global Const $FD_PROMPTCREATENEW = 8
Global Const $FD_PROMPTOVERWRITE = 16
Global Const $CREATE_NEW = 1
Global Const $CREATE_ALWAYS = 2
Global Const $OPEN_EXISTING = 3
Global Const $OPEN_ALWAYS = 4
Global Const $TRUNCATE_EXISTING = 5
Global Const $INVALID_SET_FILE_POINTER = -1
Global Const $FILE_BEGIN = 0
Global Const $FILE_CURRENT = 1
Global Const $FILE_END = 2
Global Const $FILE_ATTRIBUTE_READONLY = 1
Global Const $FILE_ATTRIBUTE_HIDDEN = 2
Global Const $FILE_ATTRIBUTE_SYSTEM = 4
Global Const $FILE_ATTRIBUTE_DIRECTORY = 16
Global Const $FILE_ATTRIBUTE_ARCHIVE = 32
Global Const $FILE_ATTRIBUTE_DEVICE = 64
Global Const $FILE_ATTRIBUTE_NORMAL = 128
Global Const $FILE_ATTRIBUTE_TEMPORARY = 256
Global Const $FILE_ATTRIBUTE_SPARSE_FILE = 512
Global Const $FILE_ATTRIBUTE_REPARSE_POINT = 1024
Global Const $FILE_ATTRIBUTE_COMPRESSED = 2048
Global Const $FILE_ATTRIBUTE_OFFLINE = 4096
Global Const $FILE_ATTRIBUTE_NOT_CONTENT_INDEXED = 8192
Global Const $FILE_ATTRIBUTE_ENCRYPTED = 16384
Global Const $FILE_SHARE_READ = 1
Global Const $FILE_SHARE_WRITE = 2
Global Const $FILE_SHARE_DELETE = 4
Global Const $GENERIC_ALL = 268435456
Global Const $GENERIC_EXECUTE = 536870912
Global Const $GENERIC_WRITE = 1073741824
Global Const $GENERIC_READ = -2147483648
Func _SENDMESSAGE($HWND, $IMSG, $WPARAM = 0, $LPARAM = 0, $IRETURN = 0, $WPARAMTYPE = "wparam", $LPARAMTYPE = "lparam", $SRETURNTYPE = "lresult")
	Local $ARESULT = DllCall("user32.dll", $SRETURNTYPE, "SendMessageW", "hwnd", $HWND, "uint", $IMSG, $WPARAMTYPE, $WPARAM, $LPARAMTYPE, $LPARAM)
	If @error Then Return SetError(@error, @extended, "")
	If $IRETURN >= 0 And $IRETURN <= 4 Then Return $ARESULT[$IRETURN]
	Return $ARESULT
EndFunc
Func _SENDMESSAGEA($HWND, $IMSG, $WPARAM = 0, $LPARAM = 0, $IRETURN = 0, $WPARAMTYPE = "wparam", $LPARAMTYPE = "lparam", $SRETURNTYPE = "lresult")
	Local $ARESULT = DllCall("user32.dll", $SRETURNTYPE, "SendMessageA", "hwnd", $HWND, "uint", $IMSG, $WPARAMTYPE, $WPARAM, $LPARAMTYPE, $LPARAM)
	If @error Then Return SetError(@error, @extended, "")
	If $IRETURN >= 0 And $IRETURN <= 4 Then Return $ARESULT[$IRETURN]
	Return $ARESULT
EndFunc
Global $__GAINPROCESS_WINAPI[64][2] = [[0, 0]]
Global $__GAWINLIST_WINAPI[64][2] = [[0, 0]]
Global Const $__WINAPICONSTANT_WM_SETFONT = 48
Global Const $__WINAPICONSTANT_FW_NORMAL = 400
Global Const $__WINAPICONSTANT_DEFAULT_CHARSET = 1
Global Const $__WINAPICONSTANT_OUT_DEFAULT_PRECIS = 0
Global Const $__WINAPICONSTANT_CLIP_DEFAULT_PRECIS = 0
Global Const $__WINAPICONSTANT_DEFAULT_QUALITY = 0
Global Const $__WINAPICONSTANT_FORMAT_MESSAGE_ALLOCATE_BUFFER = 256
Global Const $__WINAPICONSTANT_FORMAT_MESSAGE_FROM_SYSTEM = 4096
Global Const $__WINAPICONSTANT_LOGPIXELSX = 88
Global Const $__WINAPICONSTANT_LOGPIXELSY = 90
Global Const $HGDI_ERROR = Ptr(-1)
Global Const $INVALID_HANDLE_VALUE = Ptr(-1)
Global Const $CLR_INVALID = -1
Global Const $__WINAPICONSTANT_FLASHW_CAPTION = 1
Global Const $__WINAPICONSTANT_FLASHW_TRAY = 2
Global Const $__WINAPICONSTANT_FLASHW_TIMER = 4
Global Const $__WINAPICONSTANT_FLASHW_TIMERNOFG = 12
Global Const $__WINAPICONSTANT_GW_HWNDNEXT = 2
Global Const $__WINAPICONSTANT_GW_CHILD = 5
Global Const $__WINAPICONSTANT_DI_MASK = 1
Global Const $__WINAPICONSTANT_DI_IMAGE = 2
Global Const $__WINAPICONSTANT_DI_NORMAL = 3
Global Const $__WINAPICONSTANT_DI_COMPAT = 4
Global Const $__WINAPICONSTANT_DI_DEFAULTSIZE = 8
Global Const $__WINAPICONSTANT_DI_NOMIRROR = 16
Global Const $__WINAPICONSTANT_DISPLAY_DEVICE_ATTACHED_TO_DESKTOP = 1
Global Const $__WINAPICONSTANT_DISPLAY_DEVICE_PRIMARY_DEVICE = 4
Global Const $__WINAPICONSTANT_DISPLAY_DEVICE_MIRRORING_DRIVER = 8
Global Const $__WINAPICONSTANT_DISPLAY_DEVICE_VGA_COMPATIBLE = 16
Global Const $__WINAPICONSTANT_DISPLAY_DEVICE_REMOVABLE = 32
Global Const $__WINAPICONSTANT_DISPLAY_DEVICE_MODESPRUNED = 134217728
Global Const $NULL_BRUSH = 5
Global Const $NULL_PEN = 8
Global Const $BLACK_BRUSH = 4
Global Const $DKGRAY_BRUSH = 3
Global Const $DC_BRUSH = 18
Global Const $GRAY_BRUSH = 2
Global Const $HOLLOW_BRUSH = $NULL_BRUSH
Global Const $LTGRAY_BRUSH = 1
Global Const $WHITE_BRUSH = 0
Global Const $BLACK_PEN = 7
Global Const $DC_PEN = 19
Global Const $WHITE_PEN = 6
Global Const $ANSI_FIXED_FONT = 11
Global Const $ANSI_VAR_FONT = 12
Global Const $DEVICE_DEFAULT_FONT = 14
Global Const $DEFAULT_GUI_FONT = 17
Global Const $OEM_FIXED_FONT = 10
Global Const $SYSTEM_FONT = 13
Global Const $SYSTEM_FIXED_FONT = 16
Global Const $DEFAULT_PALETTE = 15
Global Const $MB_PRECOMPOSED = 1
Global Const $MB_COMPOSITE = 2
Global Const $MB_USEGLYPHCHARS = 4
Global Const $ULW_ALPHA = 2
Global Const $ULW_COLORKEY = 1
Global Const $ULW_OPAQUE = 4
Global Const $WH_CALLWNDPROC = 4
Global Const $WH_CALLWNDPROCRET = 12
Global Const $WH_CBT = 5
Global Const $WH_DEBUG = 9
Global Const $WH_FOREGROUNDIDLE = 11
Global Const $WH_GETMESSAGE = 3
Global Const $WH_JOURNALPLAYBACK = 1
Global Const $WH_JOURNALRECORD = 0
Global Const $WH_KEYBOARD = 2
Global Const $WH_KEYBOARD_LL = 13
Global Const $WH_MOUSE = 7
Global Const $WH_MOUSE_LL = 14
Global Const $WH_MSGFILTER = -1
Global Const $WH_SHELL = 10
Global Const $WH_SYSMSGFILTER = 6
Global Const $WPF_ASYNCWINDOWPLACEMENT = 4
Global Const $WPF_RESTORETOMAXIMIZED = 2
Global Const $WPF_SETMINPOSITION = 1
Global Const $KF_EXTENDED = 256
Global Const $KF_ALTDOWN = 8192
Global Const $KF_UP = 32768
Global Const $LLKHF_EXTENDED = BitShift($KF_EXTENDED, 8)
Global Const $LLKHF_INJECTED = 16
Global Const $LLKHF_ALTDOWN = BitShift($KF_ALTDOWN, 8)
Global Const $LLKHF_UP = BitShift($KF_UP, 8)
Global Const $OFN_ALLOWMULTISELECT = 512
Global Const $OFN_CREATEPROMPT = 8192
Global Const $OFN_DONTADDTORECENT = 33554432
Global Const $OFN_ENABLEHOOK = 32
Global Const $OFN_ENABLEINCLUDENOTIFY = 4194304
Global Const $OFN_ENABLESIZING = 8388608
Global Const $OFN_ENABLETEMPLATE = 64
Global Const $OFN_ENABLETEMPLATEHANDLE = 128
Global Const $OFN_EXPLORER = 524288
Global Const $OFN_EXTENSIONDIFFERENT = 1024
Global Const $OFN_FILEMUSTEXIST = 4096
Global Const $OFN_FORCESHOWHIDDEN = 268435456
Global Const $OFN_HIDEREADONLY = 4
Global Const $OFN_LONGNAMES = 2097152
Global Const $OFN_NOCHANGEDIR = 8
Global Const $OFN_NODEREFERENCELINKS = 1048576
Global Const $OFN_NOLONGNAMES = 262144
Global Const $OFN_NONETWORKBUTTON = 131072
Global Const $OFN_NOREADONLYRETURN = 32768
Global Const $OFN_NOTESTFILECREATE = 65536
Global Const $OFN_NOVALIDATE = 256
Global Const $OFN_OVERWRITEPROMPT = 2
Global Const $OFN_PATHMUSTEXIST = 2048
Global Const $OFN_READONLY = 1
Global Const $OFN_SHAREAWARE = 16384
Global Const $OFN_SHOWHELP = 16
Global Const $OFN_EX_NOPLACESBAR = 1
Global Const $TAGCURSORINFO = "dword Size;dword Flags;handle hCursor;" & $TAGPOINT
Global Const $TAGDISPLAY_DEVICE = "dword Size;wchar Name[32];wchar String[128];dword Flags;wchar ID[128];wchar Key[128]"
Global Const $TAGFLASHWINFO = "uint Size;hwnd hWnd;dword Flags;uint Count;dword TimeOut"
Global Const $TAGICONINFO = "bool Icon;dword XHotSpot;dword YHotSpot;handle hMask;handle hColor"
Global Const $TAGMEMORYSTATUSEX = "dword Length;dword MemoryLoad;" & "uint64 TotalPhys;uint64 AvailPhys;uint64 TotalPageFile;uint64 AvailPageFile;" & "uint64 TotalVirtual;uint64 AvailVirtual;uint64 AvailExtendedVirtual"
Func _WINAPI_ATTACHCONSOLE($IPROCESSID = -1)
	Local $ARESULT = DllCall("kernel32.dll", "bool", "AttachConsole", "dword", $IPROCESSID)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_ATTACHTHREADINPUT($IATTACH, $IATTACHTO, $FATTACH)
	Local $ARESULT = DllCall("user32.dll", "bool", "AttachThreadInput", "dword", $IATTACH, "dword", $IATTACHTO, "bool", $FATTACH)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_BEEP($IFREQ = 500, $IDURATION = 1000)
	Local $ARESULT = DllCall("kernel32.dll", "bool", "Beep", "dword", $IFREQ, "dword", $IDURATION)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_BITBLT($HDESTDC, $IXDEST, $IYDEST, $IWIDTH, $IHEIGHT, $HSRCDC, $IXSRC, $IYSRC, $IROP)
	Local $ARESULT = DllCall("gdi32.dll", "bool", "BitBlt", "handle", $HDESTDC, "int", $IXDEST, "int", $IYDEST, "int", $IWIDTH, "int", $IHEIGHT, "handle", $HSRCDC, "int", $IXSRC, "int", $IYSRC, "dword", $IROP)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_CALLNEXTHOOKEX($HHK, $ICODE, $WPARAM, $LPARAM)
	Local $ARESULT = DllCall("user32.dll", "lresult", "CallNextHookEx", "handle", $HHK, "int", $ICODE, "wparam", $WPARAM, "lparam", $LPARAM)
	If @error Then Return SetError(@error, @extended, -1)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_CALLWINDOWPROC($LPPREVWNDFUNC, $HWND, $MSG, $WPARAM, $LPARAM)
	Local $ARESULT = DllCall("user32.dll", "lresult", "CallWindowProc", "ptr", $LPPREVWNDFUNC, "hwnd", $HWND, "uint", $MSG, "wparam", $WPARAM, "lparam", $LPARAM)
	If @error Then Return SetError(@error, @extended, -1)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_CLIENTTOSCREEN($HWND, ByRef $TPOINT)
	Local $PPOINT = DllStructGetPtr($TPOINT)
	DllCall("user32.dll", "bool", "ClientToScreen", "hwnd", $HWND, "ptr", $PPOINT)
	Return SetError(@error, @extended, $TPOINT)
EndFunc
Func _WINAPI_CLOSEHANDLE($HOBJECT)
	Local $ARESULT = DllCall("kernel32.dll", "bool", "CloseHandle", "handle", $HOBJECT)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_COMBINERGN($HRGNDEST, $HRGNSRC1, $HRGNSRC2, $ICOMBINEMODE)
	Local $ARESULT = DllCall("gdi32.dll", "int", "CombineRgn", "handle", $HRGNDEST, "handle", $HRGNSRC1, "handle", $HRGNSRC2, "int", $ICOMBINEMODE)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_COMMDLGEXTENDEDERROR()
	Local Const $CDERR_DIALOGFAILURE = 65535
	Local Const $CDERR_FINDRESFAILURE = 6
	Local Const $CDERR_INITIALIZATION = 2
	Local Const $CDERR_LOADRESFAILURE = 7
	Local Const $CDERR_LOADSTRFAILURE = 5
	Local Const $CDERR_LOCKRESFAILURE = 8
	Local Const $CDERR_MEMALLOCFAILURE = 9
	Local Const $CDERR_MEMLOCKFAILURE = 10
	Local Const $CDERR_NOHINSTANCE = 4
	Local Const $CDERR_NOHOOK = 11
	Local Const $CDERR_NOTEMPLATE = 3
	Local Const $CDERR_REGISTERMSGFAIL = 12
	Local Const $CDERR_STRUCTSIZE = 1
	Local Const $FNERR_BUFFERTOOSMALL = 12291
	Local Const $FNERR_INVALIDFILENAME = 12290
	Local Const $FNERR_SUBCLASSFAILURE = 12289
	Local $ARESULT = DllCall("comdlg32.dll", "dword", "CommDlgExtendedError")
	If @error Then Return SetError(@error, @extended, 0)
	Switch $ARESULT[0]
		Case $CDERR_DIALOGFAILURE
			Return SetError($ARESULT[0], 0, "The dialog box could not be created." & @LF & "The common dialog box function's call to the DialogBox function failed." & @LF & "For example, this error occurs if the common dialog box call specifies an invalid window handle.")
		Case $CDERR_FINDRESFAILURE
			Return SetError($ARESULT[0], 0, "The common dialog box function failed to find a specified resource.")
		Case $CDERR_INITIALIZATION
			Return SetError($ARESULT[0], 0, "The common dialog box function failed during initialization." & @LF & "This error often occurs when sufficient memory is not available.")
		Case $CDERR_LOADRESFAILURE
			Return SetError($ARESULT[0], 0, "The common dialog box function failed to load a specified resource.")
		Case $CDERR_LOADSTRFAILURE
			Return SetError($ARESULT[0], 0, "The common dialog box function failed to load a specified string.")
		Case $CDERR_LOCKRESFAILURE
			Return SetError($ARESULT[0], 0, "The common dialog box function failed to lock a specified resource.")
		Case $CDERR_MEMALLOCFAILURE
			Return SetError($ARESULT[0], 0, "The common dialog box function was unable to allocate memory for internal structures.")
		Case $CDERR_MEMLOCKFAILURE
			Return SetError($ARESULT[0], 0, "The common dialog box function was unable to lock the memory associated with a handle.")
		Case $CDERR_NOHINSTANCE
			Return SetError($ARESULT[0], 0, "The ENABLETEMPLATE flag was set in the Flags member of the initialization structure for the corresponding common dialog box," & @LF & "but you failed to provide a corresponding instance handle.")
		Case $CDERR_NOHOOK
			Return SetError($ARESULT[0], 0, "The ENABLEHOOK flag was set in the Flags member of the initialization structure for the corresponding common dialog box," & @LF & "but you failed to provide a pointer to a corresponding hook procedure.")
		Case $CDERR_NOTEMPLATE
			Return SetError($ARESULT[0], 0, "The ENABLETEMPLATE flag was set in the Flags member of the initialization structure for the corresponding common dialog box," & @LF & "but you failed to provide a corresponding template.")
		Case $CDERR_REGISTERMSGFAIL
			Return SetError($ARESULT[0], 0, "The RegisterWindowMessage function returned an error code when it was called by the common dialog box function.")
		Case $CDERR_STRUCTSIZE
			Return SetError($ARESULT[0], 0, "The lStructSize member of the initialization structure for the corresponding common dialog box is invalid")
		Case $FNERR_BUFFERTOOSMALL
			Return SetError($ARESULT[0], 0, "The buffer pointed to by the lpstrFile member of the OPENFILENAME structure is too small for the file name specified by the user." & @LF & "The first two bytes of the lpstrFile buffer contain an integer value specifying the size, in TCHARs, required to receive the full name.")
		Case $FNERR_INVALIDFILENAME
			Return SetError($ARESULT[0], 0, "A file name is invalid.")
		Case $FNERR_SUBCLASSFAILURE
			Return SetError($ARESULT[0], 0, "An attempt to subclass a list box failed because sufficient memory was not available.")
	EndSwitch
	Return Hex($ARESULT[0])
EndFunc
Func _WINAPI_COPYICON($HICON)
	Local $ARESULT = DllCall("user32.dll", "handle", "CopyIcon", "handle", $HICON)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_CREATEBITMAP($IWIDTH, $IHEIGHT, $IPLANES = 1, $IBITSPERPEL = 1, $PBITS = 0)
	Local $ARESULT = DllCall("gdi32.dll", "handle", "CreateBitmap", "int", $IWIDTH, "int", $IHEIGHT, "uint", $IPLANES, "uint", $IBITSPERPEL, "ptr", $PBITS)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_CREATECOMPATIBLEBITMAP($HDC, $IWIDTH, $IHEIGHT)
	Local $ARESULT = DllCall("gdi32.dll", "handle", "CreateCompatibleBitmap", "handle", $HDC, "int", $IWIDTH, "int", $IHEIGHT)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_CREATECOMPATIBLEDC($HDC)
	Local $ARESULT = DllCall("gdi32.dll", "handle", "CreateCompatibleDC", "handle", $HDC)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_CREATEEVENT($PATTRIBUTES = 0, $FMANUALRESET = True, $FINITIALSTATE = True, $SNAME = "")
	Local $SNAMETYPE = "wstr"
	If $SNAME = "" Then
		$SNAME = 0
		$SNAMETYPE = "ptr"
	EndIf
	Local $ARESULT = DllCall("kernel32.dll", "handle", "CreateEventW", "ptr", $PATTRIBUTES, "bool", $FMANUALRESET, "bool", $FINITIALSTATE, $SNAMETYPE, $SNAME)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_CREATEFILE($SFILENAME, $ICREATION, $IACCESS = 4, $ISHARE = 0, $IATTRIBUTES = 0, $PSECURITY = 0)
	Local $IDA = 0, $ISM = 0, $ICD = 0, $IFA = 0
	If BitAND($IACCESS, 1) <> 0 Then $IDA = BitOR($IDA, $GENERIC_EXECUTE)
	If BitAND($IACCESS, 2) <> 0 Then $IDA = BitOR($IDA, $GENERIC_READ)
	If BitAND($IACCESS, 4) <> 0 Then $IDA = BitOR($IDA, $GENERIC_WRITE)
	If BitAND($ISHARE, 1) <> 0 Then $ISM = BitOR($ISM, $FILE_SHARE_DELETE)
	If BitAND($ISHARE, 2) <> 0 Then $ISM = BitOR($ISM, $FILE_SHARE_READ)
	If BitAND($ISHARE, 4) <> 0 Then $ISM = BitOR($ISM, $FILE_SHARE_WRITE)
	Switch $ICREATION
		Case 0
			$ICD = $CREATE_NEW
		Case 1
			$ICD = $CREATE_ALWAYS
		Case 2
			$ICD = $OPEN_EXISTING
		Case 3
			$ICD = $OPEN_ALWAYS
		Case 4
			$ICD = $TRUNCATE_EXISTING
	EndSwitch
	If BitAND($IATTRIBUTES, 1) <> 0 Then $IFA = BitOR($IFA, $FILE_ATTRIBUTE_ARCHIVE)
	If BitAND($IATTRIBUTES, 2) <> 0 Then $IFA = BitOR($IFA, $FILE_ATTRIBUTE_HIDDEN)
	If BitAND($IATTRIBUTES, 4) <> 0 Then $IFA = BitOR($IFA, $FILE_ATTRIBUTE_READONLY)
	If BitAND($IATTRIBUTES, 8) <> 0 Then $IFA = BitOR($IFA, $FILE_ATTRIBUTE_SYSTEM)
	Local $ARESULT = DllCall("kernel32.dll", "handle", "CreateFileW", "wstr", $SFILENAME, "dword", $IDA, "dword", $ISM, "ptr", $PSECURITY, "dword", $ICD, "dword", $IFA, "ptr", 0)
	If @error Or $ARESULT[0] = Ptr(-1) Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_CREATEFONT($NHEIGHT, $NWIDTH, $NESCAPE = 0, $NORIENTN = 0, $FNWEIGHT = $__WINAPICONSTANT_FW_NORMAL, $BITALIC = False, $BUNDERLINE = False, $BSTRIKEOUT = False, $NCHARSET = $__WINAPICONSTANT_DEFAULT_CHARSET, $NOUTPUTPREC = $__WINAPICONSTANT_OUT_DEFAULT_PRECIS, $NCLIPPREC = $__WINAPICONSTANT_CLIP_DEFAULT_PRECIS, $NQUALITY = $__WINAPICONSTANT_DEFAULT_QUALITY, $NPITCH = 0, $SZFACE = "Arial")
	Local $ARESULT = DllCall("gdi32.dll", "handle", "CreateFontW", "int", $NHEIGHT, "int", $NWIDTH, "int", $NESCAPE, "int", $NORIENTN, "int", $FNWEIGHT, "dword", $BITALIC, "dword", $BUNDERLINE, "dword", $BSTRIKEOUT, "dword", $NCHARSET, "dword", $NOUTPUTPREC, "dword", $NCLIPPREC, "dword", $NQUALITY, "dword", $NPITCH, "wstr", $SZFACE)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_CREATEFONTINDIRECT($TLOGFONT)
	Local $ARESULT = DllCall("gdi32.dll", "handle", "CreateFontIndirectW", "ptr", DllStructGetPtr($TLOGFONT))
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_CREATEPEN($IPENSTYLE, $IWIDTH, $NCOLOR)
	Local $ARESULT = DllCall("gdi32.dll", "handle", "CreatePen", "int", $IPENSTYLE, "int", $IWIDTH, "dword", $NCOLOR)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_CREATEPROCESS($SAPPNAME, $SCOMMAND, $PSECURITY, $PTHREAD, $FINHERIT, $IFLAGS, $PENVIRON, $SDIR, $PSTARTUPINFO, $PPROCESS)
	Local $PCOMMAND = 0
	Local $SAPPNAMETYPE = "wstr", $SDIRTYPE = "wstr"
	If $SAPPNAME = "" Then
		$SAPPNAMETYPE = "ptr"
		$SAPPNAME = 0
	EndIf
	If $SCOMMAND <> "" Then
		Local $TCOMMAND = DllStructCreate("wchar Text[" & 260 + 1 & "]")
		$PCOMMAND = DllStructGetPtr($TCOMMAND)
		DllStructSetData($TCOMMAND, "Text", $SCOMMAND)
	EndIf
	If $SDIR = "" Then
		$SDIRTYPE = "ptr"
		$SDIR = 0
	EndIf
	Local $ARESULT = DllCall("kernel32.dll", "bool", "CreateProcessW", $SAPPNAMETYPE, $SAPPNAME, "ptr", $PCOMMAND, "ptr", $PSECURITY, "ptr", $PTHREAD, "bool", $FINHERIT, "dword", $IFLAGS, "ptr", $PENVIRON, $SDIRTYPE, $SDIR, "ptr", $PSTARTUPINFO, "ptr", $PPROCESS)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_CREATERECTRGN($ILEFTRECT, $ITOPRECT, $IRIGHTRECT, $IBOTTOMRECT)
	Local $ARESULT = DllCall("gdi32.dll", "handle", "CreateRectRgn", "int", $ILEFTRECT, "int", $ITOPRECT, "int", $IRIGHTRECT, "int", $IBOTTOMRECT)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_CREATEROUNDRECTRGN($ILEFTRECT, $ITOPRECT, $IRIGHTRECT, $IBOTTOMRECT, $IWIDTHELLIPSE, $IHEIGHTELLIPSE)
	Local $ARESULT = DllCall("gdi32.dll", "handle", "CreateRoundRectRgn", "int", $ILEFTRECT, "int", $ITOPRECT, "int", $IRIGHTRECT, "int", $IBOTTOMRECT, "int", $IWIDTHELLIPSE, "int", $IHEIGHTELLIPSE)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_CREATESOLIDBITMAP($HWND, $ICOLOR, $IWIDTH, $IHEIGHT, $BRGB = 1)
	Local $HDC = _WINAPI_GETDC($HWND)
	Local $HDESTDC = _WINAPI_CREATECOMPATIBLEDC($HDC)
	Local $HBITMAP = _WINAPI_CREATECOMPATIBLEBITMAP($HDC, $IWIDTH, $IHEIGHT)
	Local $HOLD = _WINAPI_SELECTOBJECT($HDESTDC, $HBITMAP)
	Local $TRECT = DllStructCreate($TAGRECT)
	DllStructSetData($TRECT, 1, 0)
	DllStructSetData($TRECT, 2, 0)
	DllStructSetData($TRECT, 3, $IWIDTH)
	DllStructSetData($TRECT, 4, $IHEIGHT)
	If $BRGB Then
		$ICOLOR = BitOR(BitAND($ICOLOR, 65280), BitShift(BitAND($ICOLOR, 255), -16), BitShift(BitAND($ICOLOR, 16711680), 16))
	EndIf
	Local $HBRUSH = _WINAPI_CREATESOLIDBRUSH($ICOLOR)
	_WINAPI_FILLRECT($HDESTDC, DllStructGetPtr($TRECT), $HBRUSH)
	If @error Then
		_WINAPI_DELETEOBJECT($HBITMAP)
		$HBITMAP = 0
	EndIf
	_WINAPI_DELETEOBJECT($HBRUSH)
	_WINAPI_RELEASEDC($HWND, $HDC)
	_WINAPI_SELECTOBJECT($HDESTDC, $HOLD)
	_WINAPI_DELETEDC($HDESTDC)
	If Not $HBITMAP Then Return SetError(1, 0, 0)
	Return $HBITMAP
EndFunc
Func _WINAPI_CREATESOLIDBRUSH($NCOLOR)
	Local $ARESULT = DllCall("gdi32.dll", "handle", "CreateSolidBrush", "dword", $NCOLOR)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_CREATEWINDOWEX($IEXSTYLE, $SCLASS, $SNAME, $ISTYLE, $IX, $IY, $IWIDTH, $IHEIGHT, $HPARENT, $HMENU = 0, $HINSTANCE = 0, $PPARAM = 0)
	If $HINSTANCE = 0 Then $HINSTANCE = _WINAPI_GETMODULEHANDLE("")
	Local $ARESULT = DllCall("user32.dll", "hwnd", "CreateWindowExW", "dword", $IEXSTYLE, "wstr", $SCLASS, "wstr", $SNAME, "dword", $ISTYLE, "int", $IX, "int", $IY, "int", $IWIDTH, "int", $IHEIGHT, "hwnd", $HPARENT, "handle", $HMENU, "handle", $HINSTANCE, "ptr", $PPARAM)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_DEFWINDOWPROC($HWND, $IMSG, $IWPARAM, $ILPARAM)
	Local $ARESULT = DllCall("user32.dll", "lresult", "DefWindowProc", "hwnd", $HWND, "uint", $IMSG, "wparam", $IWPARAM, "lparam", $ILPARAM)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_DELETEDC($HDC)
	Local $ARESULT = DllCall("gdi32.dll", "bool", "DeleteDC", "handle", $HDC)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_DELETEOBJECT($HOBJECT)
	Local $ARESULT = DllCall("gdi32.dll", "bool", "DeleteObject", "handle", $HOBJECT)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_DESTROYICON($HICON)
	Local $ARESULT = DllCall("user32.dll", "bool", "DestroyIcon", "handle", $HICON)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_DESTROYWINDOW($HWND)
	Local $ARESULT = DllCall("user32.dll", "bool", "DestroyWindow", "hwnd", $HWND)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_DRAWEDGE($HDC, $PTRRECT, $NEDGETYPE, $GRFFLAGS)
	Local $ARESULT = DllCall("user32.dll", "bool", "DrawEdge", "handle", $HDC, "ptr", $PTRRECT, "uint", $NEDGETYPE, "uint", $GRFFLAGS)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_DRAWFRAMECONTROL($HDC, $PTRRECT, $NTYPE, $NSTATE)
	Local $ARESULT = DllCall("user32.dll", "bool", "DrawFrameControl", "handle", $HDC, "ptr", $PTRRECT, "uint", $NTYPE, "uint", $NSTATE)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_DRAWICON($HDC, $IX, $IY, $HICON)
	Local $ARESULT = DllCall("user32.dll", "bool", "DrawIcon", "handle", $HDC, "int", $IX, "int", $IY, "handle", $HICON)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_DRAWICONEX($HDC, $IX, $IY, $HICON, $IWIDTH = 0, $IHEIGHT = 0, $ISTEP = 0, $HBRUSH = 0, $IFLAGS = 3)
	Local $IOPTIONS
	Switch $IFLAGS
		Case 1
			$IOPTIONS = $__WINAPICONSTANT_DI_MASK
		Case 2
			$IOPTIONS = $__WINAPICONSTANT_DI_IMAGE
		Case 3
			$IOPTIONS = $__WINAPICONSTANT_DI_NORMAL
		Case 4
			$IOPTIONS = $__WINAPICONSTANT_DI_COMPAT
		Case 5
			$IOPTIONS = $__WINAPICONSTANT_DI_DEFAULTSIZE
		Case Else
			$IOPTIONS = $__WINAPICONSTANT_DI_NOMIRROR
	EndSwitch
	Local $ARESULT = DllCall("user32.dll", "bool", "DrawIconEx", "handle", $HDC, "int", $IX, "int", $IY, "handle", $HICON, "int", $IWIDTH, "int", $IHEIGHT, "uint", $ISTEP, "handle", $HBRUSH, "uint", $IOPTIONS)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_DRAWLINE($HDC, $IX1, $IY1, $IX2, $IY2)
	_WINAPI_MOVETO($HDC, $IX1, $IY1)
	If @error Then Return SetError(@error, @extended, False)
	_WINAPI_LINETO($HDC, $IX2, $IY2)
	If @error Then Return SetError(@error, @extended, False)
	Return True
EndFunc
Func _WINAPI_DRAWTEXT($HDC, $STEXT, ByRef $TRECT, $IFLAGS)
	Local $ARESULT = DllCall("user32.dll", "int", "DrawTextW", "handle", $HDC, "wstr", $STEXT, "int", -1, "ptr", DllStructGetPtr($TRECT), "uint", $IFLAGS)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_ENABLEWINDOW($HWND, $FENABLE = True)
	Local $ARESULT = DllCall("user32.dll", "bool", "EnableWindow", "hwnd", $HWND, "bool", $FENABLE)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_ENUMDISPLAYDEVICES($SDEVICE, $IDEVNUM)
	Local $PNAME = 0, $IFLAGS = 0, $ADEVICE[5]
	If $SDEVICE <> "" Then
		Local $TNAME = DllStructCreate("wchar Text[" & StringLen($SDEVICE) + 1 & "]")
		$PNAME = DllStructGetPtr($TNAME)
		DllStructSetData($TNAME, "Text", $SDEVICE)
	EndIf
	Local $TDEVICE = DllStructCreate($TAGDISPLAY_DEVICE)
	Local $PDEVICE = DllStructGetPtr($TDEVICE)
	Local $IDEVICE = DllStructGetSize($TDEVICE)
	DllStructSetData($TDEVICE, "Size", $IDEVICE)
	DllCall("user32.dll", "bool", "EnumDisplayDevicesW", "ptr", $PNAME, "dword", $IDEVNUM, "ptr", $PDEVICE, "dword", 1)
	If @error Then Return SetError(@error, @extended, 0)
	Local $IN = DllStructGetData($TDEVICE, "Flags")
	If BitAND($IN, $__WINAPICONSTANT_DISPLAY_DEVICE_ATTACHED_TO_DESKTOP) <> 0 Then $IFLAGS = BitOR($IFLAGS, 1)
	If BitAND($IN, $__WINAPICONSTANT_DISPLAY_DEVICE_PRIMARY_DEVICE) <> 0 Then $IFLAGS = BitOR($IFLAGS, 2)
	If BitAND($IN, $__WINAPICONSTANT_DISPLAY_DEVICE_MIRRORING_DRIVER) <> 0 Then $IFLAGS = BitOR($IFLAGS, 4)
	If BitAND($IN, $__WINAPICONSTANT_DISPLAY_DEVICE_VGA_COMPATIBLE) <> 0 Then $IFLAGS = BitOR($IFLAGS, 8)
	If BitAND($IN, $__WINAPICONSTANT_DISPLAY_DEVICE_REMOVABLE) <> 0 Then $IFLAGS = BitOR($IFLAGS, 16)
	If BitAND($IN, $__WINAPICONSTANT_DISPLAY_DEVICE_MODESPRUNED) <> 0 Then $IFLAGS = BitOR($IFLAGS, 32)
	$ADEVICE[0] = True
	$ADEVICE[1] = DllStructGetData($TDEVICE, "Name")
	$ADEVICE[2] = DllStructGetData($TDEVICE, "String")
	$ADEVICE[3] = $IFLAGS
	$ADEVICE[4] = DllStructGetData($TDEVICE, "ID")
	Return $ADEVICE
EndFunc
Func _WINAPI_ENUMWINDOWS($FVISIBLE = True, $HWND = Default)
	__WINAPI_ENUMWINDOWSINIT()
	If $HWND = Default Then $HWND = _WINAPI_GETDESKTOPWINDOW()
	__WINAPI_ENUMWINDOWSCHILD($HWND, $FVISIBLE)
	Return $__GAWINLIST_WINAPI
EndFunc
Func __WINAPI_ENUMWINDOWSADD($HWND, $SCLASS = "")
	If $SCLASS = "" Then $SCLASS = _WINAPI_GETCLASSNAME($HWND)
	$__GAWINLIST_WINAPI[0][0] += 1
	Local $ICOUNT = $__GAWINLIST_WINAPI[0][0]
	If $ICOUNT >= $__GAWINLIST_WINAPI[0][1] Then
		ReDim $__GAWINLIST_WINAPI[$ICOUNT + 64][2]
		$__GAWINLIST_WINAPI[0][1] += 64
	EndIf
	$__GAWINLIST_WINAPI[$ICOUNT][0] = $HWND
	$__GAWINLIST_WINAPI[$ICOUNT][1] = $SCLASS
EndFunc
Func __WINAPI_ENUMWINDOWSCHILD($HWND, $FVISIBLE = True)
	$HWND = _WINAPI_GETWINDOW($HWND, $__WINAPICONSTANT_GW_CHILD)
	While $HWND <> 0
		IF (Not $FVISIBLE) Or _WINAPI_ISWINDOWVISIBLE($HWND) Then
			__WINAPI_ENUMWINDOWSCHILD($HWND, $FVISIBLE)
			__WINAPI_ENUMWINDOWSADD($HWND)
		EndIf
		$HWND = _WINAPI_GETWINDOW($HWND, $__WINAPICONSTANT_GW_HWNDNEXT)
	WEnd
EndFunc
Func __WINAPI_ENUMWINDOWSINIT()
	ReDim $__GAWINLIST_WINAPI[64][2]
	$__GAWINLIST_WINAPI[0][0] = 0
	$__GAWINLIST_WINAPI[0][1] = 64
EndFunc
Func _WINAPI_ENUMWINDOWSPOPUP()
	__WINAPI_ENUMWINDOWSINIT()
	Local $HWND = _WINAPI_GETWINDOW(_WINAPI_GETDESKTOPWINDOW(), $__WINAPICONSTANT_GW_CHILD)
	Local $SCLASS
	While $HWND <> 0
		If _WINAPI_ISWINDOWVISIBLE($HWND) Then
			$SCLASS = _WINAPI_GETCLASSNAME($HWND)
			If $SCLASS = "#32768" Then
				__WINAPI_ENUMWINDOWSADD($HWND)
			ElseIf $SCLASS = "ToolbarWindow32" Then
				__WINAPI_ENUMWINDOWSADD($HWND)
			ElseIf $SCLASS = "ToolTips_Class32" Then
				__WINAPI_ENUMWINDOWSADD($HWND)
			ElseIf $SCLASS = "BaseBar" Then
				__WINAPI_ENUMWINDOWSCHILD($HWND)
			EndIf
		EndIf
		$HWND = _WINAPI_GETWINDOW($HWND, $__WINAPICONSTANT_GW_HWNDNEXT)
	WEnd
	Return $__GAWINLIST_WINAPI
EndFunc
Func _WINAPI_ENUMWINDOWSTOP()
	__WINAPI_ENUMWINDOWSINIT()
	Local $HWND = _WINAPI_GETWINDOW(_WINAPI_GETDESKTOPWINDOW(), $__WINAPICONSTANT_GW_CHILD)
	While $HWND <> 0
		If _WINAPI_ISWINDOWVISIBLE($HWND) Then __WINAPI_ENUMWINDOWSADD($HWND)
		$HWND = _WINAPI_GETWINDOW($HWND, $__WINAPICONSTANT_GW_HWNDNEXT)
	WEnd
	Return $__GAWINLIST_WINAPI
EndFunc
Func _WINAPI_EXPANDENVIRONMENTSTRINGS($SSTRING)
	Local $ARESULT = DllCall("kernel32.dll", "dword", "ExpandEnvironmentStringsW", "wstr", $SSTRING, "wstr", "", "dword", 4096)
	If @error Then Return SetError(@error, @extended, "")
	Return $ARESULT[2]
EndFunc
Func _WINAPI_EXTRACTICONEX($SFILE, $IINDEX, $PLARGE, $PSMALL, $IICONS)
	Local $ARESULT = DllCall("shell32.dll", "uint", "ExtractIconExW", "wstr", $SFILE, "int", $IINDEX, "handle", $PLARGE, "handle", $PSMALL, "uint", $IICONS)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_FATALAPPEXIT($SMESSAGE)
	DllCall("kernel32.dll", "none", "FatalAppExitW", "uint", 0, "wstr", $SMESSAGE)
	If @error Then Return SetError(@error, @extended)
EndFunc
Func _WINAPI_FILLRECT($HDC, $PTRRECT, $HBRUSH)
	Local $ARESULT
	If IsPtr($HBRUSH) Then
		$ARESULT = DllCall("user32.dll", "int", "FillRect", "handle", $HDC, "ptr", $PTRRECT, "handle", $HBRUSH)
	Else
		$ARESULT = DllCall("user32.dll", "int", "FillRect", "handle", $HDC, "ptr", $PTRRECT, "dword", $HBRUSH)
	EndIf
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_FINDEXECUTABLE($SFILENAME, $SDIRECTORY = "")
	Local $ARESULT = DllCall("shell32.dll", "INT", "FindExecutableW", "wstr", $SFILENAME, "wstr", $SDIRECTORY, "wstr", "")
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($ARESULT[0], $ARESULT[3])
EndFunc
Func _WINAPI_FINDWINDOW($SCLASSNAME, $SWINDOWNAME)
	Local $ARESULT = DllCall("user32.dll", "hwnd", "FindWindowW", "wstr", $SCLASSNAME, "wstr", $SWINDOWNAME)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_FLASHWINDOW($HWND, $FINVERT = True)
	Local $ARESULT = DllCall("user32.dll", "bool", "FlashWindow", "hwnd", $HWND, "bool", $FINVERT)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_FLASHWINDOWEX($HWND, $IFLAGS = 3, $ICOUNT = 3, $ITIMEOUT = 0)
	Local $TFLASH = DllStructCreate($TAGFLASHWINFO)
	Local $PFLASH = DllStructGetPtr($TFLASH)
	Local $IFLASH = DllStructGetSize($TFLASH)
	Local $IMODE = 0
	If BitAND($IFLAGS, 1) <> 0 Then $IMODE = BitOR($IMODE, $__WINAPICONSTANT_FLASHW_CAPTION)
	If BitAND($IFLAGS, 2) <> 0 Then $IMODE = BitOR($IMODE, $__WINAPICONSTANT_FLASHW_TRAY)
	If BitAND($IFLAGS, 4) <> 0 Then $IMODE = BitOR($IMODE, $__WINAPICONSTANT_FLASHW_TIMER)
	If BitAND($IFLAGS, 8) <> 0 Then $IMODE = BitOR($IMODE, $__WINAPICONSTANT_FLASHW_TIMERNOFG)
	DllStructSetData($TFLASH, "Size", $IFLASH)
	DllStructSetData($TFLASH, "hWnd", $HWND)
	DllStructSetData($TFLASH, "Flags", $IMODE)
	DllStructSetData($TFLASH, "Count", $ICOUNT)
	DllStructSetData($TFLASH, "Timeout", $ITIMEOUT)
	Local $ARESULT = DllCall("user32.dll", "bool", "FlashWindowEx", "ptr", $PFLASH)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_FLOATTOINT($NFLOAT)
	Local $TFLOAT = DllStructCreate("float")
	Local $TINT = DllStructCreate("int", DllStructGetPtr($TFLOAT))
	DllStructSetData($TFLOAT, 1, $NFLOAT)
	Return DllStructGetData($TINT, 1)
EndFunc
Func _WINAPI_FLUSHFILEBUFFERS($HFILE)
	Local $ARESULT = DllCall("kernel32.dll", "bool", "FlushFileBuffers", "handle", $HFILE)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_FORMATMESSAGE($IFLAGS, $PSOURCE, $IMESSAGEID, $ILANGUAGEID, ByRef $PBUFFER, $ISIZE, $VARGUMENTS)
	Local $SBUFFERTYPE = "ptr"
	If IsString($PBUFFER) Then $SBUFFERTYPE = "wstr"
	Local $ARESULT = DllCall("Kernel32.dll", "dword", "FormatMessageW", "dword", $IFLAGS, "ptr", $PSOURCE, "dword", $IMESSAGEID, "dword", $ILANGUAGEID, $SBUFFERTYPE, $PBUFFER, "dword", $ISIZE, "ptr", $VARGUMENTS)
	If @error Then Return SetError(@error, @extended, 0)
	If $SBUFFERTYPE = "wstr" Then $PBUFFER = $ARESULT[5]
	Return $ARESULT[0]
EndFunc
Func _WINAPI_FRAMERECT($HDC, $PTRRECT, $HBRUSH)
	Local $ARESULT = DllCall("user32.dll", "int", "FrameRect", "handle", $HDC, "ptr", $PTRRECT, "handle", $HBRUSH)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_FREELIBRARY($HMODULE)
	Local $ARESULT = DllCall("kernel32.dll", "bool", "FreeLibrary", "handle", $HMODULE)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_GETANCESTOR($HWND, $IFLAGS = 1)
	Local $ARESULT = DllCall("user32.dll", "hwnd", "GetAncestor", "hwnd", $HWND, "uint", $IFLAGS)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_GETASYNCKEYSTATE($IKEY)
	Local $ARESULT = DllCall("user32.dll", "short", "GetAsyncKeyState", "int", $IKEY)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_GETBKMODE($HDC)
	Local $ARESULT = DllCall("gdi32.dll", "int", "GetBkMode", "handle", $HDC)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_GETCLASSNAME($HWND)
	If Not IsHWnd($HWND) Then $HWND = GUICtrlGetHandle($HWND)
	Local $ARESULT = DllCall("user32.dll", "int", "GetClassNameW", "hwnd", $HWND, "wstr", "", "int", 4096)
	If @error Then Return SetError(@error, @extended, False)
	Return SetExtended($ARESULT[0], $ARESULT[2])
EndFunc
Func _WINAPI_GETCLIENTHEIGHT($HWND)
	Local $TRECT = _WINAPI_GETCLIENTRECT($HWND)
	If @error Then Return SetError(@error, @extended, 0)
	Return DllStructGetData($TRECT, "Bottom") - DllStructGetData($TRECT, "Top")
EndFunc
Func _WINAPI_GETCLIENTWIDTH($HWND)
	Local $TRECT = _WINAPI_GETCLIENTRECT($HWND)
	If @error Then Return SetError(@error, @extended, 0)
	Return DllStructGetData($TRECT, "Right") - DllStructGetData($TRECT, "Left")
EndFunc
Func _WINAPI_GETCLIENTRECT($HWND)
	Local $TRECT = DllStructCreate($TAGRECT)
	DllCall("user32.dll", "bool", "GetClientRect", "hwnd", $HWND, "ptr", DllStructGetPtr($TRECT))
	If @error Then Return SetError(@error, @extended, 0)
	Return $TRECT
EndFunc
Func _WINAPI_GETCURRENTPROCESS()
	Local $ARESULT = DllCall("kernel32.dll", "handle", "GetCurrentProcess")
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_GETCURRENTPROCESSID()
	Local $ARESULT = DllCall("kernel32.dll", "dword", "GetCurrentProcessId")
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_GETCURRENTTHREAD()
	Local $ARESULT = DllCall("kernel32.dll", "handle", "GetCurrentThread")
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_GETCURRENTTHREADID()
	Local $ARESULT = DllCall("kernel32.dll", "dword", "GetCurrentThreadId")
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_GETCURSORINFO()
	Local $TCURSOR = DllStructCreate($TAGCURSORINFO)
	Local $ICURSOR = DllStructGetSize($TCURSOR)
	DllStructSetData($TCURSOR, "Size", $ICURSOR)
	DllCall("user32.dll", "bool", "GetCursorInfo", "ptr", DllStructGetPtr($TCURSOR))
	If @error Then Return SetError(@error, @extended, 0)
	Local $ACURSOR[5]
	$ACURSOR[0] = True
	$ACURSOR[1] = DllStructGetData($TCURSOR, "Flags") <> 0
	$ACURSOR[2] = DllStructGetData($TCURSOR, "hCursor")
	$ACURSOR[3] = DllStructGetData($TCURSOR, "X")
	$ACURSOR[4] = DllStructGetData($TCURSOR, "Y")
	Return $ACURSOR
EndFunc
Func _WINAPI_GETDC($HWND)
	Local $ARESULT = DllCall("user32.dll", "handle", "GetDC", "hwnd", $HWND)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_GETDESKTOPWINDOW()
	Local $ARESULT = DllCall("user32.dll", "hwnd", "GetDesktopWindow")
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_GETDEVICECAPS($HDC, $IINDEX)
	Local $ARESULT = DllCall("gdi32.dll", "int", "GetDeviceCaps", "handle", $HDC, "int", $IINDEX)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_GETDIBITS($HDC, $HBMP, $ISTARTSCAN, $ISCANLINES, $PBITS, $PBI, $IUSAGE)
	Local $ARESULT = DllCall("gdi32.dll", "int", "GetDIBits", "handle", $HDC, "handle", $HBMP, "uint", $ISTARTSCAN, "uint", $ISCANLINES, "ptr", $PBITS, "ptr", $PBI, "uint", $IUSAGE)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_GETDLGCTRLID($HWND)
	Local $ARESULT = DllCall("user32.dll", "int", "GetDlgCtrlID", "hwnd", $HWND)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_GETDLGITEM($HWND, $IITEMID)
	Local $ARESULT = DllCall("user32.dll", "hwnd", "GetDlgItem", "hwnd", $HWND, "int", $IITEMID)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_GETFOCUS()
	Local $ARESULT = DllCall("user32.dll", "hwnd", "GetFocus")
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_GETFOREGROUNDWINDOW()
	Local $ARESULT = DllCall("user32.dll", "hwnd", "GetForegroundWindow")
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_GETGUIRESOURCES($IFLAG = 0, $HPROCESS = -1)
	If $HPROCESS = -1 Then $HPROCESS = _WINAPI_GETCURRENTPROCESS()
	Local $ARESULT = DllCall("user32.dll", "dword", "GetGuiResources", "handle", $HPROCESS, "dword", $IFLAG)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_GETICONINFO($HICON)
	Local $TINFO = DllStructCreate($TAGICONINFO)
	DllCall("user32.dll", "bool", "GetIconInfo", "handle", $HICON, "ptr", DllStructGetPtr($TINFO))
	If @error Then Return SetError(@error, @extended, 0)
	Local $AICON[6]
	$AICON[0] = True
	$AICON[1] = DllStructGetData($TINFO, "Icon") <> 0
	$AICON[2] = DllStructGetData($TINFO, "XHotSpot")
	$AICON[3] = DllStructGetData($TINFO, "YHotSpot")
	$AICON[4] = DllStructGetData($TINFO, "hMask")
	$AICON[5] = DllStructGetData($TINFO, "hColor")
	Return $AICON
EndFunc
Func _WINAPI_GETFILESIZEEX($HFILE)
	Local $ARESULT = DllCall("kernel32.dll", "bool", "GetFileSizeEx", "handle", $HFILE, "int64*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[2]
EndFunc
Func _WINAPI_GETLASTERRORMESSAGE()
	Local $TBUFFERPTR = DllStructCreate("ptr")
	Local $PBUFFERPTR = DllStructGetPtr($TBUFFERPTR)
	Local $NCOUNT = _WINAPI_FORMATMESSAGE(BitOR($__WINAPICONSTANT_FORMAT_MESSAGE_ALLOCATE_BUFFER, $__WINAPICONSTANT_FORMAT_MESSAGE_FROM_SYSTEM), 0, _WINAPI_GETLASTERROR(), 0, $PBUFFERPTR, 0, 0)
	If @error Then Return SetError(@error, 0, "")
	Local $STEXT = ""
	Local $PBUFFER = DllStructGetData($TBUFFERPTR, 1)
	If $PBUFFER Then
		If $NCOUNT > 0 Then
			Local $TBUFFER = DllStructCreate("wchar[" & ($NCOUNT + 1) & "]", $PBUFFER)
			$STEXT = DllStructGetData($TBUFFER, 1)
		EndIf
		_WINAPI_LOCALFREE($PBUFFER)
	EndIf
	Return $STEXT
EndFunc
Func _WINAPI_GETLAYEREDWINDOWATTRIBUTES($HWND, ByRef $I_TRANSCOLOR, ByRef $TRANSPARENCY, $ASCOLORREF = False)
	$I_TRANSCOLOR = -1
	$TRANSPARENCY = -1
	Local $ARESULT = DllCall("user32.dll", "bool", "GetLayeredWindowAttributes", "hwnd", $HWND, "dword*", $I_TRANSCOLOR, "byte*", $TRANSPARENCY, "dword*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	If Not $ASCOLORREF Then
		$ARESULT[2] = Hex(String($ARESULT[2]), 6)
		$ARESULT[2] = "0x" & StringMid($ARESULT[2], 5, 2) & StringMid($ARESULT[2], 3, 2) & StringMid($ARESULT[2], 1, 2)
	EndIf
	$I_TRANSCOLOR = $ARESULT[2]
	$TRANSPARENCY = $ARESULT[3]
	Return $ARESULT[4]
EndFunc
Func _WINAPI_GETMODULEHANDLE($SMODULENAME)
	Local $SMODULENAMETYPE = "wstr"
	If $SMODULENAME = "" Then
		$SMODULENAME = 0
		$SMODULENAMETYPE = "ptr"
	EndIf
	Local $ARESULT = DllCall("kernel32.dll", "handle", "GetModuleHandleW", $SMODULENAMETYPE, $SMODULENAME)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_GETMOUSEPOS($FTOCLIENT = False, $HWND = 0)
	Local $IMODE = Opt("MouseCoordMode", 1)
	Local $APOS = MouseGetPos()
	Opt("MouseCoordMode", $IMODE)
	Local $TPOINT = DllStructCreate($TAGPOINT)
	DllStructSetData($TPOINT, "X", $APOS[0])
	DllStructSetData($TPOINT, "Y", $APOS[1])
	If $FTOCLIENT Then
		_WINAPI_SCREENTOCLIENT($HWND, $TPOINT)
		If @error Then Return SetError(@error, @extended, 0)
	EndIf
	Return $TPOINT
EndFunc
Func _WINAPI_GETMOUSEPOSX($FTOCLIENT = False, $HWND = 0)
	Local $TPOINT = _WINAPI_GETMOUSEPOS($FTOCLIENT, $HWND)
	If @error Then Return SetError(@error, @extended, 0)
	Return DllStructGetData($TPOINT, "X")
EndFunc
Func _WINAPI_GETMOUSEPOSY($FTOCLIENT = False, $HWND = 0)
	Local $TPOINT = _WINAPI_GETMOUSEPOS($FTOCLIENT, $HWND)
	If @error Then Return SetError(@error, @extended, 0)
	Return DllStructGetData($TPOINT, "Y")
EndFunc
Func _WINAPI_GETOBJECT($HOBJECT, $ISIZE, $POBJECT)
	Local $ARESULT = DllCall("gdi32.dll", "int", "GetObject", "handle", $HOBJECT, "int", $ISIZE, "ptr", $POBJECT)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_GETOPENFILENAME($STITLE = "", $SFILTER = "All files (*.*)", $SINITALDIR = ".", $SDEFAULTFILE = "", $SDEFAULTEXT = "", $IFILTERINDEX = 1, $IFLAGS = 0, $IFLAGSEX = 0, $HWNDOWNER = 0)
	Local $IPATHLEN = 4096
	Local $INULLS = 0
	Local $TOFN = DllStructCreate($TAGOPENFILENAME)
	Local $AFILES[1] = [0]
	Local $IFLAG = $IFLAGS
	Local $ASFLINES = StringSplit($SFILTER, "|")
	Local $ASFILTER[$ASFLINES[0] * 2 + 1]
	Local $ISTART, $IFINAL, $STFILTER
	$ASFILTER[0] = $ASFLINES[0] * 2
	For $I = 1 To $ASFLINES[0]
		$ISTART = StringInStr($ASFLINES[$I], "(", 0, 1)
		$IFINAL = StringInStr($ASFLINES[$I], ")", 0, -1)
		$ASFILTER[$I * 2 - 1] = StringStripWS(StringLeft($ASFLINES[$I], $ISTART - 1), 3)
		$ASFILTER[$I * 2] = StringStripWS(StringTrimRight(StringTrimLeft($ASFLINES[$I], $ISTART), StringLen($ASFLINES[$I]) - $IFINAL + 1), 3)
		$STFILTER &= "wchar[" & StringLen($ASFILTER[$I * 2 - 1]) + 1 & "];wchar[" & StringLen($ASFILTER[$I * 2]) + 1 & "];"
	Next
	Local $TTITLE = DllStructCreate("wchar Title[" & StringLen($STITLE) + 1 & "]")
	Local $TINITIALDIR = DllStructCreate("wchar InitDir[" & StringLen($SINITALDIR) + 1 & "]")
	Local $TFILTER = DllStructCreate($STFILTER & "wchar")
	Local $TPATH = DllStructCreate("wchar Path[" & $IPATHLEN & "]")
	Local $TEXTN = DllStructCreate("wchar Extension[" & StringLen($SDEFAULTEXT) + 1 & "]")
	For $I = 1 To $ASFILTER[0]
		DllStructSetData($TFILTER, $I, $ASFILTER[$I])
	Next
	DllStructSetData($TTITLE, "Title", $STITLE)
	DllStructSetData($TINITIALDIR, "InitDir", $SINITALDIR)
	DllStructSetData($TPATH, "Path", $SDEFAULTFILE)
	DllStructSetData($TEXTN, "Extension", $SDEFAULTEXT)
	DllStructSetData($TOFN, "StructSize", DllStructGetSize($TOFN))
	DllStructSetData($TOFN, "hwndOwner", $HWNDOWNER)
	DllStructSetData($TOFN, "lpstrFilter", DllStructGetPtr($TFILTER))
	DllStructSetData($TOFN, "nFilterIndex", $IFILTERINDEX)
	DllStructSetData($TOFN, "lpstrFile", DllStructGetPtr($TPATH))
	DllStructSetData($TOFN, "nMaxFile", $IPATHLEN)
	DllStructSetData($TOFN, "lpstrInitialDir", DllStructGetPtr($TINITIALDIR))
	DllStructSetData($TOFN, "lpstrTitle", DllStructGetPtr($TTITLE))
	DllStructSetData($TOFN, "Flags", $IFLAG)
	DllStructSetData($TOFN, "lpstrDefExt", DllStructGetPtr($TEXTN))
	DllStructSetData($TOFN, "FlagsEx", $IFLAGSEX)
	DllCall("comdlg32.dll", "bool", "GetOpenFileNameW", "ptr", DllStructGetPtr($TOFN))
	If @error Then Return SetError(@error, @extended, $AFILES)
	If BitAND($IFLAGS, $OFN_ALLOWMULTISELECT) = $OFN_ALLOWMULTISELECT And BitAND($IFLAGS, $OFN_EXPLORER) = $OFN_EXPLORER Then
		For $X = 1 To $IPATHLEN
			If DllStructGetData($TPATH, "Path", $X) = Chr(0) Then
				DllStructSetData($TPATH, "Path", "|", $X)
				$INULLS += 1
			Else
				$INULLS = 0
			EndIf
			If $INULLS = 2 Then ExitLoop
		Next
		DllStructSetData($TPATH, "Path", Chr(0), $X - 1)
		$AFILES = StringSplit(DllStructGetData($TPATH, "Path"), "|")
		If $AFILES[0] = 1 Then Return __WINAPI_PARSEFILEDIALOGPATH(DllStructGetData($TPATH, "Path"))
		Return StringSplit(DllStructGetData($TPATH, "Path"), "|")
	ElseIf BitAND($IFLAGS, $OFN_ALLOWMULTISELECT) = $OFN_ALLOWMULTISELECT Then
		$AFILES = StringSplit(DllStructGetData($TPATH, "Path"), " ")
		If $AFILES[0] = 1 Then Return __WINAPI_PARSEFILEDIALOGPATH(DllStructGetData($TPATH, "Path"))
		Return StringSplit(StringReplace(DllStructGetData($TPATH, "Path"), " ", "|"), "|")
	Else
		Return __WINAPI_PARSEFILEDIALOGPATH(DllStructGetData($TPATH, "Path"))
	EndIf
EndFunc
Func _WINAPI_GETOVERLAPPEDRESULT($HFILE, $POVERLAPPED, ByRef $IBYTES, $FWAIT = False)
	Local $ARESULT = DllCall("kernel32.dll", "bool", "GetOverlappedResult", "handle", $HFILE, "ptr", $POVERLAPPED, "dword*", 0, "bool", $FWAIT)
	If @error Then Return SetError(@error, @extended, False)
	$IBYTES = $ARESULT[3]
	Return $ARESULT[0]
EndFunc
Func _WINAPI_GETPARENT($HWND)
	Local $ARESULT = DllCall("user32.dll", "hwnd", "GetParent", "hwnd", $HWND)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_GETPROCESSAFFINITYMASK($HPROCESS)
	Local $ARESULT = DllCall("kernel32.dll", "bool", "GetProcessAffinityMask", "handle", $HPROCESS, "dword_ptr*", 0, "dword_ptr*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Local $AMASK[3]
	$AMASK[0] = True
	$AMASK[1] = $ARESULT[2]
	$AMASK[2] = $ARESULT[3]
	Return $AMASK
EndFunc
Func _WINAPI_GETSAVEFILENAME($STITLE = "", $SFILTER = "All files (*.*)", $SINITALDIR = ".", $SDEFAULTFILE = "", $SDEFAULTEXT = "", $IFILTERINDEX = 1, $IFLAGS = 0, $IFLAGSEX = 0, $HWNDOWNER = 0)
	Local $IPATHLEN = 4096
	Local $TOFN = DllStructCreate($TAGOPENFILENAME)
	Local $AFILES[1] = [0]
	Local $IFLAG = $IFLAGS
	Local $ASFLINES = StringSplit($SFILTER, "|")
	Local $ASFILTER[$ASFLINES[0] * 2 + 1]
	Local $ISTART, $IFINAL, $STFILTER
	$ASFILTER[0] = $ASFLINES[0] * 2
	For $I = 1 To $ASFLINES[0]
		$ISTART = StringInStr($ASFLINES[$I], "(", 0, 1)
		$IFINAL = StringInStr($ASFLINES[$I], ")", 0, -1)
		$ASFILTER[$I * 2 - 1] = StringStripWS(StringLeft($ASFLINES[$I], $ISTART - 1), 3)
		$ASFILTER[$I * 2] = StringStripWS(StringTrimRight(StringTrimLeft($ASFLINES[$I], $ISTART), StringLen($ASFLINES[$I]) - $IFINAL + 1), 3)
		$STFILTER &= "wchar[" & StringLen($ASFILTER[$I * 2 - 1]) + 1 & "];wchar[" & StringLen($ASFILTER[$I * 2]) + 1 & "];"
	Next
	Local $TTITLE = DllStructCreate("wchar Title[" & StringLen($STITLE) + 1 & "]")
	Local $TINITIALDIR = DllStructCreate("wchar InitDir[" & StringLen($SINITALDIR) + 1 & "]")
	Local $TFILTER = DllStructCreate($STFILTER & "wchar")
	Local $TPATH = DllStructCreate("wchar Path[" & $IPATHLEN & "]")
	Local $TEXTN = DllStructCreate("wchar Extension[" & StringLen($SDEFAULTEXT) + 1 & "]")
	For $I = 1 To $ASFILTER[0]
		DllStructSetData($TFILTER, $I, $ASFILTER[$I])
	Next
	DllStructSetData($TTITLE, "Title", $STITLE)
	DllStructSetData($TINITIALDIR, "InitDir", $SINITALDIR)
	DllStructSetData($TPATH, "Path", $SDEFAULTFILE)
	DllStructSetData($TEXTN, "Extension", $SDEFAULTEXT)
	DllStructSetData($TOFN, "StructSize", DllStructGetSize($TOFN))
	DllStructSetData($TOFN, "hwndOwner", $HWNDOWNER)
	DllStructSetData($TOFN, "lpstrFilter", DllStructGetPtr($TFILTER))
	DllStructSetData($TOFN, "nFilterIndex", $IFILTERINDEX)
	DllStructSetData($TOFN, "lpstrFile", DllStructGetPtr($TPATH))
	DllStructSetData($TOFN, "nMaxFile", $IPATHLEN)
	DllStructSetData($TOFN, "lpstrInitialDir", DllStructGetPtr($TINITIALDIR))
	DllStructSetData($TOFN, "lpstrTitle", DllStructGetPtr($TTITLE))
	DllStructSetData($TOFN, "Flags", $IFLAG)
	DllStructSetData($TOFN, "lpstrDefExt", DllStructGetPtr($TEXTN))
	DllStructSetData($TOFN, "FlagsEx", $IFLAGSEX)
	DllCall("comdlg32.dll", "bool", "GetSaveFileNameW", "ptr", DllStructGetPtr($TOFN))
	If @error Then Return SetError(@error, @extended, $AFILES)
	Return __WINAPI_PARSEFILEDIALOGPATH(DllStructGetData($TPATH, "Path"))
EndFunc
Func _WINAPI_GETSTOCKOBJECT($IOBJECT)
	Local $ARESULT = DllCall("gdi32.dll", "handle", "GetStockObject", "int", $IOBJECT)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_GETSTDHANDLE($ISTDHANDLE)
	If $ISTDHANDLE < 0 Or $ISTDHANDLE > 2 Then Return SetError(2, 0, -1)
	Local Const $AHANDLE[3] = [-10, -11, -12]
	Local $ARESULT = DllCall("kernel32.dll", "handle", "GetStdHandle", "dword", $AHANDLE[$ISTDHANDLE])
	If @error Then Return SetError(@error, @extended, -1)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_GETSYSCOLOR($IINDEX)
	Local $ARESULT = DllCall("user32.dll", "dword", "GetSysColor", "int", $IINDEX)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_GETSYSCOLORBRUSH($IINDEX)
	Local $ARESULT = DllCall("user32.dll", "handle", "GetSysColorBrush", "int", $IINDEX)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_GETSYSTEMMETRICS($IINDEX)
	Local $ARESULT = DllCall("user32.dll", "int", "GetSystemMetrics", "int", $IINDEX)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_GETTEXTEXTENTPOINT32($HDC, $STEXT)
	Local $TSIZE = DllStructCreate($TAGSIZE)
	Local $ISIZE = StringLen($STEXT)
	DllCall("gdi32.dll", "bool", "GetTextExtentPoint32W", "handle", $HDC, "wstr", $STEXT, "int", $ISIZE, "ptr", DllStructGetPtr($TSIZE))
	If @error Then Return SetError(@error, @extended, 0)
	Return $TSIZE
EndFunc
Func _WINAPI_GETWINDOW($HWND, $ICMD)
	Local $ARESULT = DllCall("user32.dll", "hwnd", "GetWindow", "hwnd", $HWND, "uint", $ICMD)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_GETWINDOWDC($HWND)
	Local $ARESULT = DllCall("user32.dll", "handle", "GetWindowDC", "hwnd", $HWND)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_GETWINDOWHEIGHT($HWND)
	Local $TRECT = _WINAPI_GETWINDOWRECT($HWND)
	If @error Then Return SetError(@error, @extended, 0)
	Return DllStructGetData($TRECT, "Bottom") - DllStructGetData($TRECT, "Top")
EndFunc
Func _WINAPI_GETWINDOWLONG($HWND, $IINDEX)
	Local $SFUNCNAME = "GetWindowLongW"
	If @AutoItX64 Then $SFUNCNAME = "GetWindowLongPtrW"
	Local $ARESULT = DllCall("user32.dll", "long_ptr", $SFUNCNAME, "hwnd", $HWND, "int", $IINDEX)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_GETWINDOWPLACEMENT($HWND)
	Local $TWINDOWPLACEMENT = DllStructCreate($TAGWINDOWPLACEMENT)
	DllStructSetData($TWINDOWPLACEMENT, "length", DllStructGetSize($TWINDOWPLACEMENT))
	Local $PWINDOWPLACEMENT = DllStructGetPtr($TWINDOWPLACEMENT)
	DllCall("user32.dll", "bool", "GetWindowPlacement", "hwnd", $HWND, "ptr", $PWINDOWPLACEMENT)
	If @error Then Return SetError(@error, @extended, 0)
	Return $TWINDOWPLACEMENT
EndFunc
Func _WINAPI_GETWINDOWRECT($HWND)
	Local $TRECT = DllStructCreate($TAGRECT)
	DllCall("user32.dll", "bool", "GetWindowRect", "hwnd", $HWND, "ptr", DllStructGetPtr($TRECT))
	If @error Then Return SetError(@error, @extended, 0)
	Return $TRECT
EndFunc
Func _WINAPI_GETWINDOWRGN($HWND, $HRGN)
	Local $ARESULT = DllCall("user32.dll", "int", "GetWindowRgn", "hwnd", $HWND, "handle", $HRGN)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_GETWINDOWTEXT($HWND)
	Local $ARESULT = DllCall("user32.dll", "int", "GetWindowTextW", "hwnd", $HWND, "wstr", "", "int", 4096)
	If @error Then Return SetError(@error, @extended, "")
	Return SetExtended($ARESULT[0], $ARESULT[2])
EndFunc
Func _WINAPI_GETWINDOWTHREADPROCESSID($HWND, ByRef $IPID)
	Local $ARESULT = DllCall("user32.dll", "dword", "GetWindowThreadProcessId", "hwnd", $HWND, "dword*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	$IPID = $ARESULT[2]
	Return $ARESULT[0]
EndFunc
Func _WINAPI_GETWINDOWWIDTH($HWND)
	Local $TRECT = _WINAPI_GETWINDOWRECT($HWND)
	If @error Then Return SetError(@error, @extended, 0)
	Return DllStructGetData($TRECT, "Right") - DllStructGetData($TRECT, "Left")
EndFunc
Func _WINAPI_GETXYFROMPOINT(ByRef $TPOINT, ByRef $IX, ByRef $IY)
	$IX = DllStructGetData($TPOINT, "X")
	$IY = DllStructGetData($TPOINT, "Y")
EndFunc
Func _WINAPI_GLOBALMEMORYSTATUS()
	Local $TMEM = DllStructCreate($TAGMEMORYSTATUSEX)
	Local $PMEM = DllStructGetPtr($TMEM)
	Local $IMEM = DllStructGetSize($TMEM)
	DllStructSetData($TMEM, 1, $IMEM)
	DllCall("kernel32.dll", "none", "GlobalMemoryStatusEx", "ptr", $PMEM)
	If @error Then Return SetError(@error, @extended, 0)
	Local $AMEM[7]
	$AMEM[0] = DllStructGetData($TMEM, 2)
	$AMEM[1] = DllStructGetData($TMEM, 3)
	$AMEM[2] = DllStructGetData($TMEM, 4)
	$AMEM[3] = DllStructGetData($TMEM, 5)
	$AMEM[4] = DllStructGetData($TMEM, 6)
	$AMEM[5] = DllStructGetData($TMEM, 7)
	$AMEM[6] = DllStructGetData($TMEM, 8)
	Return $AMEM
EndFunc
Func _WINAPI_GUIDFROMSTRING($SGUID)
	Local $TGUID = DllStructCreate($TAGGUID)
	_WINAPI_GUIDFROMSTRINGEX($SGUID, DllStructGetPtr($TGUID))
	If @error Then Return SetError(@error, @extended, 0)
	Return $TGUID
EndFunc
Func _WINAPI_GUIDFROMSTRINGEX($SGUID, $PGUID)
	Local $ARESULT = DllCall("ole32.dll", "long", "CLSIDFromString", "wstr", $SGUID, "ptr", $PGUID)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_HIWORD($ILONG)
	Return BitShift($ILONG, 16)
EndFunc
Func _WINAPI_INPROCESS($HWND, ByRef $HLASTWND)
	If $HWND = $HLASTWND Then Return True
	For $II = $__GAINPROCESS_WINAPI[0][0] To 1 Step -1
		If $HWND = $__GAINPROCESS_WINAPI[$II][0] Then
			If $__GAINPROCESS_WINAPI[$II][1] Then
				$HLASTWND = $HWND
				Return True
			Else
				Return False
			EndIf
		EndIf
	Next
	Local $IPROCESSID
	_WINAPI_GETWINDOWTHREADPROCESSID($HWND, $IPROCESSID)
	Local $ICOUNT = $__GAINPROCESS_WINAPI[0][0] + 1
	If $ICOUNT >= 64 Then $ICOUNT = 1
	$__GAINPROCESS_WINAPI[0][0] = $ICOUNT
	$__GAINPROCESS_WINAPI[$ICOUNT][0] = $HWND
	$__GAINPROCESS_WINAPI[$ICOUNT][1] = ($IPROCESSID = @AutoItPID)
	Return $__GAINPROCESS_WINAPI[$ICOUNT][1]
EndFunc
Func _WINAPI_INTTOFLOAT($IINT)
	Local $TINT = DllStructCreate("int")
	Local $TFLOAT = DllStructCreate("float", DllStructGetPtr($TINT))
	DllStructSetData($TINT, 1, $IINT)
	Return DllStructGetData($TFLOAT, 1)
EndFunc
Func _WINAPI_ISCLASSNAME($HWND, $SCLASSNAME)
	Local $SSEPARATOR = Opt("GUIDataSeparatorChar")
	Local $ACLASSNAME = StringSplit($SCLASSNAME, $SSEPARATOR)
	If Not IsHWnd($HWND) Then $HWND = GUICtrlGetHandle($HWND)
	Local $SCLASSCHECK = _WINAPI_GETCLASSNAME($HWND)
	For $X = 1 To UBound($ACLASSNAME) - 1
		If StringUpper(StringMid($SCLASSCHECK, 1, StringLen($ACLASSNAME[$X]))) = StringUpper($ACLASSNAME[$X]) Then Return True
	Next
	Return False
EndFunc
Func _WINAPI_ISWINDOW($HWND)
	Local $ARESULT = DllCall("user32.dll", "bool", "IsWindow", "hwnd", $HWND)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_ISWINDOWVISIBLE($HWND)
	Local $ARESULT = DllCall("user32.dll", "bool", "IsWindowVisible", "hwnd", $HWND)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_INVALIDATERECT($HWND, $TRECT = 0, $FERASE = True)
	Local $PRECT = 0
	If IsDllStruct($TRECT) Then $PRECT = DllStructGetPtr($TRECT)
	Local $ARESULT = DllCall("user32.dll", "bool", "InvalidateRect", "hwnd", $HWND, "ptr", $PRECT, "bool", $FERASE)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_LINETO($HDC, $IX, $IY)
	Local $ARESULT = DllCall("gdi32.dll", "bool", "LineTo", "handle", $HDC, "int", $IX, "int", $IY)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_LOADBITMAP($HINSTANCE, $SBITMAP)
	Local $SBITMAPTYPE = "int"
	If IsString($SBITMAP) Then $SBITMAPTYPE = "wstr"
	Local $ARESULT = DllCall("user32.dll", "handle", "LoadBitmapW", "handle", $HINSTANCE, $SBITMAPTYPE, $SBITMAP)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_LOADIMAGE($HINSTANCE, $SIMAGE, $ITYPE, $IXDESIRED, $IYDESIRED, $ILOAD)
	Local $ARESULT, $SIMAGETYPE = "int"
	If IsString($SIMAGE) Then $SIMAGETYPE = "wstr"
	$ARESULT = DllCall("user32.dll", "handle", "LoadImageW", "handle", $HINSTANCE, $SIMAGETYPE, $SIMAGE, "uint", $ITYPE, "int", $IXDESIRED, "int", $IYDESIRED, "uint", $ILOAD)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_LOADLIBRARY($SFILENAME)
	Local $ARESULT = DllCall("kernel32.dll", "handle", "LoadLibraryW", "wstr", $SFILENAME)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_LOADLIBRARYEX($SFILENAME, $IFLAGS = 0)
	Local $ARESULT = DllCall("kernel32.dll", "handle", "LoadLibraryExW", "wstr", $SFILENAME, "ptr", 0, "dword", $IFLAGS)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_LOADSHELL32ICON($IICONID)
	Local $TICONS = DllStructCreate("ptr Data")
	Local $PICONS = DllStructGetPtr($TICONS)
	Local $IICONS = _WINAPI_EXTRACTICONEX("shell32.dll", $IICONID, 0, $PICONS, 1)
	If @error Then Return SetError(@error, @extended, 0)
	If $IICONS <= 0 Then Return SetError(1, 0, 0)
	Return DllStructGetData($TICONS, "Data")
EndFunc
Func _WINAPI_LOADSTRING($HINSTANCE, $ISTRINGID)
	Local $ARESULT = DllCall("user32.dll", "int", "LoadStringW", "handle", $HINSTANCE, "uint", $ISTRINGID, "wstr", "", "int", 4096)
	If @error Then Return SetError(@error, @extended, "")
	Return SetExtended($ARESULT[0], $ARESULT[3])
EndFunc
Func _WINAPI_LOCALFREE($HMEM)
	Local $ARESULT = DllCall("kernel32.dll", "handle", "LocalFree", "handle", $HMEM)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_LOWORD($ILONG)
	Return BitAND($ILONG, 65535)
EndFunc
Func _WINAPI_MAKELANGID($LGIDPRIMARY, $LGIDSUB)
	Return BitOR(BitShift($LGIDSUB, -10), $LGIDPRIMARY)
EndFunc
Func _WINAPI_MAKELCID($LGID, $SRTID)
	Return BitOR(BitShift($SRTID, -16), $LGID)
EndFunc
Func _WINAPI_MAKELONG($ILO, $IHI)
	Return BitOR(BitShift($IHI, -16), BitAND($ILO, 65535))
EndFunc
Func _WINAPI_MAKEQWORD($LODWORD, $HIDWORD)
	Local $TINT64 = DllStructCreate("uint64")
	Local $TDWORDS = DllStructCreate("dword;dword", DllStructGetPtr($TINT64))
	DllStructSetData($TDWORDS, 1, $LODWORD)
	DllStructSetData($TDWORDS, 2, $HIDWORD)
	Return DllStructGetData($TINT64, 1)
EndFunc
Func _WINAPI_MESSAGEBEEP($ITYPE = 1)
	Local $ISOUND
	Switch $ITYPE
		Case 1
			$ISOUND = 0
		Case 2
			$ISOUND = 16
		Case 3
			$ISOUND = 32
		Case 4
			$ISOUND = 48
		Case 5
			$ISOUND = 64
		Case Else
			$ISOUND = -1
	EndSwitch
	Local $ARESULT = DllCall("user32.dll", "bool", "MessageBeep", "uint", $ISOUND)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_MSGBOX($IFLAGS, $STITLE, $STEXT)
	BlockInput(0)
	MsgBox($IFLAGS, $STITLE, $STEXT & "      ")
EndFunc
Func _WINAPI_MOUSE_EVENT($IFLAGS, $IX = 0, $IY = 0, $IDATA = 0, $IEXTRAINFO = 0)
	DllCall("user32.dll", "none", "mouse_event", "dword", $IFLAGS, "dword", $IX, "dword", $IY, "dword", $IDATA, "ulong_ptr", $IEXTRAINFO)
	If @error Then Return SetError(@error, @extended)
EndFunc
Func _WINAPI_MOVETO($HDC, $IX, $IY)
	Local $ARESULT = DllCall("gdi32.dll", "bool", "MoveToEx", "handle", $HDC, "int", $IX, "int", $IY, "ptr", 0)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_MOVEWINDOW($HWND, $IX, $IY, $IWIDTH, $IHEIGHT, $FREPAINT = True)
	Local $ARESULT = DllCall("user32.dll", "bool", "MoveWindow", "hwnd", $HWND, "int", $IX, "int", $IY, "int", $IWIDTH, "int", $IHEIGHT, "bool", $FREPAINT)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_MULDIV($INUMBER, $INUMERATOR, $IDENOMINATOR)
	Local $ARESULT = DllCall("kernel32.dll", "int", "MulDiv", "int", $INUMBER, "int", $INUMERATOR, "int", $IDENOMINATOR)
	If @error Then Return SetError(@error, @extended, -1)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_MULTIBYTETOWIDECHAR($STEXT, $ICODEPAGE = 0, $IFLAGS = 0, $BRETSTRING = False)
	Local $STEXTTYPE = "ptr", $PTEXT = $STEXT
	If IsDllStruct($STEXT) Then
		$PTEXT = DllStructGetPtr($STEXT)
	Else
		If Not IsPtr($STEXT) Then $STEXTTYPE = "STR"
	EndIf
	Local $ARESULT = DllCall("kernel32.dll", "int", "MultiByteToWideChar", "uint", $ICODEPAGE, "dword", $IFLAGS, $STEXTTYPE, $PTEXT, "int", -1, "ptr", 0, "int", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Local $IOUT = $ARESULT[0]
	Local $TOUT = DllStructCreate("wchar[" & $IOUT & "]")
	Local $POUT = DllStructGetPtr($TOUT)
	$ARESULT = DllCall("kernel32.dll", "int", "MultiByteToWideChar", "uint", $ICODEPAGE, "dword", $IFLAGS, $STEXTTYPE, $PTEXT, "int", -1, "ptr", $POUT, "int", $IOUT)
	If @error Then Return SetError(@error, @extended, 0)
	If $BRETSTRING Then Return DllStructGetData($TOUT, 1)
	Return $TOUT
EndFunc
Func _WINAPI_MULTIBYTETOWIDECHAREX($STEXT, $PTEXT, $ICODEPAGE = 0, $IFLAGS = 0)
	Local $ARESULT = DllCall("kernel32.dll", "int", "MultiByteToWideChar", "uint", $ICODEPAGE, "dword", $IFLAGS, "STR", $STEXT, "int", -1, "ptr", $PTEXT, "int", (StringLen($STEXT) + 1) * 2)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_OPENPROCESS($IACCESS, $FINHERIT, $IPROCESSID, $FDEBUGPRIV = False)
	Local $ARESULT = DllCall("kernel32.dll", "handle", "OpenProcess", "dword", $IACCESS, "bool", $FINHERIT, "dword", $IPROCESSID)
	If @error Then Return SetError(@error, @extended, 0)
	If $ARESULT[0] Then Return $ARESULT[0]
	If Not $FDEBUGPRIV Then Return 0
	Local $HTOKEN = _SECURITY__OPENTHREADTOKENEX(BitOR($TOKEN_ADJUST_PRIVILEGES, $TOKEN_QUERY))
	If @error Then Return SetError(@error, @extended, 0)
	_SECURITY__SETPRIVILEGE($HTOKEN, "SeDebugPrivilege", True)
	Local $IERROR = @error
	Local $ILASTERROR = @extended
	Local $IRET = 0
	If Not @error Then
		$ARESULT = DllCall("kernel32.dll", "handle", "OpenProcess", "dword", $IACCESS, "bool", $FINHERIT, "dword", $IPROCESSID)
		$IERROR = @error
		$ILASTERROR = @extended
		If $ARESULT[0] Then $IRET = $ARESULT[0]
		_SECURITY__SETPRIVILEGE($HTOKEN, "SeDebugPrivilege", False)
		If @error Then
			$IERROR = @error
			$ILASTERROR = @extended
		EndIf
	EndIf
	_WINAPI_CLOSEHANDLE($HTOKEN)
	Return SetError($IERROR, $ILASTERROR, $IRET)
EndFunc
Func __WINAPI_PARSEFILEDIALOGPATH($SPATH)
	Local $AFILES[3]
	$AFILES[0] = 2
	Local $STEMP = StringMid($SPATH, 1, StringInStr($SPATH, "\", 0, -1) - 1)
	$AFILES[1] = $STEMP
	$AFILES[2] = StringMid($SPATH, StringInStr($SPATH, "\", 0, -1) + 1)
	Return $AFILES
EndFunc
Func _WINAPI_PATHFINDONPATH(Const $SZFILE, $AEXTRAPATHS = "", Const $SZPATHDELIMITER = @LF)
	Local $IEXTRACOUNT = 0
	If IsString($AEXTRAPATHS) Then
		If StringLen($AEXTRAPATHS) Then
			$AEXTRAPATHS = StringSplit($AEXTRAPATHS, $SZPATHDELIMITER, 1 + 2)
			$IEXTRACOUNT = UBound($AEXTRAPATHS, 1)
		EndIf
	ElseIf IsArray($AEXTRAPATHS) Then
		$IEXTRACOUNT = UBound($AEXTRAPATHS)
	EndIf
	Local $TPATHS, $TPATHPTRS
	If $IEXTRACOUNT Then
		Local $SZSTRUCT = ""
		For $PATH In $AEXTRAPATHS
			$SZSTRUCT &= "wchar[" & StringLen($PATH) + 1 & "];"
		Next
		$TPATHS = DllStructCreate($SZSTRUCT)
		$TPATHPTRS = DllStructCreate("ptr[" & $IEXTRACOUNT + 1 & "]")
		For $I = 1 To $IEXTRACOUNT
			DllStructSetData($TPATHS, $I, $AEXTRAPATHS[$I - 1])
			DllStructSetData($TPATHPTRS, 1, DllStructGetPtr($TPATHS, $I), $I)
		Next
		DllStructSetData($TPATHPTRS, 1, Ptr(0), $IEXTRACOUNT + 1)
	EndIf
	Local $ARESULT = DllCall("shlwapi.dll", "bool", "PathFindOnPathW", "wstr", $SZFILE, "ptr", DllStructGetPtr($TPATHPTRS))
	If @error Then Return SetError(@error, @extended, False)
	If $ARESULT[0] = 0 Then Return SetError(1, 0, $SZFILE)
	Return $ARESULT[1]
EndFunc
Func _WINAPI_POINTFROMRECT(ByRef $TRECT, $FCENTER = True)
	Local $IX1 = DllStructGetData($TRECT, "Left")
	Local $IY1 = DllStructGetData($TRECT, "Top")
	Local $IX2 = DllStructGetData($TRECT, "Right")
	Local $IY2 = DllStructGetData($TRECT, "Bottom")
	If $FCENTER Then
		$IX1 = $IX1 + (($IX2 - $IX1) / 2)
		$IY1 = $IY1 + (($IY2 - $IY1) / 2)
	EndIf
	Local $TPOINT = DllStructCreate($TAGPOINT)
	DllStructSetData($TPOINT, "X", $IX1)
	DllStructSetData($TPOINT, "Y", $IY1)
	Return $TPOINT
EndFunc
Func _WINAPI_POSTMESSAGE($HWND, $IMSG, $IWPARAM, $ILPARAM)
	Local $ARESULT = DllCall("user32.dll", "bool", "PostMessage", "hwnd", $HWND, "uint", $IMSG, "wparam", $IWPARAM, "lparam", $ILPARAM)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_PRIMARYLANGID($LGID)
	Return BitAND($LGID, 1023)
EndFunc
Func _WINAPI_PTINRECT(ByRef $TRECT, ByRef $TPOINT)
	Local $IX = DllStructGetData($TPOINT, "X")
	Local $IY = DllStructGetData($TPOINT, "Y")
	Local $ARESULT = DllCall("user32.dll", "bool", "PtInRect", "ptr", DllStructGetPtr($TRECT), "long", $IX, "long", $IY)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_READFILE($HFILE, $PBUFFER, $ITOREAD, ByRef $IREAD, $POVERLAPPED = 0)
	Local $ARESULT = DllCall("kernel32.dll", "bool", "ReadFile", "handle", $HFILE, "ptr", $PBUFFER, "dword", $ITOREAD, "dword*", 0, "ptr", $POVERLAPPED)
	If @error Then Return SetError(@error, @extended, False)
	$IREAD = $ARESULT[4]
	Return $ARESULT[0]
EndFunc
Func _WINAPI_READPROCESSMEMORY($HPROCESS, $PBASEADDRESS, $PBUFFER, $ISIZE, ByRef $IREAD)
	Local $ARESULT = DllCall("kernel32.dll", "bool", "ReadProcessMemory", "handle", $HPROCESS, "ptr", $PBASEADDRESS, "ptr", $PBUFFER, "ulong_ptr", $ISIZE, "ulong_ptr*", 0)
	If @error Then Return SetError(@error, @extended, False)
	$IREAD = $ARESULT[5]
	Return $ARESULT[0]
EndFunc
Func _WINAPI_RECTISEMPTY(ByRef $TRECT)
	RETURN (DllStructGetData($TRECT, "Left") = 0) AND (DllStructGetData($TRECT, "Top") = 0) AND (DllStructGetData($TRECT, "Right") = 0) AND (DllStructGetData($TRECT, "Bottom") = 0)
EndFunc
Func _WINAPI_REDRAWWINDOW($HWND, $TRECT = 0, $HREGION = 0, $IFLAGS = 5)
	Local $PRECT = 0
	If $TRECT <> 0 Then $PRECT = DllStructGetPtr($TRECT)
	Local $ARESULT = DllCall("user32.dll", "bool", "RedrawWindow", "hwnd", $HWND, "ptr", $PRECT, "handle", $HREGION, "uint", $IFLAGS)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_REGISTERWINDOWMESSAGE($SMESSAGE)
	Local $ARESULT = DllCall("user32.dll", "uint", "RegisterWindowMessageW", "wstr", $SMESSAGE)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_RELEASECAPTURE()
	Local $ARESULT = DllCall("user32.dll", "bool", "ReleaseCapture")
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_RELEASEDC($HWND, $HDC)
	Local $ARESULT = DllCall("user32.dll", "int", "ReleaseDC", "hwnd", $HWND, "handle", $HDC)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_SCREENTOCLIENT($HWND, ByRef $TPOINT)
	Local $ARESULT = DllCall("user32.dll", "bool", "ScreenToClient", "hwnd", $HWND, "ptr", DllStructGetPtr($TPOINT))
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_SELECTOBJECT($HDC, $HGDIOBJ)
	Local $ARESULT = DllCall("gdi32.dll", "handle", "SelectObject", "handle", $HDC, "handle", $HGDIOBJ)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_SETBKCOLOR($HDC, $ICOLOR)
	Local $ARESULT = DllCall("gdi32.dll", "INT", "SetBkColor", "handle", $HDC, "dword", $ICOLOR)
	If @error Then Return SetError(@error, @extended, -1)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_SETBKMODE($HDC, $IBKMODE)
	Local $ARESULT = DllCall("gdi32.dll", "int", "SetBkMode", "handle", $HDC, "int", $IBKMODE)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_SETCAPTURE($HWND)
	Local $ARESULT = DllCall("user32.dll", "hwnd", "SetCapture", "hwnd", $HWND)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_SETCURSOR($HCURSOR)
	Local $ARESULT = DllCall("user32.dll", "handle", "SetCursor", "handle", $HCURSOR)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_SETDEFAULTPRINTER($SPRINTER)
	Local $ARESULT = DllCall("winspool.drv", "bool", "SetDefaultPrinterW", "wstr", $SPRINTER)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_SETDIBITS($HDC, $HBMP, $ISTARTSCAN, $ISCANLINES, $PBITS, $PBMI, $ICOLORUSE = 0)
	Local $ARESULT = DllCall("gdi32.dll", "int", "SetDIBits", "handle", $HDC, "handle", $HBMP, "uint", $ISTARTSCAN, "uint", $ISCANLINES, "ptr", $PBITS, "ptr", $PBMI, "uint", $ICOLORUSE)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_SETENDOFFILE($HFILE)
	Local $ARESULT = DllCall("kernel32.dll", "bool", "SetEndOfFile", "handle", $HFILE)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_SETEVENT($HEVENT)
	Local $ARESULT = DllCall("kernel32.dll", "bool", "SetEvent", "handle", $HEVENT)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_SETFILEPOINTER($HFILE, $IPOS, $IMETHOD = 0)
	Local $ARESULT = DllCall("kernel32.dll", "INT", "SetFilePointer", "handle", $HFILE, "long", $IPOS, "ptr", 0, "long", $IMETHOD)
	If @error Then Return SetError(@error, @extended, -1)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_SETFOCUS($HWND)
	Local $ARESULT = DllCall("user32.dll", "hwnd", "SetFocus", "hwnd", $HWND)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_SETFONT($HWND, $HFONT, $FREDRAW = True)
	_SENDMESSAGE($HWND, $__WINAPICONSTANT_WM_SETFONT, $HFONT, $FREDRAW, 0, "hwnd")
EndFunc
Func _WINAPI_SETHANDLEINFORMATION($HOBJECT, $IMASK, $IFLAGS)
	Local $ARESULT = DllCall("kernel32.dll", "bool", "SetHandleInformation", "handle", $HOBJECT, "dword", $IMASK, "dword", $IFLAGS)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_SETLAYEREDWINDOWATTRIBUTES($HWND, $I_TRANSCOLOR, $TRANSPARENCY = 255, $DWFLAGS = 3, $ISCOLORREF = False)
	If $DWFLAGS = Default Or $DWFLAGS = "" Or $DWFLAGS < 0 Then $DWFLAGS = 3
	If Not $ISCOLORREF Then
		$I_TRANSCOLOR = Hex(String($I_TRANSCOLOR), 6)
		$I_TRANSCOLOR = Execute("0x00" & StringMid($I_TRANSCOLOR, 5, 2) & StringMid($I_TRANSCOLOR, 3, 2) & StringMid($I_TRANSCOLOR, 1, 2))
	EndIf
	Local $ARESULT = DllCall("user32.dll", "bool", "SetLayeredWindowAttributes", "hwnd", $HWND, "dword", $I_TRANSCOLOR, "byte", $TRANSPARENCY, "dword", $DWFLAGS)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_SETPARENT($HWNDCHILD, $HWNDPARENT)
	Local $ARESULT = DllCall("user32.dll", "hwnd", "SetParent", "hwnd", $HWNDCHILD, "hwnd", $HWNDPARENT)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_SETPROCESSAFFINITYMASK($HPROCESS, $IMASK)
	Local $ARESULT = DllCall("kernel32.dll", "bool", "SetProcessAffinityMask", "handle", $HPROCESS, "ulong_ptr", $IMASK)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_SETSYSCOLORS($VELEMENTS, $VCOLORS)
	Local $ISEARRAY = IsArray($VELEMENTS), $ISCARRAY = IsArray($VCOLORS)
	Local $IELEMENTNUM
	If Not $ISCARRAY And Not $ISEARRAY Then
		$IELEMENTNUM = 1
	ElseIf $ISCARRAY Or $ISEARRAY Then
		If Not $ISCARRAY Or Not $ISEARRAY Then Return SetError(-1, -1, False)
		If UBound($VELEMENTS) <> UBound($VCOLORS) Then Return SetError(-1, -1, False)
		$IELEMENTNUM = UBound($VELEMENTS)
	EndIf
	Local $TELEMENTS = DllStructCreate("int Element[" & $IELEMENTNUM & "]")
	Local $TCOLORS = DllStructCreate("dword NewColor[" & $IELEMENTNUM & "]")
	Local $PELEMENTS = DllStructGetPtr($TELEMENTS)
	Local $PCOLORS = DllStructGetPtr($TCOLORS)
	If Not $ISEARRAY Then
		DllStructSetData($TELEMENTS, "Element", $VELEMENTS, 1)
	Else
		For $X = 0 To $IELEMENTNUM - 1
			DllStructSetData($TELEMENTS, "Element", $VELEMENTS[$X], $X + 1)
		Next
	EndIf
	If Not $ISCARRAY Then
		DllStructSetData($TCOLORS, "NewColor", $VCOLORS, 1)
	Else
		For $X = 0 To $IELEMENTNUM - 1
			DllStructSetData($TCOLORS, "NewColor", $VCOLORS[$X], $X + 1)
		Next
	EndIf
	Local $ARESULT = DllCall("user32.dll", "bool", "SetSysColors", "int", $IELEMENTNUM, "ptr", $PELEMENTS, "ptr", $PCOLORS)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_SETTEXTCOLOR($HDC, $ICOLOR)
	Local $ARESULT = DllCall("gdi32.dll", "INT", "SetTextColor", "handle", $HDC, "dword", $ICOLOR)
	If @error Then Return SetError(@error, @extended, -1)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_SETWINDOWLONG($HWND, $IINDEX, $IVALUE)
	_WINAPI_SETLASTERROR(0)
	Local $SFUNCNAME = "SetWindowLongW"
	If @AutoItX64 Then $SFUNCNAME = "SetWindowLongPtrW"
	Local $ARESULT = DllCall("user32.dll", "long_ptr", $SFUNCNAME, "hwnd", $HWND, "int", $IINDEX, "long_ptr", $IVALUE)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_SETWINDOWPLACEMENT($HWND, $PWINDOWPLACEMENT)
	Local $ARESULT = DllCall("user32.dll", "bool", "SetWindowPlacement", "hwnd", $HWND, "ptr", $PWINDOWPLACEMENT)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_SETWINDOWPOS($HWND, $HAFTER, $IX, $IY, $ICX, $ICY, $IFLAGS)
	Local $ARESULT = DllCall("user32.dll", "bool", "SetWindowPos", "hwnd", $HWND, "hwnd", $HAFTER, "int", $IX, "int", $IY, "int", $ICX, "int", $ICY, "uint", $IFLAGS)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_SETWINDOWRGN($HWND, $HRGN, $BREDRAW = True)
	Local $ARESULT = DllCall("user32.dll", "int", "SetWindowRgn", "hwnd", $HWND, "handle", $HRGN, "bool", $BREDRAW)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_SETWINDOWSHOOKEX($IDHOOK, $LPFN, $HMOD, $DWTHREADID = 0)
	Local $ARESULT = DllCall("user32.dll", "handle", "SetWindowsHookEx", "int", $IDHOOK, "ptr", $LPFN, "handle", $HMOD, "dword", $DWTHREADID)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_SETWINDOWTEXT($HWND, $STEXT)
	Local $ARESULT = DllCall("user32.dll", "bool", "SetWindowTextW", "hwnd", $HWND, "wstr", $STEXT)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_SHOWCURSOR($FSHOW)
	Local $ARESULT = DllCall("user32.dll", "int", "ShowCursor", "bool", $FSHOW)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_SHOWERROR($STEXT, $FEXIT = True)
	_WINAPI_MSGBOX(266256, "Error", $STEXT)
	If $FEXIT Then Exit
EndFunc
Func _WINAPI_SHOWMSG($STEXT)
	_WINAPI_MSGBOX(64 + 4096, "Information", $STEXT)
EndFunc
Func _WINAPI_SHOWWINDOW($HWND, $ICMDSHOW = 5)
	Local $ARESULT = DllCall("user32.dll", "bool", "ShowWindow", "hwnd", $HWND, "int", $ICMDSHOW)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_STRINGFROMGUID($PGUID)
	Local $ARESULT = DllCall("ole32.dll", "int", "StringFromGUID2", "ptr", $PGUID, "wstr", "", "int", 40)
	If @error Then Return SetError(@error, @extended, "")
	Return SetExtended($ARESULT[0], $ARESULT[2])
EndFunc
Func _WINAPI_SUBLANGID($LGID)
	Return BitShift($LGID, 10)
EndFunc
Func _WINAPI_SYSTEMPARAMETERSINFO($IACTION, $IPARAM = 0, $VPARAM = 0, $IWININI = 0)
	Local $ARESULT = DllCall("user32.dll", "bool", "SystemParametersInfoW", "uint", $IACTION, "uint", $IPARAM, "ptr", $VPARAM, "uint", $IWININI)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_TWIPSPERPIXELX()
	Local $LNGDC, $TWIPSPERPIXELX
	$LNGDC = _WINAPI_GETDC(0)
	$TWIPSPERPIXELX = 1440 / _WINAPI_GETDEVICECAPS($LNGDC, $__WINAPICONSTANT_LOGPIXELSX)
	_WINAPI_RELEASEDC(0, $LNGDC)
	Return $TWIPSPERPIXELX
EndFunc
Func _WINAPI_TWIPSPERPIXELY()
	Local $LNGDC, $TWIPSPERPIXELY
	$LNGDC = _WINAPI_GETDC(0)
	$TWIPSPERPIXELY = 1440 / _WINAPI_GETDEVICECAPS($LNGDC, $__WINAPICONSTANT_LOGPIXELSY)
	_WINAPI_RELEASEDC(0, $LNGDC)
	Return $TWIPSPERPIXELY
EndFunc
Func _WINAPI_UNHOOKWINDOWSHOOKEX($HHK)
	Local $ARESULT = DllCall("user32.dll", "bool", "UnhookWindowsHookEx", "handle", $HHK)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_UPDATELAYEREDWINDOW($HWND, $HDCDEST, $PPTDEST, $PSIZE, $HDCSRCE, $PPTSRCE, $IRGB, $PBLEND, $IFLAGS)
	Local $ARESULT = DllCall("user32.dll", "bool", "UpdateLayeredWindow", "hwnd", $HWND, "handle", $HDCDEST, "ptr", $PPTDEST, "ptr", $PSIZE, "handle", $HDCSRCE, "ptr", $PPTSRCE, "dword", $IRGB, "ptr", $PBLEND, "dword", $IFLAGS)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_UPDATEWINDOW($HWND)
	Local $ARESULT = DllCall("user32.dll", "bool", "UpdateWindow", "hwnd", $HWND)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_WAITFORINPUTIDLE($HPROCESS, $ITIMEOUT = -1)
	Local $ARESULT = DllCall("user32.dll", "dword", "WaitForInputIdle", "handle", $HPROCESS, "dword", $ITIMEOUT)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_WAITFORMULTIPLEOBJECTS($ICOUNT, $PHANDLES, $FWAITALL = False, $ITIMEOUT = -1)
	Local $ARESULT = DllCall("kernel32.dll", "INT", "WaitForMultipleObjects", "dword", $ICOUNT, "ptr", $PHANDLES, "bool", $FWAITALL, "dword", $ITIMEOUT)
	If @error Then Return SetError(@error, @extended, -1)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_WAITFORSINGLEOBJECT($HHANDLE, $ITIMEOUT = -1)
	Local $ARESULT = DllCall("kernel32.dll", "INT", "WaitForSingleObject", "handle", $HHANDLE, "dword", $ITIMEOUT)
	If @error Then Return SetError(@error, @extended, -1)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_WIDECHARTOMULTIBYTE($PUNICODE, $ICODEPAGE = 0, $BRETSTRING = True)
	Local $SUNICODETYPE = "ptr"
	If IsDllStruct($PUNICODE) Then
		$PUNICODE = DllStructGetPtr($PUNICODE)
	Else
		If Not IsPtr($PUNICODE) Then $SUNICODETYPE = "wstr"
	EndIf
	Local $ARESULT = DllCall("kernel32.dll", "int", "WideCharToMultiByte", "uint", $ICODEPAGE, "dword", 0, $SUNICODETYPE, $PUNICODE, "int", -1, "ptr", 0, "int", 0, "ptr", 0, "ptr", 0)
	If @error Then Return SetError(@error, @extended, "")
	Local $TMULTIBYTE = DllStructCreate("char[" & $ARESULT[0] & "]")
	Local $PMULTIBYTE = DllStructGetPtr($TMULTIBYTE)
	$ARESULT = DllCall("kernel32.dll", "int", "WideCharToMultiByte", "uint", $ICODEPAGE, "dword", 0, $SUNICODETYPE, $PUNICODE, "int", -1, "ptr", $PMULTIBYTE, "int", $ARESULT[0], "ptr", 0, "ptr", 0)
	If @error Then Return SetError(@error, @extended, "")
	If $BRETSTRING Then Return DllStructGetData($TMULTIBYTE, 1)
	Return $TMULTIBYTE
EndFunc
Func _WINAPI_WINDOWFROMPOINT(ByRef $TPOINT)
	Local $TPOINTCAST = DllStructCreate("int64", DllStructGetPtr($TPOINT))
	Local $ARESULT = DllCall("user32.dll", "hwnd", "WindowFromPoint", "int64", DllStructGetData($TPOINTCAST, 1))
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_WRITECONSOLE($HCONSOLE, $STEXT)
	Local $ARESULT = DllCall("kernel32.dll", "bool", "WriteConsoleW", "handle", $HCONSOLE, "wstr", $STEXT, "dword", StringLen($STEXT), "dword*", 0, "ptr", 0)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _WINAPI_WRITEFILE($HFILE, $PBUFFER, $ITOWRITE, ByRef $IWRITTEN, $POVERLAPPED = 0)
	Local $ARESULT = DllCall("kernel32.dll", "bool", "WriteFile", "handle", $HFILE, "ptr", $PBUFFER, "dword", $ITOWRITE, "dword*", 0, "ptr", $POVERLAPPED)
	If @error Then Return SetError(@error, @extended, False)
	$IWRITTEN = $ARESULT[4]
	Return $ARESULT[0]
EndFunc
Func _WINAPI_WRITEPROCESSMEMORY($HPROCESS, $PBASEADDRESS, $PBUFFER, $ISIZE, ByRef $IWRITTEN, $SBUFFER = "ptr")
	Local $ARESULT = DllCall("kernel32.dll", "bool", "WriteProcessMemory", "handle", $HPROCESS, "ptr", $PBASEADDRESS, $SBUFFER, $PBUFFER, "ulong_ptr", $ISIZE, "ulong_ptr*", 0)
	If @error Then Return SetError(@error, @extended, False)
	$IWRITTEN = $ARESULT[5]
	Return $ARESULT[0]
EndFunc
Func _DATEADD($STYPE, $IVALTOADD, $SDATE)
	Local $ASTIMEPART[4]
	Local $ASDATEPART[4]
	Local $IJULIANDATE
	$STYPE = StringLeft($STYPE, 1)
	If StringInStr("D,M,Y,w,h,n,s", $STYPE) = 0 Or $STYPE = "" Then
		Return SetError(1, 0, 0)
	EndIf
	If Not StringIsInt($IVALTOADD) Then
		Return SetError(2, 0, 0)
	EndIf
	If Not _DATEISVALID($SDATE) Then
		Return SetError(3, 0, 0)
	EndIf
	_DATETIMESPLIT($SDATE, $ASDATEPART, $ASTIMEPART)
	If $STYPE = "d" Or $STYPE = "w" Then
		If $STYPE = "w" Then $IVALTOADD = $IVALTOADD * 7
		$IJULIANDATE = _DATETODAYVALUE($ASDATEPART[1], $ASDATEPART[2], $ASDATEPART[3]) + $IVALTOADD
		_DAYVALUETODATE($IJULIANDATE, $ASDATEPART[1], $ASDATEPART[2], $ASDATEPART[3])
	EndIf
	If $STYPE = "m" Then
		$ASDATEPART[2] = $ASDATEPART[2] + $IVALTOADD
		While $ASDATEPART[2] > 12
			$ASDATEPART[2] = $ASDATEPART[2] - 12
			$ASDATEPART[1] = $ASDATEPART[1] + 1
		WEnd
		While $ASDATEPART[2] < 1
			$ASDATEPART[2] = $ASDATEPART[2] + 12
			$ASDATEPART[1] = $ASDATEPART[1] - 1
		WEnd
	EndIf
	If $STYPE = "y" Then
		$ASDATEPART[1] = $ASDATEPART[1] + $IVALTOADD
	EndIf
	If $STYPE = "h" Or $STYPE = "n" Or $STYPE = "s" Then
		Local $ITIMEVAL = _TIMETOTICKS($ASTIMEPART[1], $ASTIMEPART[2], $ASTIMEPART[3]) / 1000
		If $STYPE = "h" Then $ITIMEVAL = $ITIMEVAL + $IVALTOADD * 3600
		If $STYPE = "n" Then $ITIMEVAL = $ITIMEVAL + $IVALTOADD * 60
		If $STYPE = "s" Then $ITIMEVAL = $ITIMEVAL + $IVALTOADD
		Local $DAY2ADD = Int($ITIMEVAL / (24 * 60 * 60))
		$ITIMEVAL = $ITIMEVAL - $DAY2ADD * 24 * 60 * 60
		If $ITIMEVAL < 0 Then
			$DAY2ADD = $DAY2ADD - 1
			$ITIMEVAL = $ITIMEVAL + 24 * 60 * 60
		EndIf
		$IJULIANDATE = _DATETODAYVALUE($ASDATEPART[1], $ASDATEPART[2], $ASDATEPART[3]) + $DAY2ADD
		_DAYVALUETODATE($IJULIANDATE, $ASDATEPART[1], $ASDATEPART[2], $ASDATEPART[3])
		_TICKSTOTIME($ITIMEVAL * 1000, $ASTIMEPART[1], $ASTIMEPART[2], $ASTIMEPART[3])
	EndIf
	Local $INUMDAYS = _DAYSINMONTH($ASDATEPART[1])
	If $INUMDAYS[$ASDATEPART[2]] < $ASDATEPART[3] Then $ASDATEPART[3] = $INUMDAYS[$ASDATEPART[2]]
	$SDATE = $ASDATEPART[1] & "/" & StringRight("0" & $ASDATEPART[2], 2) & "/" & StringRight("0" & $ASDATEPART[3], 2)
	If $ASTIMEPART[0] > 0 Then
		If $ASTIMEPART[0] > 2 Then
			$SDATE = $SDATE & " " & StringRight("0" & $ASTIMEPART[1], 2) & ":" & StringRight("0" & $ASTIMEPART[2], 2) & ":" & StringRight("0" & $ASTIMEPART[3], 2)
		Else
			$SDATE = $SDATE & " " & StringRight("0" & $ASTIMEPART[1], 2) & ":" & StringRight("0" & $ASTIMEPART[2], 2)
		EndIf
	EndIf
	RETURN ($SDATE)
EndFunc
Func _DATEDAYOFWEEK($IDAYNUM, $ISHORT = 0)
	Local Const $ADAYOFWEEK[8] = ["", "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
	Select
		Case Not StringIsInt($IDAYNUM) Or Not StringIsInt($ISHORT)
			Return SetError(1, 0, "")
		Case $IDAYNUM < 1 Or $IDAYNUM > 7
			Return SetError(1, 0, "")
		Case Else
			Select
				Case $ISHORT = 0
					Return $ADAYOFWEEK[$IDAYNUM]
				Case $ISHORT = 1
					Return StringLeft($ADAYOFWEEK[$IDAYNUM], 3)
				Case Else
					Return SetError(1, 0, "")
			EndSelect
	EndSelect
EndFunc
Func _DATEDAYSINMONTH($IYEAR, $IMONTHNUM)
	If __DATEISMONTH($IMONTHNUM) And __DATEISYEAR($IYEAR) Then
		Local $AINUMDAYS = _DAYSINMONTH($IYEAR)
		Return $AINUMDAYS[$IMONTHNUM]
	EndIf
	Return SetError(1, 0, 0)
EndFunc
Func _DATEDIFF($STYPE, $SSTARTDATE, $SENDDATE)
	$STYPE = StringLeft($STYPE, 1)
	If StringInStr("d,m,y,w,h,n,s", $STYPE) = 0 Or $STYPE = "" Then
		Return SetError(1, 0, 0)
	EndIf
	If Not _DATEISVALID($SSTARTDATE) Then
		Return SetError(2, 0, 0)
	EndIf
	If Not _DATEISVALID($SENDDATE) Then
		Return SetError(3, 0, 0)
	EndIf
	Local $ASSTARTDATEPART[4], $ASSTARTTIMEPART[4], $ASENDDATEPART[4], $ASENDTIMEPART[4]
	_DATETIMESPLIT($SSTARTDATE, $ASSTARTDATEPART, $ASSTARTTIMEPART)
	_DATETIMESPLIT($SENDDATE, $ASENDDATEPART, $ASENDTIMEPART)
	Local $ADAYSDIFF = _DATETODAYVALUE($ASENDDATEPART[1], $ASENDDATEPART[2], $ASENDDATEPART[3]) - _DATETODAYVALUE($ASSTARTDATEPART[1], $ASSTARTDATEPART[2], $ASSTARTDATEPART[3])
	Local $ITIMEDIFF, $IYEARDIFF, $ISTARTTIMEINSECS, $IENDTIMEINSECS
	If $ASSTARTTIMEPART[0] > 1 And $ASENDTIMEPART[0] > 1 Then
		$ISTARTTIMEINSECS = $ASSTARTTIMEPART[1] * 3600 + $ASSTARTTIMEPART[2] * 60 + $ASSTARTTIMEPART[3]
		$IENDTIMEINSECS = $ASENDTIMEPART[1] * 3600 + $ASENDTIMEPART[2] * 60 + $ASENDTIMEPART[3]
		$ITIMEDIFF = $IENDTIMEINSECS - $ISTARTTIMEINSECS
		If $ITIMEDIFF < 0 Then
			$ADAYSDIFF = $ADAYSDIFF - 1
			$ITIMEDIFF = $ITIMEDIFF + 24 * 60 * 60
		EndIf
	Else
		$ITIMEDIFF = 0
	EndIf
	Select
		Case $STYPE = "d"
			RETURN ($ADAYSDIFF)
		Case $STYPE = "m"
			$IYEARDIFF = $ASENDDATEPART[1] - $ASSTARTDATEPART[1]
			Local $IMONTHDIFF = $ASENDDATEPART[2] - $ASSTARTDATEPART[2] + $IYEARDIFF * 12
			If $ASENDDATEPART[3] < $ASSTARTDATEPART[3] Then $IMONTHDIFF = $IMONTHDIFF - 1
			$ISTARTTIMEINSECS = $ASSTARTTIMEPART[1] * 3600 + $ASSTARTTIMEPART[2] * 60 + $ASSTARTTIMEPART[3]
			$IENDTIMEINSECS = $ASENDTIMEPART[1] * 3600 + $ASENDTIMEPART[2] * 60 + $ASENDTIMEPART[3]
			$ITIMEDIFF = $IENDTIMEINSECS - $ISTARTTIMEINSECS
			If $ASENDDATEPART[3] = $ASSTARTDATEPART[3] And $ITIMEDIFF < 0 Then $IMONTHDIFF = $IMONTHDIFF - 1
			RETURN ($IMONTHDIFF)
		Case $STYPE = "y"
			$IYEARDIFF = $ASENDDATEPART[1] - $ASSTARTDATEPART[1]
			If $ASENDDATEPART[2] < $ASSTARTDATEPART[2] Then $IYEARDIFF = $IYEARDIFF - 1
			If $ASENDDATEPART[2] = $ASSTARTDATEPART[2] And $ASENDDATEPART[3] < $ASSTARTDATEPART[3] Then $IYEARDIFF = $IYEARDIFF - 1
			$ISTARTTIMEINSECS = $ASSTARTTIMEPART[1] * 3600 + $ASSTARTTIMEPART[2] * 60 + $ASSTARTTIMEPART[3]
			$IENDTIMEINSECS = $ASENDTIMEPART[1] * 3600 + $ASENDTIMEPART[2] * 60 + $ASENDTIMEPART[3]
			$ITIMEDIFF = $IENDTIMEINSECS - $ISTARTTIMEINSECS
			If $ASENDDATEPART[2] = $ASSTARTDATEPART[2] And $ASENDDATEPART[3] = $ASSTARTDATEPART[3] And $ITIMEDIFF < 0 Then $IYEARDIFF = $IYEARDIFF - 1
			RETURN ($IYEARDIFF)
		Case $STYPE = "w"
			RETURN (Int($ADAYSDIFF / 7))
		Case $STYPE = "h"
			RETURN ($ADAYSDIFF * 24 + Int($ITIMEDIFF / 3600))
		Case $STYPE = "n"
			RETURN ($ADAYSDIFF * 24 * 60 + Int($ITIMEDIFF / 60))
		Case $STYPE = "s"
			RETURN ($ADAYSDIFF * 24 * 60 * 60 + $ITIMEDIFF)
	EndSelect
EndFunc
Func _DATEISLEAPYEAR($IYEAR)
	If StringIsInt($IYEAR) Then
		Select
			Case Mod($IYEAR, 4) = 0 And Mod($IYEAR, 100) <> 0
				Return 1
			Case Mod($IYEAR, 400) = 0
				Return 1
			Case Else
				Return 0
		EndSelect
	EndIf
	Return SetError(1, 0, 0)
EndFunc
Func __DATEISMONTH($INUMBER)
	If StringIsInt($INUMBER) Then
		If $INUMBER >= 1 And $INUMBER <= 12 Then
			Return 1
		Else
			Return 0
		EndIf
	EndIf
	Return 0
EndFunc
Func _DATEISVALID($SDATE)
	Local $ASDATEPART[4], $ASTIMEPART[4]
	Local $SDATETIME = StringSplit($SDATE, " T")
	If $SDATETIME[0] > 0 Then $ASDATEPART = StringSplit($SDATETIME[1], "/-.")
	If UBound($ASDATEPART) <> 4 Then RETURN (0)
	If $ASDATEPART[0] <> 3 Then RETURN (0)
	If Not StringIsInt($ASDATEPART[1]) Then RETURN (0)
	If Not StringIsInt($ASDATEPART[2]) Then RETURN (0)
	If Not StringIsInt($ASDATEPART[3]) Then RETURN (0)
	$ASDATEPART[1] = Number($ASDATEPART[1])
	$ASDATEPART[2] = Number($ASDATEPART[2])
	$ASDATEPART[3] = Number($ASDATEPART[3])
	Local $INUMDAYS = _DAYSINMONTH($ASDATEPART[1])
	If $ASDATEPART[1] < 1000 Or $ASDATEPART[1] > 2999 Then RETURN (0)
	If $ASDATEPART[2] < 1 Or $ASDATEPART[2] > 12 Then RETURN (0)
	If $ASDATEPART[3] < 1 Or $ASDATEPART[3] > $INUMDAYS[$ASDATEPART[2]] Then RETURN (0)
	If $SDATETIME[0] > 1 Then
		$ASTIMEPART = StringSplit($SDATETIME[2], ":")
		If UBound($ASTIMEPART) < 4 Then ReDim $ASTIMEPART[4]
	Else
		Dim $ASTIMEPART[4]
	EndIf
	If $ASTIMEPART[0] < 1 Then RETURN (1)
	If $ASTIMEPART[0] < 2 Then RETURN (0)
	If $ASTIMEPART[0] = 2 Then $ASTIMEPART[3] = "00"
	If Not StringIsInt($ASTIMEPART[1]) Then RETURN (0)
	If Not StringIsInt($ASTIMEPART[2]) Then RETURN (0)
	If Not StringIsInt($ASTIMEPART[3]) Then RETURN (0)
	$ASTIMEPART[1] = Number($ASTIMEPART[1])
	$ASTIMEPART[2] = Number($ASTIMEPART[2])
	$ASTIMEPART[3] = Number($ASTIMEPART[3])
	If $ASTIMEPART[1] < 0 Or $ASTIMEPART[1] > 23 Then RETURN (0)
	If $ASTIMEPART[2] < 0 Or $ASTIMEPART[2] > 59 Then RETURN (0)
	If $ASTIMEPART[3] < 0 Or $ASTIMEPART[3] > 59 Then RETURN (0)
	Return 1
EndFunc
Func __DATEISYEAR($INUMBER)
	If StringIsInt($INUMBER) Then
		If StringLen($INUMBER) = 4 Then
			Return 1
		Else
			Return 0
		EndIf
	EndIf
	Return 0
EndFunc
Func _DATELASTWEEKDAYNUM($IWEEKDAYNUM)
	Select
		Case Not StringIsInt($IWEEKDAYNUM)
			Return SetError(1, 0, 0)
		Case $IWEEKDAYNUM < 1 Or $IWEEKDAYNUM > 7
			Return SetError(1, 0, 0)
		Case Else
			Local $ILASTWEEKDAYNUM
			If $IWEEKDAYNUM = 1 Then
				$ILASTWEEKDAYNUM = 7
			Else
				$ILASTWEEKDAYNUM = $IWEEKDAYNUM - 1
			EndIf
			Return $ILASTWEEKDAYNUM
	EndSelect
EndFunc
Func _DATELASTMONTHNUM($IMONTHNUM)
	Select
		Case Not StringIsInt($IMONTHNUM)
			Return SetError(1, 0, 0)
		Case $IMONTHNUM < 1 Or $IMONTHNUM > 12
			Return SetError(1, 0, 0)
		Case Else
			Local $ILASTMONTHNUM
			If $IMONTHNUM = 1 Then
				$ILASTMONTHNUM = 12
			Else
				$ILASTMONTHNUM = $IMONTHNUM - 1
			EndIf
			$ILASTMONTHNUM = StringFormat("%02d", $ILASTMONTHNUM)
			Return $ILASTMONTHNUM
	EndSelect
EndFunc
Func _DATELASTMONTHYEAR($IMONTHNUM, $IYEAR)
	Select
		Case Not StringIsInt($IMONTHNUM) Or Not StringIsInt($IYEAR)
			Return SetError(1, 0, 0)
		Case $IMONTHNUM < 1 Or $IMONTHNUM > 12
			Return SetError(1, 0, 0)
		Case Else
			Local $ILASTYEAR
			If $IMONTHNUM = 1 Then
				$ILASTYEAR = $IYEAR - 1
			Else
				$ILASTYEAR = $IYEAR
			EndIf
			$ILASTYEAR = StringFormat("%04d", $ILASTYEAR)
			Return $ILASTYEAR
	EndSelect
EndFunc
Func _DATENEXTWEEKDAYNUM($IWEEKDAYNUM)
	Select
		Case Not StringIsInt($IWEEKDAYNUM)
			Return SetError(1, 0, 0)
		Case $IWEEKDAYNUM < 1 Or $IWEEKDAYNUM > 7
			Return SetError(1, 0, 0)
		Case Else
			Local $INEXTWEEKDAYNUM
			If $IWEEKDAYNUM = 7 Then
				$INEXTWEEKDAYNUM = 1
			Else
				$INEXTWEEKDAYNUM = $IWEEKDAYNUM + 1
			EndIf
			Return $INEXTWEEKDAYNUM
	EndSelect
EndFunc
Func _DATENEXTMONTHNUM($IMONTHNUM)
	Select
		Case Not StringIsInt($IMONTHNUM)
			Return SetError(1, 0, 0)
		Case $IMONTHNUM < 1 Or $IMONTHNUM > 12
			Return SetError(1, 0, 0)
		Case Else
			Local $INEXTMONTHNUM
			If $IMONTHNUM = 12 Then
				$INEXTMONTHNUM = 1
			Else
				$INEXTMONTHNUM = $IMONTHNUM + 1
			EndIf
			$INEXTMONTHNUM = StringFormat("%02d", $INEXTMONTHNUM)
			Return $INEXTMONTHNUM
	EndSelect
EndFunc
Func _DATENEXTMONTHYEAR($IMONTHNUM, $IYEAR)
	Select
		Case Not StringIsInt($IMONTHNUM) Or Not StringIsInt($IYEAR)
			Return SetError(1, 0, 0)
		Case $IMONTHNUM < 1 Or $IMONTHNUM > 12
			Return SetError(1, 0, 0)
		Case Else
			Local $INEXTYEAR
			If $IMONTHNUM = 12 Then
				$INEXTYEAR = $IYEAR + 1
			Else
				$INEXTYEAR = $IYEAR
			EndIf
			$INEXTYEAR = StringFormat("%04d", $INEXTYEAR)
			Return $INEXTYEAR
	EndSelect
EndFunc
Func _DATETIMEFORMAT($SDATE, $STYPE)
	Local $ASDATEPART[4], $ASTIMEPART[4]
	Local $STEMPDATE = "", $STEMPTIME = ""
	Local $SAM, $SPM, $LNGX
	If Not _DATEISVALID($SDATE) Then
		Return SetError(1, 0, "")
	EndIf
	If $STYPE < 0 Or $STYPE > 5 Or Not IsInt($STYPE) Then
		Return SetError(2, 0, "")
	EndIf
	_DATETIMESPLIT($SDATE, $ASDATEPART, $ASTIMEPART)
	Switch $STYPE
		Case 0
			$LNGX = DllCall("kernel32.dll", "int", "GetLocaleInfoW", "dword", 1024, "dword", 31, "wstr", "", "int", 255)
			If Not @error And $LNGX[0] <> 0 Then
				$STEMPDATE = $LNGX[3]
			Else
				$STEMPDATE = "M/d/yyyy"
			EndIf
			If $ASTIMEPART[0] > 1 Then
				$LNGX = DllCall("kernel32.dll", "int", "GetLocaleInfoW", "dword", 1024, "dword", 4099, "wstr", "", "int", 255)
				If Not @error And $LNGX[0] <> 0 Then
					$STEMPTIME = $LNGX[3]
				Else
					$STEMPTIME = "h:mm:ss tt"
				EndIf
			EndIf
		Case 1
			$LNGX = DllCall("kernel32.dll", "int", "GetLocaleInfoW", "dword", 1024, "dword", 32, "wstr", "", "int", 255)
			If Not @error And $LNGX[0] <> 0 Then
				$STEMPDATE = $LNGX[3]
			Else
				$STEMPDATE = "dddd, MMMM dd, yyyy"
			EndIf
		Case 2
			$LNGX = DllCall("kernel32.dll", "int", "GetLocaleInfoW", "dword", 1024, "dword", 31, "wstr", "", "int", 255)
			If Not @error And $LNGX[0] <> 0 Then
				$STEMPDATE = $LNGX[3]
			Else
				$STEMPDATE = "M/d/yyyy"
			EndIf
		Case 3
			If $ASTIMEPART[0] > 1 Then
				$LNGX = DllCall("kernel32.dll", "int", "GetLocaleInfoW", "dword", 1024, "dword", 4099, "wstr", "", "int", 255)
				If Not @error And $LNGX[0] <> 0 Then
					$STEMPTIME = $LNGX[3]
				Else
					$STEMPTIME = "h:mm:ss tt"
				EndIf
			EndIf
		Case 4
			If $ASTIMEPART[0] > 1 Then
				$STEMPTIME = "hh:mm"
			EndIf
		Case 5
			If $ASTIMEPART[0] > 1 Then
				$STEMPTIME = "hh:mm:ss"
			EndIf
	EndSwitch
	If $STEMPDATE <> "" Then
		$LNGX = DllCall("kernel32.dll", "int", "GetLocaleInfoW", "dword", 1024, "dword", 29, "wstr", "", "int", 255)
		If Not @error And $LNGX[0] <> 0 Then
			$STEMPDATE = StringReplace($STEMPDATE, "/", $LNGX[3])
		EndIf
		Local $IWDAY = _DATETODAYOFWEEK($ASDATEPART[1], $ASDATEPART[2], $ASDATEPART[3])
		$ASDATEPART[3] = StringRight("0" & $ASDATEPART[3], 2)
		$ASDATEPART[2] = StringRight("0" & $ASDATEPART[2], 2)
		$STEMPDATE = StringReplace($STEMPDATE, "d", "@")
		$STEMPDATE = StringReplace($STEMPDATE, "m", "#")
		$STEMPDATE = StringReplace($STEMPDATE, "y", "&")
		$STEMPDATE = StringReplace($STEMPDATE, "@@@@", _DATEDAYOFWEEK($IWDAY, 0))
		$STEMPDATE = StringReplace($STEMPDATE, "@@@", _DATEDAYOFWEEK($IWDAY, 1))
		$STEMPDATE = StringReplace($STEMPDATE, "@@", $ASDATEPART[3])
		$STEMPDATE = StringReplace($STEMPDATE, "@", StringReplace(StringLeft($ASDATEPART[3], 1), "0", "") & StringRight($ASDATEPART[3], 1))
		$STEMPDATE = StringReplace($STEMPDATE, "####", _DATETOMONTH($ASDATEPART[2], 0))
		$STEMPDATE = StringReplace($STEMPDATE, "###", _DATETOMONTH($ASDATEPART[2], 1))
		$STEMPDATE = StringReplace($STEMPDATE, "##", $ASDATEPART[2])
		$STEMPDATE = StringReplace($STEMPDATE, "#", StringReplace(StringLeft($ASDATEPART[2], 1), "0", "") & StringRight($ASDATEPART[2], 1))
		$STEMPDATE = StringReplace($STEMPDATE, "&&&&", $ASDATEPART[1])
		$STEMPDATE = StringReplace($STEMPDATE, "&&", StringRight($ASDATEPART[1], 2))
	EndIf
	If $STEMPTIME <> "" Then
		$LNGX = DllCall("kernel32.dll", "int", "GetLocaleInfoW", "dword", 1024, "dword", 40, "wstr", "", "int", 255)
		If Not @error And $LNGX[0] <> 0 Then
			$SAM = $LNGX[3]
		Else
			$SAM = "AM"
		EndIf
		$LNGX = DllCall("kernel32.dll", "int", "GetLocaleInfoW", "dword", 1024, "dword", 41, "wstr", "", "int", 255)
		If Not @error And $LNGX[0] <> 0 Then
			$SPM = $LNGX[3]
		Else
			$SPM = "PM"
		EndIf
		$LNGX = DllCall("kernel32.dll", "int", "GetLocaleInfoW", "dword", 1024, "dword", 30, "wstr", "", "int", 255)
		If Not @error And $LNGX[0] <> 0 Then
			$STEMPTIME = StringReplace($STEMPTIME, ":", $LNGX[3])
		EndIf
		If StringInStr($STEMPTIME, "tt") Then
			If $ASTIMEPART[1] < 12 Then
				$STEMPTIME = StringReplace($STEMPTIME, "tt", $SAM)
				If $ASTIMEPART[1] = 0 Then $ASTIMEPART[1] = 12
			Else
				$STEMPTIME = StringReplace($STEMPTIME, "tt", $SPM)
				If $ASTIMEPART[1] > 12 Then $ASTIMEPART[1] = $ASTIMEPART[1] - 12
			EndIf
		EndIf
		$ASTIMEPART[1] = StringRight("0" & $ASTIMEPART[1], 2)
		$ASTIMEPART[2] = StringRight("0" & $ASTIMEPART[2], 2)
		$ASTIMEPART[3] = StringRight("0" & $ASTIMEPART[3], 2)
		$STEMPTIME = StringReplace($STEMPTIME, "hh", StringFormat("%02d", $ASTIMEPART[1]))
		$STEMPTIME = StringReplace($STEMPTIME, "h", StringReplace(StringLeft($ASTIMEPART[1], 1), "0", "") & StringRight($ASTIMEPART[1], 1))
		$STEMPTIME = StringReplace($STEMPTIME, "mm", StringFormat("%02d", $ASTIMEPART[2]))
		$STEMPTIME = StringReplace($STEMPTIME, "ss", StringFormat("%02d", $ASTIMEPART[3]))
		$STEMPDATE = StringStripWS($STEMPDATE & " " & $STEMPTIME, 3)
	EndIf
	Return $STEMPDATE
EndFunc
Func _DATETIMESPLIT($SDATE, ByRef $ASDATEPART, ByRef $ITIMEPART)
	Local $SDATETIME = StringSplit($SDATE, " T")
	If $SDATETIME[0] > 0 Then $ASDATEPART = StringSplit($SDATETIME[1], "/-.")
	If $SDATETIME[0] > 1 Then
		$ITIMEPART = StringSplit($SDATETIME[2], ":")
		If UBound($ITIMEPART) < 4 Then ReDim $ITIMEPART[4]
	Else
		Dim $ITIMEPART[4]
	EndIf
	If UBound($ASDATEPART) < 4 Then ReDim $ASDATEPART[4]
	For $X = 1 To 3
		If StringIsInt($ASDATEPART[$X]) Then
			$ASDATEPART[$X] = Number($ASDATEPART[$X])
		Else
			$ASDATEPART[$X] = -1
		EndIf
		If StringIsInt($ITIMEPART[$X]) Then
			$ITIMEPART[$X] = Number($ITIMEPART[$X])
		Else
			$ITIMEPART[$X] = 0
		EndIf
	Next
	Return 1
EndFunc
Func _DATETODAYOFWEEK($IYEAR, $IMONTH, $IDAY)
	If Not _DATEISVALID($IYEAR & "/" & $IMONTH & "/" & $IDAY) Then
		Return SetError(1, 0, "")
	EndIf
	Local $I_AFACTOR = Int((14 - $IMONTH) / 12)
	Local $I_YFACTOR = $IYEAR - $I_AFACTOR
	Local $I_MFACTOR = $IMONTH + (12 * $I_AFACTOR) - 2
	Local $I_DFACTOR = Mod($IDAY + $I_YFACTOR + Int($I_YFACTOR / 4) - Int($I_YFACTOR / 100) + Int($I_YFACTOR / 400) + Int((31 * $I_MFACTOR) / 12), 7)
	RETURN ($I_DFACTOR + 1)
EndFunc
Func _DATETODAYOFWEEKISO($IYEAR, $IMONTH, $IDAY)
	Local $IDOW = _DATETODAYOFWEEK($IYEAR, $IMONTH, $IDAY)
	If @error Then
		Return SetError(1, 0, "")
	EndIf
	If $IDOW >= 2 Then Return $IDOW - 1
	Return 7
EndFunc
Func _DATETODAYVALUE($IYEAR, $IMONTH, $IDAY)
	If Not _DATEISVALID(StringFormat("%04d/%02d/%02d", $IYEAR, $IMONTH, $IDAY)) Then
		Return SetError(1, 0, "")
	EndIf
	If $IMONTH < 3 Then
		$IMONTH = $IMONTH + 12
		$IYEAR = $IYEAR - 1
	EndIf
	Local $I_AFACTOR = Int($IYEAR / 100)
	Local $I_BFACTOR = Int($I_AFACTOR / 4)
	Local $I_CFACTOR = 2 - $I_AFACTOR + $I_BFACTOR
	Local $I_EFACTOR = Int(1461 * ($IYEAR + 4716) / 4)
	Local $I_FFACTOR = Int(153 * ($IMONTH + 1) / 5)
	Local $IJULIANDATE = $I_CFACTOR + $IDAY + $I_EFACTOR + $I_FFACTOR - 1524.5
	RETURN ($IJULIANDATE)
EndFunc
Func _DATETOMONTH($IMONTH, $ISHORT = 0)
	Local $AMONTHNUMBER[13] = ["", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
	Local $AMONTHNUMBERABBREV[13] = ["", "Jan", "Feb", "Mar", "Apr", "May", "June", "July", "Aug", "Sept", "Oct", "Nov", "Dec"]
	Select
		Case Not StringIsInt($IMONTH)
			Return SetError(1, 0, "")
		Case $IMONTH < 1 Or $IMONTH > 12
			Return SetError(1, 0, "")
		Case Else
			Select
				Case $ISHORT = 0
					Return $AMONTHNUMBER[$IMONTH]
				Case $ISHORT = 1
					Return $AMONTHNUMBERABBREV[$IMONTH]
				Case Else
					Return SetError(1, 0, "")
			EndSelect
	EndSelect
EndFunc
Func _DAYVALUETODATE($IJULIANDATE, ByRef $IYEAR, ByRef $IMONTH, ByRef $IDAY)
	If $IJULIANDATE < 0 Or Not IsNumber($IJULIANDATE) Then
		Return SetError(1, 0, 0)
	EndIf
	Local $I_ZFACTOR = Int($IJULIANDATE + 0.5)
	Local $I_WFACTOR = Int(($I_ZFACTOR - 1867216.25) / 36524.25)
	Local $I_XFACTOR = Int($I_WFACTOR / 4)
	Local $I_AFACTOR = $I_ZFACTOR + 1 + $I_WFACTOR - $I_XFACTOR
	Local $I_BFACTOR = $I_AFACTOR + 1524
	Local $I_CFACTOR = Int(($I_BFACTOR - 122.1) / 365.25)
	Local $I_DFACTOR = Int(365.25 * $I_CFACTOR)
	Local $I_EFACTOR = Int(($I_BFACTOR - $I_DFACTOR) / 30.6001)
	Local $I_FFACTOR = Int(30.6001 * $I_EFACTOR)
	$IDAY = $I_BFACTOR - $I_DFACTOR - $I_FFACTOR
	If $I_EFACTOR - 1 < 13 Then
		$IMONTH = $I_EFACTOR - 1
	Else
		$IMONTH = $I_EFACTOR - 13
	EndIf
	If $IMONTH < 3 Then
		$IYEAR = $I_CFACTOR - 4715
	Else
		$IYEAR = $I_CFACTOR - 4716
	EndIf
	$IYEAR = StringFormat("%04d", $IYEAR)
	$IMONTH = StringFormat("%02d", $IMONTH)
	$IDAY = StringFormat("%02d", $IDAY)
	Return $IYEAR & "/" & $IMONTH & "/" & $IDAY
EndFunc
Func _DATE_JULIANDAYNO($IYEAR, $IMONTH, $IDAY)
	Local $SFULLDATE = StringFormat("%04d/%02d/%02d", $IYEAR, $IMONTH, $IDAY)
	If Not _DATEISVALID($SFULLDATE) Then
		Return SetError(1, 0, "")
	EndIf
	Local $IJDAY = 0
	Local $AIDAYSINMONTH = _DAYSINMONTH($IYEAR)
	For $ICNTR = 1 To $IMONTH - 1
		$IJDAY = $IJDAY + $AIDAYSINMONTH[$ICNTR]
	Next
	$IJDAY = ($IYEAR * 1000) + ($IJDAY + $IDAY)
	Return $IJDAY
EndFunc
Func _JULIANTODATE($IJDAY, $SSEP = "/")
	Local $IYEAR = Int($IJDAY / 1000)
	Local $IDAYS = Mod($IJDAY, 1000)
	Local $IMAXDAYS = 365
	If _DATEISLEAPYEAR($IYEAR) Then $IMAXDAYS = 366
	If $IDAYS > $IMAXDAYS Then
		Return SetError(1, 0, "")
	EndIf
	Local $AIDAYSINMONTH = _DAYSINMONTH($IYEAR)
	Local $IMONTH = 1
	While $IDAYS > $AIDAYSINMONTH[$IMONTH]
		$IDAYS = $IDAYS - $AIDAYSINMONTH[$IMONTH]
		$IMONTH = $IMONTH + 1
	WEnd
	Return StringFormat("%04d%s%02d%s%02d", $IYEAR, $SSEP, $IMONTH, $SSEP, $IDAYS)
EndFunc
Func _NOW()
	RETURN (_DATETIMEFORMAT(@YEAR & "/" & @MON & "/" & @MDAY & " " & @HOUR & ":" & @MIN & ":" & @SEC, 0))
EndFunc
Func _NOWCALC()
	RETURN (@YEAR & "/" & @MON & "/" & @MDAY & " " & @HOUR & ":" & @MIN & ":" & @SEC)
EndFunc
Func _NOWCALCDATE()
	RETURN (@YEAR & "/" & @MON & "/" & @MDAY)
EndFunc
Func _NOWDATE()
	RETURN (_DATETIMEFORMAT(@YEAR & "/" & @MON & "/" & @MDAY, 0))
EndFunc
Func _NOWTIME($STYPE = 3)
	If $STYPE < 3 Or $STYPE > 5 Then $STYPE = 3
	RETURN (_DATETIMEFORMAT(@YEAR & "/" & @MON & "/" & @MDAY & " " & @HOUR & ":" & @MIN & ":" & @SEC, $STYPE))
EndFunc
Func _SETDATE($IDAY, $IMONTH = 0, $IYEAR = 0)
	If $IYEAR = 0 Then $IYEAR = @YEAR
	If $IMONTH = 0 Then $IMONTH = @MON
	If Not _DATEISVALID($IYEAR & "/" & $IMONTH & "/" & $IDAY) Then Return 1
	Local $TSYSTEMTIME = DllStructCreate($TAGSYSTEMTIME)
	Local $LPSYSTEMTIME = DllStructGetPtr($TSYSTEMTIME)
	DllCall("kernel32.dll", "none", "GetLocalTime", "ptr", $LPSYSTEMTIME)
	If @error Then Return SetError(@error, @extended, 0)
	DllStructSetData($TSYSTEMTIME, 4, $IDAY)
	If $IMONTH > 0 Then DllStructSetData($TSYSTEMTIME, 2, $IMONTH)
	If $IYEAR > 0 Then DllStructSetData($TSYSTEMTIME, 1, $IYEAR)
	Local $IRETVAL = _DATE_TIME_SETLOCALTIME($LPSYSTEMTIME)
	If @error Then Return SetError(@error, @extended, 0)
	Return Int($IRETVAL)
EndFunc
Func _SETTIME($IHOUR, $IMINUTE, $ISECOND = 0)
	If $IHOUR < 0 Or $IHOUR > 23 Then Return 1
	If $IMINUTE < 0 Or $IMINUTE > 59 Then Return 1
	If $ISECOND < 0 Or $ISECOND > 59 Then Return 1
	Local $TSYSTEMTIME = DllStructCreate($TAGSYSTEMTIME)
	Local $LPSYSTEMTIME = DllStructGetPtr($TSYSTEMTIME)
	DllCall("kernel32.dll", "none", "GetLocalTime", "ptr", $LPSYSTEMTIME)
	If @error Then Return SetError(@error, @extended, 0)
	DllStructSetData($TSYSTEMTIME, 5, $IHOUR)
	DllStructSetData($TSYSTEMTIME, 6, $IMINUTE)
	If $ISECOND > 0 Then DllStructSetData($TSYSTEMTIME, 7, $ISECOND)
	Local $IRETVAL = _DATE_TIME_SETLOCALTIME($LPSYSTEMTIME)
	If @error Then Return SetError(@error, @extended, 0)
	Return Int($IRETVAL)
EndFunc
Func _TICKSTOTIME($ITICKS, ByRef $IHOURS, ByRef $IMINS, ByRef $ISECS)
	If Number($ITICKS) > 0 Then
		$ITICKS = Int($ITICKS / 1000)
		$IHOURS = Int($ITICKS / 3600)
		$ITICKS = Mod($ITICKS, 3600)
		$IMINS = Int($ITICKS / 60)
		$ISECS = Mod($ITICKS, 60)
		Return 1
	ElseIf Number($ITICKS) = 0 Then
		$IHOURS = 0
		$ITICKS = 0
		$IMINS = 0
		$ISECS = 0
		Return 1
	Else
		Return SetError(1, 0, 0)
	EndIf
EndFunc
Func _TIMETOTICKS($IHOURS = @HOUR, $IMINS = @MIN, $ISECS = @SEC)
	If StringIsInt($IHOURS) And StringIsInt($IMINS) And StringIsInt($ISECS) Then
		Local $ITICKS = 1000 * ((3600 * $IHOURS) + (60 * $IMINS) + $ISECS)
		Return $ITICKS
	Else
		Return SetError(1, 0, 0)
	EndIf
EndFunc
Func _WEEKNUMBERISO($IYEAR = @YEAR, $IMONTH = @MON, $IDAY = @MDAY)
	If $IDAY > 31 Or $IDAY < 1 Then
		Return SetError(1, 0, -1)
	ElseIf $IMONTH > 12 Or $IMONTH < 1 Then
		Return SetError(1, 0, -1)
	ElseIf $IYEAR < 1 Or $IYEAR > 2999 Then
		Return SetError(1, 0, -1)
	EndIf
	Local $IDOW = _DATETODAYOFWEEKISO($IYEAR, $IMONTH, $IDAY)
	Local $IDOW0101 = _DATETODAYOFWEEKISO($IYEAR, 1, 1)
	IF ($IMONTH = 1 And 3 < $IDOW0101 And $IDOW0101 < 7 - ($IDAY - 1)) Then
		$IDOW = $IDOW0101 - 1
		$IDOW0101 = _DATETODAYOFWEEKISO($IYEAR - 1, 1, 1)
		$IMONTH = 12
		$IDAY = 31
		$IYEAR = $IYEAR - 1
	ELSEIF ($IMONTH = 12 And 30 - ($IDAY - 1) < _DATETODAYOFWEEKISO($IYEAR + 1, 1, 1) And _DATETODAYOFWEEKISO($IYEAR + 1, 1, 1) < 4) Then
		Return 1
	EndIf
	Return Int((_DATETODAYOFWEEKISO($IYEAR, 1, 1) < 4) + 4 * ($IMONTH - 1) + (2 * ($IMONTH - 1) + ($IDAY - 1) + $IDOW0101 - $IDOW + 6) * 36 / 256)
EndFunc
Func _WEEKNUMBER($IYEAR = @YEAR, $IMONTH = @MON, $IDAY = @MDAY, $IWEEKSTART = 1)
	If $IDAY > 31 Or $IDAY < 1 Then
		Return SetError(1, 0, -1)
	ElseIf $IMONTH > 12 Or $IMONTH < 1 Then
		Return SetError(1, 0, -1)
	ElseIf $IYEAR < 1 Or $IYEAR > 2999 Then
		Return SetError(1, 0, -1)
	ElseIf $IWEEKSTART < 1 Or $IWEEKSTART > 2 Then
		Return SetError(2, 0, -1)
	EndIf
	Local $ISTARTWEEK1, $IENDWEEK1
	Local $IDOW0101 = _DATETODAYOFWEEKISO($IYEAR, 1, 1)
	Local $IDATE = $IYEAR & "/" & $IMONTH & "/" & $IDAY
	If $IWEEKSTART = 1 Then
		If $IDOW0101 = 6 Then
			$ISTARTWEEK1 = 0
		Else
			$ISTARTWEEK1 = -1 * $IDOW0101 - 1
		EndIf
		$IENDWEEK1 = $ISTARTWEEK1 + 6
	Else
		$ISTARTWEEK1 = $IDOW0101 * - 1
		$IENDWEEK1 = $ISTARTWEEK1 + 6
	EndIf
	Local $ISTARTWEEK1NY
	Local $IENDWEEK1DATE = _DATEADD("d", $IENDWEEK1, $IYEAR & "/01/01")
	Local $IDOW0101NY = _DATETODAYOFWEEKISO($IYEAR + 1, 1, 1)
	If $IWEEKSTART = 1 Then
		If $IDOW0101NY = 6 Then
			$ISTARTWEEK1NY = 0
		Else
			$ISTARTWEEK1NY = -1 * $IDOW0101NY - 1
		EndIf
	Else
		$ISTARTWEEK1NY = $IDOW0101NY * - 1
	EndIf
	Local $ISTARTWEEK1DATENY = _DATEADD("d", $ISTARTWEEK1NY, $IYEAR + 1 & "/01/01")
	Local $ICURRDATEDIFF = _DATEDIFF("d", $IENDWEEK1DATE, $IDATE) - 1
	Local $ICURRDATEDIFFNY = _DATEDIFF("d", $ISTARTWEEK1DATENY, $IDATE)
	If $ICURRDATEDIFF >= 0 And $ICURRDATEDIFFNY < 0 Then Return 2 + Int($ICURRDATEDIFF / 7)
	If $ICURRDATEDIFF < 0 Or $ICURRDATEDIFFNY >= 0 Then Return 1
EndFunc
Func _DAYSINMONTH($IYEAR)
	Local $AIDAYS[13] = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
	If _DATEISLEAPYEAR($IYEAR) Then $AIDAYS[2] = 29
	Return $AIDAYS
EndFunc
Func __DATE_TIME_CLONESYSTEMTIME($PSYSTEMTIME)
	Local $TSYSTEMTIME1 = DllStructCreate($TAGSYSTEMTIME, $PSYSTEMTIME)
	Local $TSYSTEMTIME2 = DllStructCreate($TAGSYSTEMTIME)
	DllStructSetData($TSYSTEMTIME2, "Month", DllStructGetData($TSYSTEMTIME1, "Month"))
	DllStructSetData($TSYSTEMTIME2, "Day", DllStructGetData($TSYSTEMTIME1, "Day"))
	DllStructSetData($TSYSTEMTIME2, "Year", DllStructGetData($TSYSTEMTIME1, "Year"))
	DllStructSetData($TSYSTEMTIME2, "Hour", DllStructGetData($TSYSTEMTIME1, "Hour"))
	DllStructSetData($TSYSTEMTIME2, "Minute", DllStructGetData($TSYSTEMTIME1, "Minute"))
	DllStructSetData($TSYSTEMTIME2, "Second", DllStructGetData($TSYSTEMTIME1, "Second"))
	DllStructSetData($TSYSTEMTIME2, "MSeconds", DllStructGetData($TSYSTEMTIME1, "MSeconds"))
	DllStructSetData($TSYSTEMTIME2, "DOW", DllStructGetData($TSYSTEMTIME1, "DOW"))
	Return $TSYSTEMTIME2
EndFunc
Func _DATE_TIME_COMPAREFILETIME($PFILETIME1, $PFILETIME2)
	Local $ARESULT = DllCall("kernel32.dll", "long", "CompareFileTime", "ptr", $PFILETIME1, "ptr", $PFILETIME2)
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _DATE_TIME_DOSDATETIMETOFILETIME($IFATDATE, $IFATTIME)
	Local $TTIME = DllStructCreate($TAGFILETIME)
	Local $PTIME = DllStructGetPtr($TTIME)
	Local $ARESULT = DllCall("kernel32.dll", "bool", "DosDateTimeToFileTime", "word", $IFATDATE, "word", $IFATTIME, "ptr", $PTIME)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($ARESULT[0], $TTIME)
EndFunc
Func _DATE_TIME_DOSDATETOARRAY($IDOSDATE)
	Local $ADATE[3]
	$ADATE[0] = BitAND($IDOSDATE, 31)
	$ADATE[1] = BitAND(BitShift($IDOSDATE, 5), 15)
	$ADATE[2] = BitAND(BitShift($IDOSDATE, 9), 63) + 1980
	Return $ADATE
EndFunc
Func _DATE_TIME_DOSDATETIMETOARRAY($IDOSDATE, $IDOSTIME)
	Local $ADATE[6]
	$ADATE[0] = BitAND($IDOSDATE, 31)
	$ADATE[1] = BitAND(BitShift($IDOSDATE, 5), 15)
	$ADATE[2] = BitAND(BitShift($IDOSDATE, 9), 63) + 1980
	$ADATE[5] = BitAND($IDOSTIME, 31) * 2
	$ADATE[4] = BitAND(BitShift($IDOSTIME, 5), 63)
	$ADATE[3] = BitAND(BitShift($IDOSTIME, 11), 31)
	Return $ADATE
EndFunc
Func _DATE_TIME_DOSDATETIMETOSTR($IDOSDATE, $IDOSTIME)
	Local $ADATE = _DATE_TIME_DOSDATETIMETOARRAY($IDOSDATE, $IDOSTIME)
	Return StringFormat("%02d/%02d/%04d %02d:%02d:%02d", $ADATE[0], $ADATE[1], $ADATE[2], $ADATE[3], $ADATE[4], $ADATE[5])
EndFunc
Func _DATE_TIME_DOSDATETOSTR($IDOSDATE)
	Local $ADATE = _DATE_TIME_DOSDATETOARRAY($IDOSDATE)
	Return StringFormat("%02d/%02d/%04d", $ADATE[0], $ADATE[1], $ADATE[2])
EndFunc
Func _DATE_TIME_DOSTIMETOARRAY($IDOSTIME)
	Local $ATIME[3]
	$ATIME[2] = BitAND($IDOSTIME, 31) * 2
	$ATIME[1] = BitAND(BitShift($IDOSTIME, 5), 63)
	$ATIME[0] = BitAND(BitShift($IDOSTIME, 11), 31)
	Return $ATIME
EndFunc
Func _DATE_TIME_DOSTIMETOSTR($IDOSTIME)
	Local $ATIME = _DATE_TIME_DOSTIMETOARRAY($IDOSTIME)
	Return StringFormat("%02d:%02d:%02d", $ATIME[0], $ATIME[1], $ATIME[2])
EndFunc
Func _DATE_TIME_ENCODEFILETIME($IMONTH, $IDAY, $IYEAR, $IHOUR = 0, $IMINUTE = 0, $ISECOND = 0, $IMSECONDS = 0)
	Local $TSYSTEMTIME = _DATE_TIME_ENCODESYSTEMTIME($IMONTH, $IDAY, $IYEAR, $IHOUR, $IMINUTE, $ISECOND, $IMSECONDS)
	Return _DATE_TIME_SYSTEMTIMETOFILETIME(DllStructGetPtr($TSYSTEMTIME))
EndFunc
Func _DATE_TIME_ENCODESYSTEMTIME($IMONTH, $IDAY, $IYEAR, $IHOUR = 0, $IMINUTE = 0, $ISECOND = 0, $IMSECONDS = 0)
	Local $TSYSTEMTIME = DllStructCreate($TAGSYSTEMTIME)
	DllStructSetData($TSYSTEMTIME, "Month", $IMONTH)
	DllStructSetData($TSYSTEMTIME, "Day", $IDAY)
	DllStructSetData($TSYSTEMTIME, "Year", $IYEAR)
	DllStructSetData($TSYSTEMTIME, "Hour", $IHOUR)
	DllStructSetData($TSYSTEMTIME, "Minute", $IMINUTE)
	DllStructSetData($TSYSTEMTIME, "Second", $ISECOND)
	DllStructSetData($TSYSTEMTIME, "MSeconds", $IMSECONDS)
	Return $TSYSTEMTIME
EndFunc
Func _DATE_TIME_FILETIMETOARRAY(ByRef $TFILETIME)
	IF ((DllStructGetData($TFILETIME, 1) + DllStructGetData($TFILETIME, 2)) = 0) Then Return SetError(1, 0, 0)
	Local $TSYSTEMTIME = _DATE_TIME_FILETIMETOSYSTEMTIME(DllStructGetPtr($TFILETIME))
	If @error Then Return SetError(@error, @extended, 0)
	Return _DATE_TIME_SYSTEMTIMETOARRAY($TSYSTEMTIME)
EndFunc
Func _DATE_TIME_FILETIMETOSTR(ByRef $TFILETIME, $BFMT = 0)
	Local $ADATE = _DATE_TIME_FILETIMETOARRAY($TFILETIME)
	If @error Then Return SetError(@error, @extended, "")
	If $BFMT Then
		Return StringFormat("%04d/%02d/%02d %02d:%02d:%02d", $ADATE[2], $ADATE[1], $ADATE[0], $ADATE[3], $ADATE[4], $ADATE[5])
	Else
		Return StringFormat("%02d/%02d/%04d %02d:%02d:%02d", $ADATE[0], $ADATE[1], $ADATE[2], $ADATE[3], $ADATE[4], $ADATE[5])
	EndIf
EndFunc
Func _DATE_TIME_FILETIMETODOSDATETIME($PFILETIME)
	Local $ADATE[2]
	Local $ARESULT = DllCall("kernel32.dll", "bool", "FileTimeToDosDateTime", "ptr", $PFILETIME, "word*", 0, "word*", 0)
	If @error Then Return SetError(@error, @extended, $ADATE)
	$ADATE[0] = $ARESULT[2]
	$ADATE[1] = $ARESULT[3]
	Return SetExtended($ARESULT[0], $ADATE)
EndFunc
Func _DATE_TIME_FILETIMETOLOCALFILETIME($PFILETIME)
	Local $TLOCAL = DllStructCreate($TAGFILETIME)
	Local $ARESULT = DllCall("kernel32.dll", "bool", "FileTimeToLocalFileTime", "ptr", $PFILETIME, "ptr", DllStructGetPtr($TLOCAL))
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($ARESULT[0], $TLOCAL)
EndFunc
Func _DATE_TIME_FILETIMETOSYSTEMTIME($PFILETIME)
	Local $TSYSTTIME = DllStructCreate($TAGSYSTEMTIME)
	Local $ARESULT = DllCall("kernel32.dll", "bool", "FileTimeToSystemTime", "ptr", $PFILETIME, "ptr", DllStructGetPtr($TSYSTTIME))
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($ARESULT[0], $TSYSTTIME)
EndFunc
Func _DATE_TIME_GETFILETIME($HFILE)
	Local $ADATE[3]
	$ADATE[0] = DllStructCreate($TAGFILETIME)
	$ADATE[1] = DllStructCreate($TAGFILETIME)
	$ADATE[2] = DllStructCreate($TAGFILETIME)
	Local $PCT = DllStructGetPtr($ADATE[0])
	Local $PLA = DllStructGetPtr($ADATE[1])
	Local $PLM = DllStructGetPtr($ADATE[2])
	Local $ARESULT = DllCall("Kernel32.dll", "bool", "GetFileTime", "handle", $HFILE, "ptr", $PCT, "ptr", $PLA, "ptr", $PLM)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($ARESULT[0], $ADATE)
EndFunc
Func _DATE_TIME_GETLOCALTIME()
	Local $TSYSTTIME = DllStructCreate($TAGSYSTEMTIME)
	DllCall("kernel32.dll", "none", "GetLocalTime", "ptr", DllStructGetPtr($TSYSTTIME))
	If @error Then Return SetError(@error, @extended, 0)
	Return $TSYSTTIME
EndFunc
Func _DATE_TIME_GETSYSTEMTIME()
	Local $TSYSTTIME = DllStructCreate($TAGSYSTEMTIME)
	DllCall("kernel32.dll", "none", "GetSystemTime", "ptr", DllStructGetPtr($TSYSTTIME))
	If @error Then Return SetError(@error, @extended, 0)
	Return $TSYSTTIME
EndFunc
Func _DATE_TIME_GETSYSTEMTIMEADJUSTMENT()
	Local $AINFO[3]
	Local $ARESULT = DllCall("kernel32.dll", "bool", "GetSystemTimeAdjustment", "dword*", 0, "dword*", 0, "bool*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	$AINFO[0] = $ARESULT[1]
	$AINFO[1] = $ARESULT[2]
	$AINFO[2] = $ARESULT[3] <> 0
	Return SetExtended($ARESULT[0], $AINFO)
EndFunc
Func _DATE_TIME_GETSYSTEMTIMEASFILETIME()
	Local $TFILETIME = DllStructCreate($TAGFILETIME)
	DllCall("kernel32.dll", "none", "GetSystemTimeAsFileTime", "ptr", DllStructGetPtr($TFILETIME))
	If @error Then Return SetError(@error, @extended, 0)
	Return $TFILETIME
EndFunc
Func _DATE_TIME_GETSYSTEMTIMES()
	Local $AINFO[3]
	$AINFO[0] = DllStructCreate($TAGFILETIME)
	$AINFO[1] = DllStructCreate($TAGFILETIME)
	$AINFO[2] = DllStructCreate($TAGFILETIME)
	Local $PIDLE = DllStructGetPtr($AINFO[0])
	Local $PKERNEL = DllStructGetPtr($AINFO[1])
	Local $PUSER = DllStructGetPtr($AINFO[2])
	Local $ARESULT = DllCall("kernel32.dll", "bool", "GetSystemTimes", "ptr", $PIDLE, "ptr", $PKERNEL, "ptr", $PUSER)
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($ARESULT[0], $AINFO)
EndFunc
Func _DATE_TIME_GETTICKCOUNT()
	Local $ARESULT = DllCall("kernel32.dll", "dword", "GetTickCount")
	If @error Then Return SetError(@error, @extended, 0)
	Return $ARESULT[0]
EndFunc
Func _DATE_TIME_GETTIMEZONEINFORMATION()
	Local $TTIMEZONE = DllStructCreate($TAGTIME_ZONE_INFORMATION)
	Local $ARESULT = DllCall("kernel32.dll", "dword", "GetTimeZoneInformation", "ptr", DllStructGetPtr($TTIMEZONE))
	If @error Or $ARESULT[0] = -1 Then Return SetError(@error, @extended, 0)
	Local $AINFO[8]
	$AINFO[0] = $ARESULT[0]
	$AINFO[1] = DllStructGetData($TTIMEZONE, "Bias")
	$AINFO[2] = _WINAPI_WIDECHARTOMULTIBYTE(DllStructGetPtr($TTIMEZONE, "StdName"))
	$AINFO[3] = __DATE_TIME_CLONESYSTEMTIME(DllStructGetPtr($TTIMEZONE, "StdDate"))
	$AINFO[4] = DllStructGetData($TTIMEZONE, "StdBias")
	$AINFO[5] = _WINAPI_WIDECHARTOMULTIBYTE(DllStructGetPtr($TTIMEZONE, "DayName"))
	$AINFO[6] = __DATE_TIME_CLONESYSTEMTIME(DllStructGetPtr($TTIMEZONE, "DayDate"))
	$AINFO[7] = DllStructGetData($TTIMEZONE, "DayBias")
	Return $AINFO
EndFunc
Func _DATE_TIME_LOCALFILETIMETOFILETIME($PLOCALTIME)
	Local $TFILETIME = DllStructCreate($TAGFILETIME)
	Local $ARESULT = DllCall("kernel32.dll", "bool", "LocalFileTimeToFileTime", "ptr", $PLOCALTIME, "ptr", DllStructGetPtr($TFILETIME))
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($ARESULT[0], $TFILETIME)
EndFunc
Func _DATE_TIME_SETFILETIME($HFILE, $PCREATETIME, $PLASTACCESS, $PLASTWRITE)
	Local $ARESULT = DllCall("kernel32.dll", "bool", "SetFileTime", "handle", $HFILE, "ptr", $PCREATETIME, "ptr", $PLASTACCESS, "ptr", $PLASTWRITE)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _DATE_TIME_SETLOCALTIME($PSYSTEMTIME)
	Local $ARESULT = DllCall("kernel32.dll", "bool", "SetLocalTime", "ptr", $PSYSTEMTIME)
	If @error Or Not $ARESULT[0] Then Return SetError(@error, @extended, False)
	$ARESULT = DllCall("kernel32.dll", "bool", "SetLocalTime", "ptr", $PSYSTEMTIME)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _DATE_TIME_SETSYSTEMTIME($PSYSTEMTIME)
	Local $ARESULT = DllCall("kernel32.dll", "bool", "SetSystemTime", "ptr", $PSYSTEMTIME)
	If @error Then Return SetError(@error, @extended, False)
	Return $ARESULT[0]
EndFunc
Func _DATE_TIME_SETSYSTEMTIMEADJUSTMENT($IADJUSTMENT, $FDISABLED)
	Local $HTOKEN = _SECURITY__OPENTHREADTOKENEX(BitOR($TOKEN_ADJUST_PRIVILEGES, $TOKEN_QUERY))
	If @error Then Return SetError(@error, @extended, False)
	_SECURITY__SETPRIVILEGE($HTOKEN, "SeSystemtimePrivilege", True)
	Local $IERROR = @error
	Local $ILASTERROR = @extended
	Local $IRET = False
	If Not @error Then
		Local $ARESULT = DllCall("kernel32.dll", "bool", "SetSystemTimeAdjustment", "dword", $IADJUSTMENT, "bool", $FDISABLED)
		If @error Then
			$IERROR = @error
			$ILASTERROR = @extended
		ElseIf $ARESULT[0] Then
			$IRET = True
		Else
			$IERROR = 1
			$ILASTERROR = _WINAPI_GETLASTERROR()
		EndIf
		_SECURITY__SETPRIVILEGE($HTOKEN, "SeSystemtimePrivilege", False)
		If @error Then $IERROR = 2
	EndIf
	_WINAPI_CLOSEHANDLE($HTOKEN)
	Return SetError($IERROR, $ILASTERROR, $IRET)
EndFunc
Func _DATE_TIME_SETTIMEZONEINFORMATION($IBIAS, $SSTDNAME, $TSTDDATE, $ISTDBIAS, $SDAYNAME, $TDAYDATE, $IDAYBIAS)
	Local $TSTDNAME = _WINAPI_MULTIBYTETOWIDECHAR($SSTDNAME)
	Local $TDAYNAME = _WINAPI_MULTIBYTETOWIDECHAR($SDAYNAME)
	Local $TZONEINFO = DllStructCreate($TAGTIME_ZONE_INFORMATION)
	DllStructSetData($TZONEINFO, "Bias", $IBIAS)
	DllStructSetData($TZONEINFO, "StdName", DllStructGetData($TSTDNAME, 1))
	_MEMMOVEMEMORY(DllStructGetPtr($TSTDDATE), DllStructGetPtr($TZONEINFO, "StdDate"), DllStructGetSize($TSTDDATE))
	DllStructSetData($TZONEINFO, "StdBias", $ISTDBIAS)
	DllStructSetData($TZONEINFO, "DayName", DllStructGetData($TDAYNAME, 1))
	_MEMMOVEMEMORY(DllStructGetPtr($TDAYDATE), DllStructGetPtr($TZONEINFO, "DayDate"), DllStructGetSize($TDAYDATE))
	DllStructSetData($TZONEINFO, "DayBias", $IDAYBIAS)
	Local $HTOKEN = _SECURITY__OPENTHREADTOKENEX(BitOR($TOKEN_ADJUST_PRIVILEGES, $TOKEN_QUERY))
	If @error Then Return SetError(@error, @extended, False)
	_SECURITY__SETPRIVILEGE($HTOKEN, "SeSystemtimePrivilege", True)
	Local $IERROR = @error
	Local $ILASTERROR = @extended
	Local $IRET = False
	If Not @error Then
		Local $ARESULT = DllCall("kernel32.dll", "bool", "SetTimeZoneInformation", "ptr", DllStructGetPtr($TZONEINFO))
		If @error Then
			$IERROR = @error
			$ILASTERROR = @extended
		ElseIf $ARESULT[0] Then
			$ILASTERROR = 0
			$IRET = True
		Else
			$IERROR = 1
			$ILASTERROR = _WINAPI_GETLASTERROR()
		EndIf
		_SECURITY__SETPRIVILEGE($HTOKEN, "SeSystemtimePrivilege", False)
		If @error Then $IERROR = 2
	EndIf
	_WINAPI_CLOSEHANDLE($HTOKEN)
	Return SetError($IERROR, $ILASTERROR, $IRET)
EndFunc
Func _DATE_TIME_SYSTEMTIMETOARRAY(ByRef $TSYSTEMTIME)
	Local $AINFO[8]
	$AINFO[0] = DllStructGetData($TSYSTEMTIME, "Month")
	$AINFO[1] = DllStructGetData($TSYSTEMTIME, "Day")
	$AINFO[2] = DllStructGetData($TSYSTEMTIME, "Year")
	$AINFO[3] = DllStructGetData($TSYSTEMTIME, "Hour")
	$AINFO[4] = DllStructGetData($TSYSTEMTIME, "Minute")
	$AINFO[5] = DllStructGetData($TSYSTEMTIME, "Second")
	$AINFO[6] = DllStructGetData($TSYSTEMTIME, "MSeconds")
	$AINFO[7] = DllStructGetData($TSYSTEMTIME, "DOW")
	Return $AINFO
EndFunc
Func _DATE_TIME_SYSTEMTIMETODATESTR(ByRef $TSYSTEMTIME, $BFMT = 0)
	Local $AINFO = _DATE_TIME_SYSTEMTIMETOARRAY($TSYSTEMTIME)
	If @error Then Return SetError(@error, @extended, "")
	If $BFMT Then
		Return StringFormat("%04d/%02d/%02d", $AINFO[2], $AINFO[0], $AINFO[1])
	Else
		Return StringFormat("%02d/%02d/%04d", $AINFO[0], $AINFO[1], $AINFO[2])
	EndIf
EndFunc
Func _DATE_TIME_SYSTEMTIMETODATETIMESTR(ByRef $TSYSTEMTIME, $BFMT = 0)
	Local $AINFO = _DATE_TIME_SYSTEMTIMETOARRAY($TSYSTEMTIME)
	If @error Then Return SetError(@error, @extended, "")
	If $BFMT Then
		Return StringFormat("%04d/%02d/%02d %02d:%02d:%02d", $AINFO[2], $AINFO[0], $AINFO[1], $AINFO[3], $AINFO[4], $AINFO[5])
	Else
		Return StringFormat("%02d/%02d/%04d %02d:%02d:%02d", $AINFO[0], $AINFO[1], $AINFO[2], $AINFO[3], $AINFO[4], $AINFO[5])
	EndIf
EndFunc
Func _DATE_TIME_SYSTEMTIMETOFILETIME($PSYSTEMTIME)
	Local $TFILETIME = DllStructCreate($TAGFILETIME)
	Local $ARESULT = DllCall("kernel32.dll", "bool", "SystemTimeToFileTime", "ptr", $PSYSTEMTIME, "ptr", DllStructGetPtr($TFILETIME))
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($ARESULT[0], $TFILETIME)
EndFunc
Func _DATE_TIME_SYSTEMTIMETOTIMESTR(ByRef $TSYSTEMTIME)
	Local $AINFO = _DATE_TIME_SYSTEMTIMETOARRAY($TSYSTEMTIME)
	Return StringFormat("%02d:%02d:%02d", $AINFO[3], $AINFO[4], $AINFO[5])
EndFunc
Func _DATE_TIME_SYSTEMTIMETOTZSPECIFICLOCALTIME($PUTC, $PTIMEZONE = 0)
	Local $TLOCALTIME = DllStructCreate($TAGSYSTEMTIME)
	Local $ARESULT = DllCall("kernel32.dll", "bool", "SystemTimeToTzSpecificLocalTime", "ptr", $PTIMEZONE, "ptr", $PUTC, "ptr", DllStructGetPtr($TLOCALTIME))
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($ARESULT[0], $TLOCALTIME)
EndFunc
Func _DATE_TIME_TZSPECIFICLOCALTIMETOSYSTEMTIME($PLOCALTIME, $PTIMEZONE = 0)
	Local $TUTC = DllStructCreate($TAGSYSTEMTIME)
	Local $ARESULT = DllCall("kernel32.dll", "ptr", "TzSpecificLocalTimeToSystemTime", "ptr", $PTIMEZONE, "ptr", $PLOCALTIME, "ptr", DllStructGetPtr($TUTC))
	If @error Then Return SetError(@error, @extended, 0)
	Return SetExtended($ARESULT[0], $TUTC)
EndFunc
Global Const $CB_ERR = -1
Global Const $CB_ERRATTRIBUTE = -3
Global Const $CB_ERRREQUIRED = -4
Global Const $CB_ERRSPACE = -2
Global Const $CB_OKAY = 0
Global Const $STATE_SYSTEM_INVISIBLE = 32768
Global Const $STATE_SYSTEM_PRESSED = 8
Global Const $CBS_AUTOHSCROLL = 64
Global Const $CBS_DISABLENOSCROLL = 2048
Global Const $CBS_DROPDOWN = 2
Global Const $CBS_DROPDOWNLIST = 3
Global Const $CBS_HASSTRINGS = 512
Global Const $CBS_LOWERCASE = 16384
Global Const $CBS_NOINTEGRALHEIGHT = 1024
Global Const $CBS_OEMCONVERT = 128
Global Const $CBS_OWNERDRAWFIXED = 16
Global Const $CBS_OWNERDRAWVARIABLE = 32
Global Const $CBS_SIMPLE = 1
Global Const $CBS_SORT = 256
Global Const $CBS_UPPERCASE = 8192
Global Const $CBM_FIRST = 5888
Global Const $CB_ADDSTRING = 323
Global Const $CB_DELETESTRING = 324
Global Const $CB_DIR = 325
Global Const $CB_FINDSTRING = 332
Global Const $CB_FINDSTRINGEXACT = 344
Global Const $CB_GETCOMBOBOXINFO = 356
Global Const $CB_GETCOUNT = 326
Global Const $CB_GETCUEBANNER = ($CBM_FIRST + 4)
Global Const $CB_GETCURSEL = 327
Global Const $CB_GETDROPPEDCONTROLRECT = 338
Global Const $CB_GETDROPPEDSTATE = 343
Global Const $CB_GETDROPPEDWIDTH = 351
Global Const $CB_GETEDITSEL = 320
Global Const $CB_GETEXTENDEDUI = 342
Global Const $CB_GETHORIZONTALEXTENT = 349
Global Const $CB_GETITEMDATA = 336
Global Const $CB_GETITEMHEIGHT = 340
Global Const $CB_GETLBTEXT = 328
Global Const $CB_GETLBTEXTLEN = 329
Global Const $CB_GETLOCALE = 346
Global Const $CB_GETMINVISIBLE = 5890
Global Const $CB_GETTOPINDEX = 347
Global Const $CB_INITSTORAGE = 353
Global Const $CB_LIMITTEXT = 321
Global Const $CB_RESETCONTENT = 331
Global Const $CB_INSERTSTRING = 330
Global Const $CB_SELECTSTRING = 333
Global Const $CB_SETCUEBANNER = ($CBM_FIRST + 3)
Global Const $CB_SETCURSEL = 334
Global Const $CB_SETDROPPEDWIDTH = 352
Global Const $CB_SETEDITSEL = 322
Global Const $CB_SETEXTENDEDUI = 341
Global Const $CB_SETHORIZONTALEXTENT = 350
Global Const $CB_SETITEMDATA = 337
Global Const $CB_SETITEMHEIGHT = 339
Global Const $CB_SETLOCALE = 345
Global Const $CB_SETMINVISIBLE = 5889
Global Const $CB_SETTOPINDEX = 348
Global Const $CB_SHOWDROPDOWN = 335
Global Const $CBN_CLOSEUP = 8
Global Const $CBN_DBLCLK = 2
Global Const $CBN_DROPDOWN = 7
Global Const $CBN_EDITCHANGE = 5
Global Const $CBN_EDITUPDATE = 6
Global Const $CBN_ERRSPACE = (-1)
Global Const $CBN_KILLFOCUS = 4
Global Const $CBN_SELCHANGE = 1
Global Const $CBN_SELENDCANCEL = 10
Global Const $CBN_SELENDOK = 9
Global Const $CBN_SETFOCUS = 3
Global Const $CBES_EX_CASESENSITIVE = 16
Global Const $CBES_EX_NOEDITIMAGE = 1
Global Const $CBES_EX_NOEDITIMAGEINDENT = 2
Global Const $CBES_EX_NOSIZELIMIT = 8
Global Const $CBES_EX_PATHWORDBREAKPROC = 4
Global Const $__COMBOBOXCONSTANT_WM_USER = 1024
Global Const $CBEM_DELETEITEM = $CB_DELETESTRING
Global Const $CBEM_GETCOMBOCONTROL = ($__COMBOBOXCONSTANT_WM_USER + 6)
Global Const $CBEM_GETEDITCONTROL = ($__COMBOBOXCONSTANT_WM_USER + 7)
Global Const $CBEM_GETEXSTYLE = ($__COMBOBOXCONSTANT_WM_USER + 9)
Global Const $CBEM_GETEXTENDEDSTYLE = ($__COMBOBOXCONSTANT_WM_USER + 9)
Global Const $CBEM_GETIMAGELIST = ($__COMBOBOXCONSTANT_WM_USER + 3)
Global Const $CBEM_GETITEMA = ($__COMBOBOXCONSTANT_WM_USER + 4)
Global Const $CBEM_GETITEMW = ($__COMBOBOXCONSTANT_WM_USER + 13)
Global Const $CBEM_GETUNICODEFORMAT = 8192 + 6
Global Const $CBEM_HASEDITCHANGED = ($__COMBOBOXCONSTANT_WM_USER + 10)
Global Const $CBEM_INSERTITEMA = ($__COMBOBOXCONSTANT_WM_USER + 1)
Global Const $CBEM_INSERTITEMW = ($__COMBOBOXCONSTANT_WM_USER + 11)
Global Const $CBEM_SETEXSTYLE = ($__COMBOBOXCONSTANT_WM_USER + 8)
Global Const $CBEM_SETEXTENDEDSTYLE = ($__COMBOBOXCONSTANT_WM_USER + 14)
Global Const $CBEM_SETIMAGELIST = ($__COMBOBOXCONSTANT_WM_USER + 2)
Global Const $CBEM_SETITEMA = ($__COMBOBOXCONSTANT_WM_USER + 5)
Global Const $CBEM_SETITEMW = ($__COMBOBOXCONSTANT_WM_USER + 12)
Global Const $CBEM_SETUNICODEFORMAT = 8192 + 5
Global Const $CBEM_SETWINDOWTHEME = 8192 + 11
Global Const $CBEN_FIRST = (-800)
Global Const $CBEN_LAST = (-830)
Global Const $CBEN_BEGINEDIT = ($CBEN_FIRST - 4)
Global Const $CBEN_DELETEITEM = ($CBEN_FIRST - 2)
Global Const $CBEN_DRAGBEGINA = ($CBEN_FIRST - 8)
Global Const $CBEN_DRAGBEGINW = ($CBEN_FIRST - 9)
Global Const $CBEN_ENDEDITA = ($CBEN_FIRST - 5)
Global Const $CBEN_ENDEDITW = ($CBEN_FIRST - 6)
Global Const $CBEN_GETDISPINFO = ($CBEN_FIRST - 0)
Global Const $CBEN_GETDISPINFOA = ($CBEN_FIRST - 0)
Global Const $CBEN_GETDISPINFOW = ($CBEN_FIRST - 7)
Global Const $CBEN_INSERTITEM = ($CBEN_FIRST - 1)
Global Const $CBEIF_DI_SETITEM = 268435456
Global Const $CBEIF_IMAGE = 2
Global Const $CBEIF_INDENT = 16
Global Const $CBEIF_LPARAM = 32
Global Const $CBEIF_OVERLAY = 8
Global Const $CBEIF_SELECTEDIMAGE = 4
Global Const $CBEIF_TEXT = 1
Global Const $__COMBOBOXCONSTANT_WS_VSCROLL = 2097152
Global Const $GUI_SS_DEFAULT_COMBO = BitOR($CBS_DROPDOWN, $CBS_AUTOHSCROLL, $__COMBOBOXCONSTANT_WS_VSCROLL)
Global Const $DDL_ARCHIVE = 32
Global Const $DDL_DIRECTORY = 16
Global Const $DDL_DRIVES = 16384
Global Const $DDL_EXCLUSIVE = 32768
Global Const $DDL_HIDDEN = 2
Global Const $DDL_READONLY = 1
Global Const $DDL_READWRITE = 0
Global Const $DDL_SYSTEM = 4
Global Const $_UDF_GLOBALIDS_OFFSET = 2
Global Const $_UDF_GLOBALID_MAX_WIN = 16
Global Const $_UDF_STARTID = 10000
Global Const $_UDF_GLOBALID_MAX_IDS = 55535
Global Const $__UDFGUICONSTANT_WS_VISIBLE = 268435456
Global Const $__UDFGUICONSTANT_WS_CHILD = 1073741824
Global $_UDF_GLOBALIDS_USED[$_UDF_GLOBALID_MAX_WIN][$_UDF_GLOBALID_MAX_IDS + $_UDF_GLOBALIDS_OFFSET + 1]
Func __UDF_GETNEXTGLOBALID($HWND)
	Local $NCTRLID, $IUSEDINDEX = -1, $FALLUSED = True
	If Not WinExists($HWND) Then Return SetError(-1, -1, 0)
	For $IINDEX = 0 To $_UDF_GLOBALID_MAX_WIN - 1
		If $_UDF_GLOBALIDS_USED[$IINDEX][0] <> 0 Then
			If Not WinExists($_UDF_GLOBALIDS_USED[$IINDEX][0]) Then
				For $X = 0 To UBound($_UDF_GLOBALIDS_USED, 2) - 1
					$_UDF_GLOBALIDS_USED[$IINDEX][$X] = 0
				Next
				$_UDF_GLOBALIDS_USED[$IINDEX][1] = $_UDF_STARTID
				$FALLUSED = False
			EndIf
		EndIf
	Next
	For $IINDEX = 0 To $_UDF_GLOBALID_MAX_WIN - 1
		If $_UDF_GLOBALIDS_USED[$IINDEX][0] = $HWND Then
			$IUSEDINDEX = $IINDEX
			ExitLoop
		EndIf
	Next
	If $IUSEDINDEX = -1 Then
		For $IINDEX = 0 To $_UDF_GLOBALID_MAX_WIN - 1
			If $_UDF_GLOBALIDS_USED[$IINDEX][0] = 0 Then
				$_UDF_GLOBALIDS_USED[$IINDEX][0] = $HWND
				$_UDF_GLOBALIDS_USED[$IINDEX][1] = $_UDF_STARTID
				$FALLUSED = False
				$IUSEDINDEX = $IINDEX
				ExitLoop
			EndIf
		Next
	EndIf
	If $IUSEDINDEX = -1 And $FALLUSED Then Return SetError(16, 0, 0)
	If $_UDF_GLOBALIDS_USED[$IUSEDINDEX][1] = $_UDF_STARTID + $_UDF_GLOBALID_MAX_IDS Then
		For $IIDINDEX = $_UDF_GLOBALIDS_OFFSET To UBound($_UDF_GLOBALIDS_USED, 2) - 1
			If $_UDF_GLOBALIDS_USED[$IUSEDINDEX][$IIDINDEX] = 0 Then
				$NCTRLID = ($IIDINDEX - $_UDF_GLOBALIDS_OFFSET) + 10000
				$_UDF_GLOBALIDS_USED[$IUSEDINDEX][$IIDINDEX] = $NCTRLID
				Return $NCTRLID
			EndIf
		Next
		Return SetError(-1, $_UDF_GLOBALID_MAX_IDS, 0)
	EndIf
	$NCTRLID = $_UDF_GLOBALIDS_USED[$IUSEDINDEX][1]
	$_UDF_GLOBALIDS_USED[$IUSEDINDEX][1] += 1
	$_UDF_GLOBALIDS_USED[$IUSEDINDEX][($NCTRLID - 10000) + $_UDF_GLOBALIDS_OFFSET] = $NCTRLID
	Return $NCTRLID
EndFunc
Func __UDF_FREEGLOBALID($HWND, $IGLOBALID)
	If $IGLOBALID - $_UDF_STARTID < 0 Or $IGLOBALID - $_UDF_STARTID > $_UDF_GLOBALID_MAX_IDS Then Return SetError(-1, 0, False)
	For $IINDEX = 0 To $_UDF_GLOBALID_MAX_WIN - 1
		If $_UDF_GLOBALIDS_USED[$IINDEX][0] = $HWND Then
			For $X = $_UDF_GLOBALIDS_OFFSET To UBound($_UDF_GLOBALIDS_USED, 2) - 1
				If $_UDF_GLOBALIDS_USED[$IINDEX][$X] = $IGLOBALID Then
					$_UDF_GLOBALIDS_USED[$IINDEX][$X] = 0
					Return True
				EndIf
			Next
			Return SetError(-3, 0, False)
		EndIf
	Next
	Return SetError(-2, 0, False)
EndFunc
Func __UDF_DEBUGPRINT($STEXT, $ILINE = @ScriptLineNumber, $ERR = @error, $EXT = @extended)
	ConsoleWrite("!===========================================================" & @CRLF & "+======================================================" & @CRLF & "-->Line(" & StringFormat("%04d", $ILINE) & "):" & @TAB & $STEXT & @CRLF & "+======================================================" & @CRLF)
	Return SetError($ERR, $EXT, 1)
EndFunc
Func __UDF_VALIDATECLASSNAME($HWND, $SCLASSNAMES)
	__UDF_DEBUGPRINT("This is for debugging only, set the debug variable to false before submitting")
	If _WINAPI_ISCLASSNAME($HWND, $SCLASSNAMES) Then Return True
	Local $SSEPARATOR = Opt("GUIDataSeparatorChar")
	$SCLASSNAMES = StringReplace($SCLASSNAMES, $SSEPARATOR, ",")
	__UDF_DEBUGPRINT("Invalid Class Type(s):" & @LF & @TAB & "Expecting Type(s): " & $SCLASSNAMES & @LF & @TAB & "Received Type : " & _WINAPI_GETCLASSNAME($HWND))
	Exit
EndFunc
Global $_GHCBLASTWND
Global $DEBUG_CB = False
Global Const $__COMBOBOXCONSTANT_CLASSNAME = "ComboBox"
Global Const $__COMBOBOXCONSTANT_EM_GETLINE = 196
Global Const $__COMBOBOXCONSTANT_EM_LINEINDEX = 187
Global Const $__COMBOBOXCONSTANT_EM_LINELENGTH = 193
Global Const $__COMBOBOXCONSTANT_EM_REPLACESEL = 194
Global Const $__COMBOBOXCONSTANT_WM_SETREDRAW = 11
Global Const $__COMBOBOXCONSTANT_WS_TABSTOP = 65536
Global Const $__COMBOBOXCONSTANT_DEFAULT_GUI_FONT = 17
Global Const $TAGCOMBOBOXINFO = "dword Size;long EditLeft;long EditTop;long EditRight;long EditBottom;long BtnLeft;long BtnTop;" & "long BtnRight;long BtnBottom;dword BtnState;hwnd hCombo;hwnd hEdit;hwnd hList"
Func _GUICTRLCOMBOBOX_ADDDIR($HWND, $SFILE, $IATTRIBUTES = 0, $FBRACKETS = True)
	If $DEBUG_CB Then __UDF_VALIDATECLASSNAME($HWND, $__COMBOBOXCONSTANT_CLASSNAME)
	If Not IsHWnd($HWND) Then $HWND = GUICtrlGetHandle($HWND)
	If BitAND($IATTRIBUTES, $DDL_DRIVES) = $DDL_DRIVES And Not $FBRACKETS Then
		Local $STEXT
		Local $GUI_NO_BRACKETS = GUICreate("no brackets")
		Local $COMBO_NO_BRACKETS = GUICtrlCreateCombo("", 240, 40, 120, 120)
		Local $V_RET = GUICtrlSendMsg($COMBO_NO_BRACKETS, $CB_DIR, $IATTRIBUTES, $SFILE)
		For $I = 0 To _GUICTRLCOMBOBOX_GETCOUNT($COMBO_NO_BRACKETS) - 1
			_GUICTRLCOMBOBOX_GETLBTEXT($COMBO_NO_BRACKETS, $I, $STEXT)
			$STEXT = StringReplace(StringReplace(StringReplace($STEXT, "[", ""), "]", ":"), "-", "")
			_GUICTRLCOMBOBOX_INSERTSTRING($HWND, $STEXT)
		Next
		GUIDelete($GUI_NO_BRACKETS)
		Return $V_RET
	Else
		Return _SENDMESSAGE($HWND, $CB_DIR, $IATTRIBUTES, $SFILE, 0, "wparam", "wstr")
	EndIf
EndFunc
Func _GUICTRLCOMBOBOX_ADDSTRING($HWND, $STEXT)
	If $DEBUG_CB Then __UDF_VALIDATECLASSNAME($HWND, $__COMBOBOXCONSTANT_CLASSNAME)
	If Not IsHWnd($HWND) Then $HWND = GUICtrlGetHandle($HWND)
	Return _SENDMESSAGE($HWND, $CB_ADDSTRING, 0, $STEXT, 0, "wparam", "wstr")
EndFunc
Func _GUICTRLCOMBOBOX_AUTOCOMPLETE($HWND)
	If Not IsHWnd($HWND) Then $HWND = GUICtrlGetHandle($HWND)
	If Not __GUICTRLCOMBOBOX_ISPRESSED("08") And Not __GUICTRLCOMBOBOX_ISPRESSED("2E") Then
		Local $SEDITTEXT = _GUICTRLCOMBOBOX_GETEDITTEXT($HWND)
		If StringLen($SEDITTEXT) Then
			Local $SINPUTTEXT
			Local $RET = _GUICTRLCOMBOBOX_FINDSTRING($HWND, $SEDITTEXT)
			IF ($RET <> $CB_ERR) Then
				_GUICTRLCOMBOBOX_GETLBTEXT($HWND, $RET, $SINPUTTEXT)
				_GUICTRLCOMBOBOX_SETEDITTEXT($HWND, $SINPUTTEXT)
				_GUICTRLCOMBOBOX_SETEDITSEL($HWND, StringLen($SEDITTEXT), StringLen($SINPUTTEXT))
			EndIf
		EndIf
	EndIf
EndFunc
Func _GUICTRLCOMBOBOX_BEGINUPDATE($HWND)
	If $DEBUG_CB Then __UDF_VALIDATECLASSNAME($HWND, $__COMBOBOXCONSTANT_CLASSNAME)
	If Not IsHWnd($HWND) Then $HWND = GUICtrlGetHandle($HWND)
	Return _SENDMESSAGE($HWND, $__COMBOBOXCONSTANT_WM_SETREDRAW) = 0
EndFunc
Func _GUICTRLCOMBOBOX_CREATE($HWND, $STEXT, $IX, $IY, $IWIDTH = 100, $IHEIGHT = 120, $ISTYLE = 2097218, $IEXSTYLE = 0)
	If Not IsHWnd($HWND) Then Return SetError(1, 0, 0)
	If Not IsString($STEXT) Then Return SetError(2, 0, 0)
	Local $ATEXT, $SDELIMITER = Opt("GUIDataSeparatorChar")
	If $IWIDTH = -1 Then $IWIDTH = 100
	If $IHEIGHT = -1 Then $IHEIGHT = 120
	Local Const $WS_VSCROLL = 2097152
	If $ISTYLE = -1 Then $ISTYLE = BitOR($WS_VSCROLL, $CBS_AUTOHSCROLL, $CBS_DROPDOWN)
	If $IEXSTYLE = -1 Then $IEXSTYLE = 0
	$ISTYLE = BitOR($ISTYLE, $__UDFGUICONSTANT_WS_CHILD, $__COMBOBOXCONSTANT_WS_TABSTOP, $__UDFGUICONSTANT_WS_VISIBLE)
	Local $NCTRLID = __UDF_GETNEXTGLOBALID($HWND)
	If @error Then Return SetError(@error, @extended, 0)
	Local $HCOMBO = _WINAPI_CREATEWINDOWEX($IEXSTYLE, $__COMBOBOXCONSTANT_CLASSNAME, "", $ISTYLE, $IX, $IY, $IWIDTH, $IHEIGHT, $HWND, $NCTRLID)
	_WINAPI_SETFONT($HCOMBO, _WINAPI_GETSTOCKOBJECT($__COMBOBOXCONSTANT_DEFAULT_GUI_FONT))
	If StringLen($STEXT) Then
		$ATEXT = StringSplit($STEXT, $SDELIMITER)
		For $X = 1 To $ATEXT[0]
			_GUICTRLCOMBOBOX_ADDSTRING($HCOMBO, $ATEXT[$X])
		Next
	EndIf
	Return $HCOMBO
EndFunc
Func _GUICTRLCOMBOBOX_DELETESTRING($HWND, $IINDEX)
	If $DEBUG_CB Then __UDF_VALIDATECLASSNAME($HWND, $__COMBOBOXCONSTANT_CLASSNAME)
	If Not IsHWnd($HWND) Then $HWND = GUICtrlGetHandle($HWND)
	Return _SENDMESSAGE($HWND, $CB_DELETESTRING, $IINDEX)
EndFunc
Func _GUICTRLCOMBOBOX_DESTROY(ByRef $HWND)
	If $DEBUG_CB Then __UDF_VALIDATECLASSNAME($HWND, $__COMBOBOXCONSTANT_CLASSNAME)
	If Not _WINAPI_ISCLASSNAME($HWND, $__COMBOBOXCONSTANT_CLASSNAME) Then Return SetError(2, 2, False)
	Local $DESTROYED = 0
	If IsHWnd($HWND) Then
		If _WINAPI_INPROCESS($HWND, $_GHCBLASTWND) Then
			Local $NCTRLID = _WINAPI_GETDLGCTRLID($HWND)
			Local $HPARENT = _WINAPI_GETPARENT($HWND)
			$DESTROYED = _WINAPI_DESTROYWINDOW($HWND)
			Local $IRET = __UDF_FREEGLOBALID($HPARENT, $NCTRLID)
			If Not $IRET Then
			EndIf
		Else
			Return SetError(1, 1, False)
		EndIf
	Else
		$DESTROYED = GUICtrlDelete($HWND)
	EndIf
	If $DESTROYED Then $HWND = 0
	Return $DESTROYED <> 0
EndFunc
Func _GUICTRLCOMBOBOX_ENDUPDATE($HWND)
	If $DEBUG_CB Then __UDF_VALIDATECLASSNAME($HWND, $__COMBOBOXCONSTANT_CLASSNAME)
	If Not IsHWnd($HWND) Then $HWND = GUICtrlGetHandle($HWND)
	Return _SENDMESSAGE($HWND, $__COMBOBOXCONSTANT_WM_SETREDRAW, 1) = 0
EndFunc
Func _GUICTRLCOMBOBOX_FINDSTRING($HWND, $STEXT, $IINDEX = -1)
	If $DEBUG_CB Then __UDF_VALIDATECLASSNAME($HWND, $__COMBOBOXCONSTANT_CLASSNAME)
	If Not IsHWnd($HWND) Then $HWND = GUICtrlGetHandle($HWND)
	Return _SENDMESSAGE($HWND, $CB_FINDSTRING, $IINDEX, $STEXT, 0, "int", "wstr")
EndFunc
Func _GUICTRLCOMBOBOX_FINDSTRINGEXACT($HWND, $STEXT, $IINDEX = -1)
	If $DEBUG_CB Then __UDF_VALIDATECLASSNAME($HWND, $__COMBOBOXCONSTANT_CLASSNAME)
	If Not IsHWnd($HWND) Then $HWND = GUICtrlGetHandle($HWND)
	Return _SENDMESSAGE($HWND, $CB_FINDSTRINGEXACT, $IINDEX, $STEXT, 0, "wparam", "wstr")
EndFunc
Func _GUICTRLCOMBOBOX_GETCOMBOBOXINFO($HWND, ByRef $TINFO)
	If $DEBUG_CB Then __UDF_VALIDATECLASSNAME($HWND, $__COMBOBOXCONSTANT_CLASSNAME)
	If Not IsHWnd($HWND) Then $HWND = GUICtrlGetHandle($HWND)
	$TINFO = DllStructCreate($TAGCOMBOBOXINFO)
	Local $PINFO = DllStructGetPtr($TINFO)
	Local $IINFO = DllStructGetSize($TINFO)
	DllStructSetData($TINFO, "Size", $IINFO)
	Return _SENDMESSAGE($HWND, $CB_GETCOMBOBOXINFO, 0, $PINFO, 0, "wparam", "ptr") <> 0
EndFunc
Func _GUICTRLCOMBOBOX_GETCOUNT($HWND)
	If $DEBUG_CB Then __UDF_VALIDATECLASSNAME($HWND, $__COMBOBOXCONSTANT_CLASSNAME)
	If Not IsHWnd($HWND) Then $HWND = GUICtrlGetHandle($HWND)
	Return _SENDMESSAGE($HWND, $CB_GETCOUNT)
EndFunc
Func _GUICTRLCOMBOBOX_GETCUEBANNER($HWND)
	If $DEBUG_CB Then __UDF_VALIDATECLASSNAME($HWND, $__COMBOBOXCONSTANT_CLASSNAME)
	If Not IsHWnd($HWND) Then $HWND = GUICtrlGetHandle($HWND)
	Local $TTEXT = DllStructCreate("wchar[4096]")
	If _SENDMESSAGE($HWND, $CB_GETCUEBANNER, DllStructGetPtr($TTEXT), 4096) <> 1 Then Return SetError(-1, 0, "")
	Return _WINAPI_WIDECHARTOMULTIBYTE(DllStructGetPtr($TTEXT))
EndFunc
Func _GUICTRLCOMBOBOX_GETCURSEL($HWND)
	If $DEBUG_CB Then __UDF_VALIDATECLASSNAME($HWND, $__COMBOBOXCONSTANT_CLASSNAME)
	If Not IsHWnd($HWND) Then $HWND = GUICtrlGetHandle($HWND)
	Return _SENDMESSAGE($HWND, $CB_GETCURSEL)
EndFunc
Func _GUICTRLCOMBOBOX_GETDROPPEDCONTROLRECT($HWND)
	If $DEBUG_CB Then __UDF_VALIDATECLASSNAME($HWND, $__COMBOBOXCONSTANT_CLASSNAME)
	If Not IsHWnd($HWND) Then $HWND = GUICtrlGetHandle($HWND)
	Local $ARECT[4]
	Local $TRECT = _GUICTRLCOMBOBOX_GETDROPPEDCONTROLRECTEX($HWND)
	$ARECT[0] = DllStructGetData($TRECT, "Left")
	$ARECT[1] = DllStructGetData($TRECT, "Top")
	$ARECT[2] = DllStructGetData($TRECT, "Right")
	$ARECT[3] = DllStructGetData($TRECT, "Bottom")
	Return $ARECT
EndFunc
Func _GUICTRLCOMBOBOX_GETDROPPEDCONTROLRECTEX($HWND)
	If $DEBUG_CB Then __UDF_VALIDATECLASSNAME($HWND, $__COMBOBOXCONSTANT_CLASSNAME)
	If Not IsHWnd($HWND) Then $HWND = GUICtrlGetHandle($HWND)
	Local $TRECT = DllStructCreate($TAGRECT)
	_SENDMESSAGE($HWND, $CB_GETDROPPEDCONTROLRECT, 0, DllStructGetPtr($TRECT), 0, "wparam", "ptr")
	Return $TRECT
EndFunc
Func _GUICTRLCOMBOBOX_GETDROPPEDSTATE($HWND)
	If $DEBUG_CB Then __UDF_VALIDATECLASSNAME($HWND, $__COMBOBOXCONSTANT_CLASSNAME)
	If Not IsHWnd($HWND) Then $HWND = GUICtrlGetHandle($HWND)
	Return _SENDMESSAGE($HWND, $CB_GETDROPPEDSTATE) <> 0
EndFunc
Func _GUICTRLCOMBOBOX_GETDROPPEDWIDTH($HWND)
	If $DEBUG_CB Then __UDF_VALIDATECLASSNAME($HWND, $__COMBOBOXCONSTANT_CLASSNAME)
	If Not IsHWnd($HWND) Then $HWND = GUICtrlGetHandle($HWND)
	Return _SENDMESSAGE($HWND, $CB_GETDROPPEDWIDTH)
EndFunc
Func _GUICTRLCOMBOBOX_GETEDITSEL($HWND)
	If $DEBUG_CB Then __UDF_VALIDATECLASSNAME($HWND, $__COMBOBOXCONSTANT_CLASSNAME)
	If Not IsHWnd($HWND) Then $HWND = GUICtrlGetHandle($HWND)
	Local $TSTART = DllStructCreate("dword Start")
	Local $TEND = DllStructCreate("dword End")
	Local $IRET = _SENDMESSAGE($HWND, $CB_GETEDITSEL, DllStructGetPtr($TSTART), DllStructGetPtr($TEND), 0, "ptr", "ptr")
	If $IRET = 0 Then Return SetError($CB_ERR, $CB_ERR, $CB_ERR)
	Local $ASEL[2]
	$ASEL[0] = DllStructGetData($TSTART, "Start")
	$ASEL[1] = DllStructGetData($TEND, "End")
	Return $ASEL
EndFunc
Func _GUICTRLCOMBOBOX_GETEDITTEXT($HWND)
	If $DEBUG_CB Then __UDF_VALIDATECLASSNAME($HWND, $__COMBOBOXCONSTANT_CLASSNAME)
	If Not IsHWnd($HWND) Then $HWND = GUICtrlGetHandle($HWND)
	Local $TINFO
	If _GUICTRLCOMBOBOX_GETCOMBOBOXINFO($HWND, $TINFO) Then
		Local $HEDIT = DllStructGetData($TINFO, "hEdit")
		Local $ILINE = 0
		Local $IINDEX = _SENDMESSAGE($HEDIT, $__COMBOBOXCONSTANT_EM_LINEINDEX, $ILINE)
		Local $ILENGTH = _SENDMESSAGE($HEDIT, $__COMBOBOXCONSTANT_EM_LINELENGTH, $IINDEX)
		If $ILENGTH = 0 Then Return ""
		Local $TBUFFER = DllStructCreate("short Len;wchar Text[" & $ILENGTH + 2 & "]")
		DllStructSetData($TBUFFER, "Len", $ILENGTH + 2)
		Local $IRET = _SENDMESSAGE($HEDIT, $__COMBOBOXCONSTANT_EM_GETLINE, $ILINE, DllStructGetPtr($TBUFFER), 0, "wparam", "ptr")
		If $IRET = 0 Then Return SetError(-1, -1, "")
		Local $TTEXT = DllStructCreate("wchar Text[" & $ILENGTH + 1 & "]", DllStructGetPtr($TBUFFER))
		Return DllStructGetData($TTEXT, "Text")
	Else
		Return SetError(-1, -1, "")
	EndIf
EndFunc
Func _GUICTRLCOMBOBOX_GETEXTENDEDUI($HWND)
	If $DEBUG_CB Then __UDF_VALIDATECLASSNAME($HWND, $__COMBOBOXCONSTANT_CLASSNAME)
	If Not IsHWnd($HWND) Then $HWND = GUICtrlGetHandle($HWND)
	Return _SENDMESSAGE($HWND, $CB_GETEXTENDEDUI) <> 0
EndFunc
Func _GUICTRLCOMBOBOX_GETHORIZONTALEXTENT($HWND)
	If $DEBUG_CB Then __UDF_VALIDATECLASSNAME($HWND, $__COMBOBOXCONSTANT_CLASSNAME)
	If Not IsHWnd($HWND) Then $HWND = GUICtrlGetHandle($HWND)
	Return _SENDMESSAGE($HWND, $CB_GETHORIZONTALEXTENT)
EndFunc
Func _GUICTRLCOMBOBOX_GETITEMHEIGHT($HWND, $IINDEX = -1)
	If $DEBUG_CB Then __UDF_VALIDATECLASSNAME($HWND, $__COMBOBOXCONSTANT_CLASSNAME)
	If Not IsHWnd($HWND) Then $HWND = GUICtrlGetHandle($HWND)
	Return _SENDMESSAGE($HWND, $CB_GETITEMHEIGHT, $IINDEX)
EndFunc
Func _GUICTRLCOMBOBOX_GETLBTEXT($HWND, $IINDEX, ByRef $STEXT)
	If $DEBUG_CB Then __UDF_VALIDATECLASSNAME($HWND, $__COMBOBOXCONSTANT_CLASSNAME)
	If Not IsHWnd($HWND) Then $HWND = GUICtrlGetHandle($HWND)
	Local $ILEN = _GUICTRLCOMBOBOX_GETLBTEXTLEN($HWND, $IINDEX)
	Local $TBUFFER = DllStructCreate("wchar Text[" & $ILEN + 1 & "]")
	Local $IRET = _SENDMESSAGE($HWND, $CB_GETLBTEXT, $IINDEX, DllStructGetPtr($TBUFFER), 0, "wparam", "ptr")
	IF ($IRET == $CB_ERR) Then Return SetError($CB_ERR, $CB_ERR, $CB_ERR)
	$STEXT = DllStructGetData($TBUFFER, "Text")
	Return $IRET
EndFunc
Func _GUICTRLCOMBOBOX_GETLBTEXTLEN($HWND, $IINDEX)
	If $DEBUG_CB Then __UDF_VALIDATECLASSNAME($HWND, $__COMBOBOXCONSTANT_CLASSNAME)
	If Not IsHWnd($HWND) Then $HWND = GUICtrlGetHandle($HWND)
	Return _SENDMESSAGE($HWND, $CB_GETLBTEXTLEN, $IINDEX)
EndFunc
Func _GUICTRLCOMBOBOX_GETLIST($HWND)
	If $DEBUG_CB Then __UDF_VALIDATECLASSNAME($HWND, $__COMBOBOXCONSTANT_CLASSNAME)
	If Not IsHWnd($HWND) Then $HWND = GUICtrlGetHandle($HWND)
	Local $SDELIMITER = Opt("GUIDataSeparatorChar")
	Local $SRESULT = "", $SITEM
	For $I = 0 To _GUICTRLCOMBOBOX_GETCOUNT($HWND) - 1
		_GUICTRLCOMBOBOX_GETLBTEXT($HWND, $I, $SITEM)
		$SRESULT &= $SITEM & $SDELIMITER
	Next
	Return StringTrimRight($SRESULT, StringLen($SDELIMITER))
EndFunc
Func _GUICTRLCOMBOBOX_GETLISTARRAY($HWND)
	If Not IsHWnd($HWND) Then $HWND = GUICtrlGetHandle($HWND)
	Local $SDELIMITER = Opt("GUIDataSeparatorChar")
	Return StringSplit(_GUICTRLCOMBOBOX_GETLIST($HWND), $SDELIMITER)
EndFunc
Func _GUICTRLCOMBOBOX_GETLOCALE($HWND)
	If $DEBUG_CB Then __UDF_VALIDATECLASSNAME($HWND, $__COMBOBOXCONSTANT_CLASSNAME)
	If Not IsHWnd($HWND) Then $HWND = GUICtrlGetHandle($HWND)
	Return _SENDMESSAGE($HWND, $CB_GETLOCALE)
EndFunc
Func _GUICTRLCOMBOBOX_GETLOCALECOUNTRY($HWND)
	Return _WINAPI_HIWORD(_GUICTRLCOMBOBOX_GETLOCALE($HWND))
EndFunc
Func _GUICTRLCOMBOBOX_GETLOCALELANG($HWND)
	Return _WINAPI_LOWORD(_GUICTRLCOMBOBOX_GETLOCALE($HWND))
EndFunc
Func _GUICTRLCOMBOBOX_GETLOCALEPRIMLANG($HWND)
	Return _WINAPI_PRIMARYLANGID(_GUICTRLCOMBOBOX_GETLOCALELANG($HWND))
EndFunc
Func _GUICTRLCOMBOBOX_GETLOCALESUBLANG($HWND)
	Return _WINAPI_SUBLANGID(_GUICTRLCOMBOBOX_GETLOCALELANG($HWND))
EndFunc
Func _GUICTRLCOMBOBOX_GETMINVISIBLE($HWND)
	If $DEBUG_CB Then __UDF_VALIDATECLASSNAME($HWND, $__COMBOBOXCONSTANT_CLASSNAME)
	If Not IsHWnd($HWND) Then $HWND = GUICtrlGetHandle($HWND)
	Return _SENDMESSAGE($HWND, $CB_GETMINVISIBLE)
EndFunc
Func _GUICTRLCOMBOBOX_GETTOPINDEX($HWND)
	If $DEBUG_CB Then __UDF_VALIDATECLASSNAME($HWND, $__COMBOBOXCONSTANT_CLASSNAME)
	If Not IsHWnd($HWND) Then $HWND = GUICtrlGetHandle($HWND)
	Return _SENDMESSAGE($HWND, $CB_GETTOPINDEX)
EndFunc
Func _GUICTRLCOMBOBOX_INITSTORAGE($HWND, $INUM, $IBYTES)
	If $DEBUG_CB Then __UDF_VALIDATECLASSNAME($HWND, $__COMBOBOXCONSTANT_CLASSNAME)
	If Not IsHWnd($HWND) Then $HWND = GUICtrlGetHandle($HWND)
	Return _SENDMESSAGE($HWND, $CB_INITSTORAGE, $INUM, $IBYTES)
EndFunc
Func _GUICTRLCOMBOBOX_INSERTSTRING($HWND, $STEXT, $IINDEX = -1)
	If $DEBUG_CB Then __UDF_VALIDATECLASSNAME($HWND, $__COMBOBOXCONSTANT_CLASSNAME)
	If Not IsHWnd($HWND) Then $HWND = GUICtrlGetHandle($HWND)
	Return _SENDMESSAGE($HWND, $CB_INSERTSTRING, $IINDEX, $STEXT, 0, "wparam", "wstr")
EndFunc
Func _GUICTRLCOMBOBOX_LIMITTEXT($HWND, $ILIMIT = 0)
	If $DEBUG_CB Then __UDF_VALIDATECLASSNAME($HWND, $__COMBOBOXCONSTANT_CLASSNAME)
	If Not IsHWnd($HWND) Then $HWND = GUICtrlGetHandle($HWND)
	_SENDMESSAGE($HWND, $CB_LIMITTEXT, $ILIMIT)
EndFunc
Func _GUICTRLCOMBOBOX_REPLACEEDITSEL($HWND, $STEXT)
	If Not IsHWnd($HWND) Then $HWND = GUICtrlGetHandle($HWND)
	Local $TINFO
	If _GUICTRLCOMBOBOX_GETCOMBOBOXINFO($HWND, $TINFO) Then
		Local $HEDIT = DllStructGetData($TINFO, "hEdit")
		_SENDMESSAGE($HEDIT, $__COMBOBOXCONSTANT_EM_REPLACESEL, True, $STEXT, 0, "wparam", "wstr")
	EndIf
EndFunc
Func _GUICTRLCOMBOBOX_RESETCONTENT($HWND)
	If $DEBUG_CB Then __UDF_VALIDATECLASSNAME($HWND, $__COMBOBOXCONSTANT_CLASSNAME)
	If Not IsHWnd($HWND) Then $HWND = GUICtrlGetHandle($HWND)
	_SENDMESSAGE($HWND, $CB_RESETCONTENT)
EndFunc
Func _GUICTRLCOMBOBOX_SELECTSTRING($HWND, $STEXT, $IINDEX = -1)
	If $DEBUG_CB Then __UDF_VALIDATECLASSNAME($HWND, $__COMBOBOXCONSTANT_CLASSNAME)
	If Not IsHWnd($HWND) Then $HWND = GUICtrlGetHandle($HWND)
	Return _SENDMESSAGE($HWND, $CB_SELECTSTRING, $IINDEX, $STEXT, 0, "wparam", "wstr")
EndFunc
Func _GUICTRLCOMBOBOX_SETCUEBANNER($HWND, $STEXT)
	If $DEBUG_CB Then __UDF_VALIDATECLASSNAME($HWND, $__COMBOBOXCONSTANT_CLASSNAME)
	If Not IsHWnd($HWND) Then $HWND = GUICtrlGetHandle($HWND)
	Local $TTEXT = _WINAPI_MULTIBYTETOWIDECHAR($STEXT)
	Return _SENDMESSAGE($HWND, $CB_SETCUEBANNER, 0, DllStructGetPtr($TTEXT)) = 1
EndFunc
Func _GUICTRLCOMBOBOX_SETCURSEL($HWND, $IINDEX = -1)
	If $DEBUG_CB Then __UDF_VALIDATECLASSNAME($HWND, $__COMBOBOXCONSTANT_CLASSNAME)
	If Not IsHWnd($HWND) Then $HWND = GUICtrlGetHandle($HWND)
	Return _SENDMESSAGE($HWND, $CB_SETCURSEL, $IINDEX)
EndFunc
Func _GUICTRLCOMBOBOX_SETDROPPEDWIDTH($HWND, $IWIDTH)
	If $DEBUG_CB Then __UDF_VALIDATECLASSNAME($HWND, $__COMBOBOXCONSTANT_CLASSNAME)
	If Not IsHWnd($HWND) Then $HWND = GUICtrlGetHandle($HWND)
	Return _SENDMESSAGE($HWND, $CB_SETDROPPEDWIDTH, $IWIDTH)
EndFunc
Func _GUICTRLCOMBOBOX_SETEDITSEL($HWND, $ISTART, $ISTOP)
	If $DEBUG_CB Then __UDF_VALIDATECLASSNAME($HWND, $__COMBOBOXCONSTANT_CLASSNAME)
	If Not HWnd($HWND) Then $HWND = GUICtrlGetHandle($HWND)
	Return _SENDMESSAGE($HWND, $CB_SETEDITSEL, 0, _WINAPI_MAKELONG($ISTART, $ISTOP)) <> -1
EndFunc
Func _GUICTRLCOMBOBOX_SETEDITTEXT($HWND, $STEXT)
	If Not IsHWnd($HWND) Then $HWND = GUICtrlGetHandle($HWND)
	_GUICTRLCOMBOBOX_SETEDITSEL($HWND, 0, -1)
	_GUICTRLCOMBOBOX_REPLACEEDITSEL($HWND, $STEXT)
EndFunc
Func _GUICTRLCOMBOBOX_SETEXTENDEDUI($HWND, $FEXTENDED = False)
	If $DEBUG_CB Then __UDF_VALIDATECLASSNAME($HWND, $__COMBOBOXCONSTANT_CLASSNAME)
	If Not IsHWnd($HWND) Then $HWND = GUICtrlGetHandle($HWND)
	Return _SENDMESSAGE($HWND, $CB_SETEXTENDEDUI, $FEXTENDED) = 0
EndFunc
Func _GUICTRLCOMBOBOX_SETHORIZONTALEXTENT($HWND, $IWIDTH)
	If $DEBUG_CB Then __UDF_VALIDATECLASSNAME($HWND, $__COMBOBOXCONSTANT_CLASSNAME)
	If Not IsHWnd($HWND) Then $HWND = GUICtrlGetHandle($HWND)
	_SENDMESSAGE($HWND, $CB_SETHORIZONTALEXTENT, $IWIDTH)
EndFunc
Func _GUICTRLCOMBOBOX_SETITEMHEIGHT($HWND, $IHEIGHT, $ICOMPONENT = -1)
	If $DEBUG_CB Then __UDF_VALIDATECLASSNAME($HWND, $__COMBOBOXCONSTANT_CLASSNAME)
	If Not IsHWnd($HWND) Then $HWND = GUICtrlGetHandle($HWND)
	Return _SENDMESSAGE($HWND, $CB_SETITEMHEIGHT, $ICOMPONENT, $IHEIGHT)
EndFunc
Func _GUICTRLCOMBOBOX_SETLOCALE($HWND, $ILOCAL)
	If $DEBUG_CB Then __UDF_VALIDATECLASSNAME($HWND, $__COMBOBOXCONSTANT_CLASSNAME)
	If Not IsHWnd($HWND) Then $HWND = GUICtrlGetHandle($HWND)
	Return _SENDMESSAGE($HWND, $CB_SETLOCALE, $ILOCAL)
EndFunc
Func _GUICTRLCOMBOBOX_SETMINVISIBLE($HWND, $IMINIMUM)
	If $DEBUG_CB Then __UDF_VALIDATECLASSNAME($HWND, $__COMBOBOXCONSTANT_CLASSNAME)
	If Not IsHWnd($HWND) Then $HWND = GUICtrlGetHandle($HWND)
	Return _SENDMESSAGE($HWND, $CB_SETMINVISIBLE, $IMINIMUM) <> 0
EndFunc
Func _GUICTRLCOMBOBOX_SETTOPINDEX($HWND, $IINDEX)
	If $DEBUG_CB Then __UDF_VALIDATECLASSNAME($HWND, $__COMBOBOXCONSTANT_CLASSNAME)
	If Not IsHWnd($HWND) Then $HWND = GUICtrlGetHandle($HWND)
	Return _SENDMESSAGE($HWND, $CB_SETTOPINDEX, $IINDEX) = 0
EndFunc
Func _GUICTRLCOMBOBOX_SHOWDROPDOWN($HWND, $FSHOW = False)
	If $DEBUG_CB Then __UDF_VALIDATECLASSNAME($HWND, $__COMBOBOXCONSTANT_CLASSNAME)
	If Not IsHWnd($HWND) Then $HWND = GUICtrlGetHandle($HWND)
	_SENDMESSAGE($HWND, $CB_SHOWDROPDOWN, $FSHOW)
EndFunc
Func __GUICTRLCOMBOBOX_ISPRESSED($SHEXKEY, $VDLL = "user32.dll")
	Local $A_R = DllCall($VDLL, "short", "GetAsyncKeyState", "int", "0x" & $SHEXKEY)
	If @error Then Return SetError(@error, @extended, False)
	Return BitAND($A_R[0], 32768) <> 0
EndFunc
Global Const $GUI_EVENT_CLOSE = -3
Global Const $GUI_EVENT_MINIMIZE = -4
Global Const $GUI_EVENT_RESTORE = -5
Global Const $GUI_EVENT_MAXIMIZE = -6
Global Const $GUI_EVENT_PRIMARYDOWN = -7
Global Const $GUI_EVENT_PRIMARYUP = -8
Global Const $GUI_EVENT_SECONDARYDOWN = -9
Global Const $GUI_EVENT_SECONDARYUP = -10
Global Const $GUI_EVENT_MOUSEMOVE = -11
Global Const $GUI_EVENT_RESIZED = -12
Global Const $GUI_EVENT_DROPPED = -13
Global Const $GUI_RUNDEFMSG = "GUI_RUNDEFMSG"
Global Const $GUI_AVISTOP = 0
Global Const $GUI_AVISTART = 1
Global Const $GUI_AVICLOSE = 2
Global Const $GUI_CHECKED = 1
Global Const $GUI_INDETERMINATE = 2
Global Const $GUI_UNCHECKED = 4
Global Const $GUI_DROPACCEPTED = 8
Global Const $GUI_NODROPACCEPTED = 4096
Global Const $GUI_ACCEPTFILES = $GUI_DROPACCEPTED
Global Const $GUI_SHOW = 16
Global Const $GUI_HIDE = 32
Global Const $GUI_ENABLE = 64
Global Const $GUI_DISABLE = 128
Global Const $GUI_FOCUS = 256
Global Const $GUI_NOFOCUS = 8192
Global Const $GUI_DEFBUTTON = 512
Global Const $GUI_EXPAND = 1024
Global Const $GUI_ONTOP = 2048
Global Const $GUI_FONTITALIC = 2
Global Const $GUI_FONTUNDER = 4
Global Const $GUI_FONTSTRIKE = 8
Global Const $GUI_DOCKAUTO = 1
Global Const $GUI_DOCKLEFT = 2
Global Const $GUI_DOCKRIGHT = 4
Global Const $GUI_DOCKHCENTER = 8
Global Const $GUI_DOCKTOP = 32
Global Const $GUI_DOCKBOTTOM = 64
Global Const $GUI_DOCKVCENTER = 128
Global Const $GUI_DOCKWIDTH = 256
Global Const $GUI_DOCKHEIGHT = 512
Global Const $GUI_DOCKSIZE = 768
Global Const $GUI_DOCKMENUBAR = 544
Global Const $GUI_DOCKSTATEBAR = 576
Global Const $GUI_DOCKALL = 802
Global Const $GUI_DOCKBORDERS = 102
Global Const $GUI_GR_CLOSE = 1
Global Const $GUI_GR_LINE = 2
Global Const $GUI_GR_BEZIER = 4
Global Const $GUI_GR_MOVE = 6
Global Const $GUI_GR_COLOR = 8
Global Const $GUI_GR_RECT = 10
Global Const $GUI_GR_ELLIPSE = 12
Global Const $GUI_GR_PIE = 14
Global Const $GUI_GR_DOT = 16
Global Const $GUI_GR_PIXEL = 18
Global Const $GUI_GR_HINT = 20
Global Const $GUI_GR_REFRESH = 22
Global Const $GUI_GR_PENSIZE = 24
Global Const $GUI_GR_NOBKCOLOR = -2
Global Const $GUI_BKCOLOR_DEFAULT = -1
Global Const $GUI_BKCOLOR_TRANSPARENT = -2
Global Const $GUI_BKCOLOR_LV_ALTERNATE = -33554432
Global Const $GUI_WS_EX_PARENTDRAG = 1048576
Global Const $ES_LEFT = 0
Global Const $ES_CENTER = 1
Global Const $ES_RIGHT = 2
Global Const $ES_MULTILINE = 4
Global Const $ES_UPPERCASE = 8
Global Const $ES_LOWERCASE = 16
Global Const $ES_PASSWORD = 32
Global Const $ES_AUTOVSCROLL = 64
Global Const $ES_AUTOHSCROLL = 128
Global Const $ES_NOHIDESEL = 256
Global Const $ES_OEMCONVERT = 1024
Global Const $ES_READONLY = 2048
Global Const $ES_WANTRETURN = 4096
Global Const $ES_NUMBER = 8192
Global Const $EC_ERR = -1
Global Const $ECM_FIRST = 5376
Global Const $EM_CANUNDO = 198
Global Const $EM_CHARFROMPOS = 215
Global Const $EM_EMPTYUNDOBUFFER = 205
Global Const $EM_FMTLINES = 200
Global Const $EM_GETCUEBANNER = ($ECM_FIRST + 2)
Global Const $EM_GETFIRSTVISIBLELINE = 206
Global Const $EM_GETHANDLE = 189
Global Const $EM_GETIMESTATUS = 217
Global Const $EM_GETLIMITTEXT = 213
Global Const $EM_GETLINE = 196
Global Const $EM_GETLINECOUNT = 186
Global Const $EM_GETMARGINS = 212
Global Const $EM_GETMODIFY = 184
Global Const $EM_GETPASSWORDCHAR = 210
Global Const $EM_GETRECT = 178
Global Const $EM_GETSEL = 176
Global Const $EM_GETTHUMB = 190
Global Const $EM_GETWORDBREAKPROC = 209
Global Const $EM_HIDEBALLOONTIP = ($ECM_FIRST + 4)
Global Const $EM_LIMITTEXT = 197
Global Const $EM_LINEFROMCHAR = 201
Global Const $EM_LINEINDEX = 187
Global Const $EM_LINELENGTH = 193
Global Const $EM_LINESCROLL = 182
Global Const $EM_POSFROMCHAR = 214
Global Const $EM_REPLACESEL = 194
Global Const $EM_SCROLL = 181
Global Const $EM_SCROLLCARET = 183
Global Const $EM_SETCUEBANNER = ($ECM_FIRST + 1)
Global Const $EM_SETHANDLE = 188
Global Const $EM_SETIMESTATUS = 216
Global Const $EM_SETLIMITTEXT = $EM_LIMITTEXT
Global Const $EM_SETMARGINS = 211
Global Const $EM_SETMODIFY = 185
Global Const $EM_SETPASSWORDCHAR = 204
Global Const $EM_SETREADONLY = 207
Global Const $EM_SETRECT = 179
Global Const $EM_SETRECTNP = 180
Global Const $EM_SETSEL = 177
Global Const $EM_SETTABSTOPS = 203
Global Const $EM_SETWORDBREAKPROC = 208
Global Const $EM_SHOWBALLOONTIP = ($ECM_FIRST + 3)
Global Const $EM_UNDO = 199
Global Const $EC_LEFTMARGIN = 1
Global Const $EC_RIGHTMARGIN = 2
Global Const $EC_USEFONTINFO = 65535
Global Const $EMSIS_COMPOSITIONSTRING = 1
Global Const $EIMES_GETCOMPSTRATONCE = 1
Global Const $EIMES_CANCELCOMPSTRINFOCUS = 2
Global Const $EIMES_COMPLETECOMPSTRKILLFOCUS = 4
Global Const $EN_ALIGN_LTR_EC = 1792
Global Const $EN_ALIGN_RTL_EC = 1793
Global Const $EN_CHANGE = 768
Global Const $EN_ERRSPACE = 1280
Global Const $EN_HSCROLL = 1537
Global Const $EN_KILLFOCUS = 512
Global Const $EN_MAXTEXT = 1281
Global Const $EN_SETFOCUS = 256
Global Const $EN_UPDATE = 1024
Global Const $EN_VSCROLL = 1538
Global Const $TTI_NONE = 0
Global Const $TTI_INFO = 1
Global Const $TTI_WARNING = 2
Global Const $TTI_ERROR = 3
Global Const $TTI_INFO_LARGE = 4
Global Const $TTI_WARNING_LARGE = 5
Global Const $TTI_ERROR_LARGE = 6
Global Const $__EDITCONSTANT_WS_VSCROLL = 2097152
Global Const $__EDITCONSTANT_WS_HSCROLL = 1048576
Global Const $GUI_SS_DEFAULT_EDIT = BitOR($ES_WANTRETURN, $__EDITCONSTANT_WS_VSCROLL, $__EDITCONSTANT_WS_HSCROLL, $ES_AUTOVSCROLL, $ES_AUTOHSCROLL)
Global Const $GUI_SS_DEFAULT_INPUT = BitOR($ES_LEFT, $ES_AUTOHSCROLL)
Func _IMAGESEARCH($FINDIMAGE, $RESULTPOSITION, ByRef $X, ByRef $Y, $TOLERANCE)
	Return _IMAGESEARCHAREA($FINDIMAGE, $RESULTPOSITION, 0, 0, @DesktopWidth, @DesktopHeight, $X, $Y, $TOLERANCE)
EndFunc
Func _IMAGESEARCHAREA($FINDIMAGE, $RESULTPOSITION, $X1, $Y1, $RIGHT, $BOTTOM, ByRef $X, ByRef $Y, $TOLERANCE)
	IF (FileExists($FINDIMAGE)) Then
	Else
		MsgBox(0, "ImageSearch Error", "File does not exist : " & $FINDIMAGE)
	EndIf
	If $TOLERANCE > 0 Then $FINDIMAGE = "*" & $TOLERANCE & " " & $FINDIMAGE
	$RESULT = DllCall("ImageSearchDLL.dll", "str", "ImageSearch", "int", $X1, "int", $Y1, "int", $RIGHT, "int", $BOTTOM, "str", $FINDIMAGE)
	If $RESULT[0] = "0" Then Return 0
	$ARRAY = StringSplit($RESULT[0], "|")
	$X = Int(Number($ARRAY[2]))
	$Y = Int(Number($ARRAY[3]))
	If $RESULTPOSITION = 1 Then
		$X = $X + Int(Number($ARRAY[4]) / 2)
		$Y = $Y + Int(Number($ARRAY[5]) / 2)
	EndIf
	Return 1
EndFunc
Func _WAITFORIMAGESEARCH($FINDIMAGE, $WAITSECS, $RESULTPOSITION, ByRef $X, ByRef $Y, $TOLERANCE)
	$WAITSECS = $WAITSECS * 1000
	$STARTTIME = TimerInit()
	While TimerDiff($STARTTIME) < $WAITSECS
		Sleep(100)
		$RESULT = _IMAGESEARCH($FINDIMAGE, $RESULTPOSITION, $X, $Y, $TOLERANCE)
		If $RESULT > 0 Then
			Return 1
		EndIf
	WEnd
	Return 0
EndFunc
Func _WAITFORIMAGESSEARCH($FINDIMAGE, $WAITSECS, $RESULTPOSITION, ByRef $X, ByRef $Y, $TOLERANCE)
	$WAITSECS = $WAITSECS * 1000
	$STARTTIME = TimerInit()
	While TimerDiff($STARTTIME) < $WAITSECS
		For $I = 1 To $FINDIMAGE[0]
			Sleep(100)
			$RESULT = _IMAGESEARCH($FINDIMAGE[$I], $RESULTPOSITION, $X, $Y, $TOLERANCE)
			If $RESULT > 0 Then
				Return $I
			EndIf
		Next
	WEnd
	Return 0
EndFunc
Func ASIZE($AARRAY)
	SetError(0)
	$INDEX = 0
	Do
		$POP = _ARRAYPOP($AARRAY)
		$INDEX = $INDEX + 1
	Until @error = 1
	Return $INDEX - 1
EndFunc
$SETTINGLANGUAGE = "English"
$FILESETTING = FileOpen("scripts/settings.txt", 0)
IF ($FILESETTING == -1) Then
	$SETTINGLANGUAGE = "English"
Else
	While 1
		$CURLINE = FileReadLine($FILESETTING)
		If @error = -1 Then ExitLoop
		$STRINGARRAY = _STRINGEXPLODE($CURLINE, ",")
		IF ($STRINGARRAY[0] = "language") Then
			IF (ASIZE($STRINGARRAY) > 1) Then $SETTINGLANGUAGE = $STRINGARRAY[1]
		EndIf
	WEnd
	FileClose($FILESETTING)
EndIf
IF ($SETTINGLANGUAGE == "English") Then $IMAGEDIR = "imagesEN/"
IF ($SETTINGLANGUAGE == "German") Then $IMAGEDIR = "imagesDE/"
IF ($SETTINGLANGUAGE == "French") Then $IMAGEDIR = "imagesFR/"
Func WRITELOG($MSG)
	IF (@WDAY == 1) Then $TIMESTAMP = "SUN"
	IF (@WDAY == 2) Then $TIMESTAMP = "MON"
	IF (@WDAY == 3) Then $TIMESTAMP = "TUE"
	IF (@WDAY == 4) Then $TIMESTAMP = "WED"
	IF (@WDAY == 5) Then $TIMESTAMP = "THU"
	IF (@WDAY == 6) Then $TIMESTAMP = "FRI"
	IF (@WDAY == 7) Then $TIMESTAMP = "SAT"
	$TIMESTAMP = $TIMESTAMP & " " & @MDAY & "/" & @MON & "/" & @YEAR & " "
	$TIMESTAMP = $TIMESTAMP & @HOUR & ":" & @MIN & ":" & @SEC
	$FILELOG = FileOpen("log.txt", 1)
	FileWriteLine($FILELOG, $TIMESTAMP & " " & $MSG)
	FileClose($FILELOG)
EndFunc
$TIMES = TimerInit()
$BETA = 0
$VERSION = "4.2"
$HGUI = GUICreate("DeathCheck", 200, 90)
$HLABEL1 = GUICtrlCreateLabel("UNTZ UNTZ", 10, 10, 100, 20)
$HLABEL2 = GUICtrlCreateLabel("UNTZ UNTZ", 10, 30, 100, 20)
$HLABEL3 = GUICtrlCreateLabel("UNTZ UNTZ", 10, 50, 100, 20)
$HLABEL4 = GUICtrlCreateLabel("f : exit", 120, 50, 100, 20)
$HLABEL5 = GUICtrlCreateLabel("Loss: 0", 120, 30, 100, 20)
$HLABEL6 = GUICtrlCreateLabel("Language : " & $SETTINGLANGUAGE, 70, 70, 130, 20)
$HLABELT = GUICtrlCreateLabel("Time: ", 120, 10, 100, 20)
Func UPDATETIME()
	$TIME = TimerDiff($TIMES)
	$TIME = ($TIME - Mod($TIME, 1000)) / 1000
	$TIMESEC = (Mod($TIME, 60))
	$TIMEMIN = Mod((($TIME - Mod($TIME, 60)) / 60), 60)
	$TIMEHRS = ($TIME - Mod($TIME, 3600)) / 3600
	IF ($TIMESEC < 10) Then $TIMESEC = "0" & $TIMESEC
	IF ($TIMEMIN < 10) Then $TIMEMIN = "0" & $TIMEMIN
	IF ($TIMEHRS < 10) Then $TIMEHRS = "0" & $TIMEHRS
	$TIMESTRING = $TIMEHRS & ":" & $TIMEMIN & ":" & $TIMESEC
	GUICtrlSetData($HLABELT, $TIMESTRING)
EndFunc
GUISetOnEvent($GUI_EVENT_CLOSE, "ExitGUI")
GUISetState(@SW_SHOW)
Func EXITGUI()
	Exit
EndFunc
Func UNTZ1($M1)
	GUICtrlSetData($HLABEL1, $M1)
EndFunc
Func UNTZ2($M1)
	GUICtrlSetData($HLABEL2, $M1)
EndFunc
Func UNTZ3($M1)
	GUICtrlSetData($HLABEL3, $M1)
EndFunc
$LOSS = 0
Func LOSSS()
	$LOSS = $LOSS + 1
	GUICtrlSetData($HLABEL5, "Loss: " & $LOSS)
EndFunc
HotKeySet("f", "FQUIT")
Func FQUIT()
	Exit
EndFunc
Func MOVECLICK($XXX, $YYY)
	MouseMove($XXX, $YYY, 3)
	Sleep(100)
	MouseClick("left", $XXX, $YYY, 1, 5)
	Sleep(100)
	$NEWXXX = $XXX + 100
	$NEWYYY = $YYY + 100
	IF ($NEWXXX > 800) Then $NEWXXX = 1600 - $NEWXXX
	IF ($NEWYYY > 600) Then $NEWYYY = 1200 - $NEWYYY
	MouseMove($NEWXXX, $NEWYYY, 3)
	Sleep(100)
EndFunc
$XX = 0
$YY = 0
WHILE (1)
	$NMSG = GUIGetMsg()
	Switch $NMSG
		Case $GUI_EVENT_CLOSE
			Exit
	EndSwitch
	Sleep(2000)
	UPDATETIME()
	$RESULT1 = _IMAGESEARCHAREA($IMAGEDIR & "login0.bmp", 1, 380, 310, 420, 360, $XX, $YY, 70)
	IF ($RESULT1 == 1) Then
		Sleep(1000)
		Send("{ESC}")
		Sleep(500)
		Send("{ESC}")
		Sleep(1000)
	EndIf
	$RESULT1 = _IMAGESEARCHAREA($IMAGEDIR & "login1.bmp", 1, 678, 571, 792, 591, $XX, $YY, 70)
	IF ($RESULT1 == 1) Then
		Send("e")
		Sleep(1000)
		MOVECLICK($XX, $YY)
		Sleep(500)
		MOVECLICK($XX, $YY)
		Sleep(1000)
	EndIf
	$RESULT1 = _IMAGESEARCHAREA($IMAGEDIR & "login2.bmp", 1, 309, 327, 371, 347, $XX, $YY, 70)
	IF ($RESULT1 == 1) Then
		Send("e")
		Sleep(1000)
		MOVECLICK($XX, $YY)
		Sleep(500)
		MOVECLICK($XX, $YY)
		Sleep(1000)
	EndIf
	$RESULT1 = _IMAGESEARCHAREA($IMAGEDIR & "login3.bmp", 1, 711, 473, 779, 503, $XX, $YY, 70)
	IF ($RESULT1 == 1) Then
		Send("e")
		Sleep(1000)
		MOVECLICK($XX, $YY)
		Sleep(500)
		MOVECLICK($XX, $YY)
		Sleep(1000)
		Send("q")
		Sleep(30000)
	EndIf
	$RESULT1 = _IMAGESEARCHAREA($IMAGEDIR & "login4.bmp", 1, 720, 477, 788, 495, $XX, $YY, 70)
	IF ($RESULT1 == 1) Then
		Send("e")
		Sleep(1000)
		MOVECLICK($XX, $YY)
		Sleep(500)
		MOVECLICK($XX, $YY)
		Sleep(1000)
		Send("q")
		Sleep(30000)
	EndIf
	$FILE = FileOpen("scripts/BotStatus.txt", 0)
	$STATZ = FileReadLine($FILE)
	FileClose($FILE)
	UNTZ1($STATZ)
	IF ($STATZ == "InGame") Then
		$RESULT1 = _IMAGESEARCHAREA($IMAGEDIR & "loading.bmp", 1, 221, 30, 565, 120, $XX, $YY, 70)
		IF ($RESULT1 == 1) Then
			UNTZ2("Load screen found")
			UNTZ3("ABORT!!!")
			$ZZZZZ = $LOSS + 1
			WRITELOG("-- BAIL - Retry Detected - Bails:" & $ZZZZZ)
			Sleep(2000)
			Send("e")
			Sleep(2000)
			Send("q")
			Sleep(2000)
			UNTZ3("Waiting for reset ..")
			Sleep(10000)
			UNTZ3("")
			LOSSS()
		Else
			UNTZ2("")
		EndIf
		$RESULT1 = _IMAGESEARCHAREA($IMAGEDIR & "dead.bmp", 1, 319, 312, 481, 342, $XX, $YY, 70)
		IF ($RESULT1 == 1) Then
			UNTZ2("Death Screen found")
			UNTZ3("ABORT!!!")
			$ZZZZZ = $LOSS + 1
			WRITELOG("-- BAIL - Death Screen Found - Bails:" & $ZZZZZ)
			Send("e")
			Sleep(2000)
			MOVECLICK($XX, $YY)
			Sleep(2000)
			Send("q")
			Sleep(2000)
			UNTZ3("Waiting for reset ..")
			Sleep(10000)
			UNTZ3("")
			LOSSS()
		Else
			UNTZ2("")
		EndIf
	EndIf
WEnd

; DeTokenise by myAut2Exe >The Open Source AutoIT/AutoHotKey script decompiler< 2.10 build(157)