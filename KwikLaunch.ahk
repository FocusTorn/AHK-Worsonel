
;----------|| Start: AutoExecute ||------------------------------------------------------------------------------------------------------------------------
;----------------------------------------------------------------------------------------------------------------------------------------------------------
	
	#NoEnv 
	#SingleInstance force  
	SendMode Input 
	SetWorkingDir %A_ScriptDir%
	CoordMode, Mouse, Client 
	CoordMode, Pixel, Client 
	SetDefaultMouseSpeed,0 
	DetectHiddenWindows,On 
	SetTitleMatchMode,2 
	Menu, Tray, Icon, shell32.dll, 23
	Gosub, autoexecute
	return
	
	autoexecute:
		Global iw := Class_ImmediateWindow(0)
		
		
		iw.Print("asd")
		Global Kwik_ID =
		Global Kwik_DoubleID =
		Global Kwik_Actions = {}
	return
	
;----------|| End: AutoExecute ||----------

;----------|| Start: Guis ||-------------------------------------------------------------------------------------------------------------------------------
;----------------------------------------------------------------------------------------------------------------------------------------------------------

	^Space::ShowSingleLineGUI()
	
	ShowSingleLineGUI(){
		If( Kwik_ID ){
			reload
		}
		ParseActions()
		gW := 3000
		gH := 130
		Gui Main: +LastFound -Caption -Border +AlwaysOnTop +ToolWindow    ; +HwndConsoleLogger_ID
		Kwik_ID := WinExist()
		centerX := (A_ScreenWidth/2)-(3000/2)
		editOffset := (A_ScreenWidth/2)-(390/2)
		Gui, Main: Color, cbcbcb ,212121
		Gui, Main: Add, Picture, x%centerX% y0 BackGroundTrans, .\Images\SingleLine.png
		Gui, Main: Font, s11, Century Gothic
		Gui, Main: Add, Edit, x%editOffset% y16 w380 h19 cd60000 gOmniBar -E0x200 hwndhMainEdit  ; gQueryUserCommands
		Gui, Main: Show, x0 y0 w3000 h%gH%, 
	}
	
	DoubleLineGUI(p_DropHeaderText,p_ProvidedParam,p_ProvidedValue,p_FoundIndex){
		gW := 3000
		gH := 130
		Gui Double: +LastFound -Caption -Border +AlwaysOnTop +ToolWindow    ; +HwndConsoleLogger_ID
		Kwik_DoubleID := WinExist()
		centerX := "x" (A_ScreenWidth/2)-(3000/2)
		editOffset := (A_ScreenWidth/2)-(380/2) 
		Gui, Double: Color, cbcbcb ,212121
		Gui, Double: Add, Picture, %centerX% y0 BackGroundTrans, .\Images\DoubleLine.png
		Gui, Double: Font, s11, Century Gothic
		Gui, Double: Add, Text, x%editOffset% BackGroundTrans y22 w380 h19 c555555 hwndhDropHeader -E0x200 , %p_DropHeaderText%
		Gui, Double: Add, Edit, x%editOffset% y70 w380 h19 cd60000 gDoubleOmniBar -E0x200 hwndhDoubleEdit  
		
		Gui, Double: Add, Text, hwndhProvidedParam Hidden, %p_ProvidedParam% 
		Gui, Double: Add, Text, hwndhProvidedValue Hidden, %p_ProvidedValue% 
		Gui, Double: Add, Text, hwndhFoundIndex Hidden, %p_FoundIndex% 
		Gui, Double: Add, Button,Default gSubmit Hidden 
		Gui, Double: Show, x0 y0 w3000 h%gH%
	}

;----------|| End: Guis ||----------
	
;----------|| Start: OmniBars ||----------------------------------------------------------------------------------------------------------------------------
;----------------------------------------------------------------------------------------------------------------------------------------------------------

	OmniBar:
		Gui, Main: Submit, NoHide
		EditValue := fGuiControlGet(hMainEdit)
		FoundIndex := 0
		For oi in Kwik_Actions {
			For i, v in Kwik_Actions[oi] {
				if( EditValue = v ){
					FoundIndex := oi
					;iw.Print("[[FoundIndex]] = " FoundIndex)
					Break 2
				}
			}
		} 
		If( FoundIndex ){
			LaunchKwik(Kwik_Actions[FoundIndex], FoundIndex)
		}
	return
	
	DoubleOmniBar:
		Gui, Double: Submit, NoHide
		EditValue := fGuiControlGet(hDoubleEdit)
		FoundIndex := 0
		For oi in Kwik_Actions {
			For i, v in Kwik_Actions[oi] {
				if( EditValue = v ){
					FoundIndex := oi
					Break 2
				}
			}
		} 
		If( FoundIndex ){
			fGuiControlSet(hFoundIndex,FoundIndex)
			GoTo Submit
		}
	return
	
;----------|| End: OmniBars ||----------

;----------|| Start: GuiSubs ||----------------------------------------------------------------------------------------------------------------------------
;----------------------------------------------------------------------------------------------------------------------------------------------------------
	
	Submit:
		Gui,Double: Submit, NoHide
		GuiControlGet, DoubleLineEditValue,, %hDoubleEdit%
		GuiControlGet, ProvidedParam,, %hProvidedParam%
		GuiControlGet, ProvidedValue,, %hProvidedValue%
		GuiControlGet, FoundIndex,, %hFoundIndex%
		if( ProvidedParam = "SubTrigger" ){
			fRun(Kwik_Actions[FoundIndex].PathToRun, Kwik_Actions[FoundIndex].PathToRunWith)
			reload
		}
		Else if( ProvidedParam = "SearchURL" ){
			ProvidedToURI := ToURI(DoubleLineEditValue)
			Run % StrReplace(ProvidedValue, "URISTRING" , ProvidedToURI)
			reload
		} 
	return
	
	MainGUIEscape:
		MainGUIClose:
		reload
	return
	
	DoubleGUIEscape:
	DoubleGUIClose:
		Gui Double: Destroy
		WinActivate, %Kwik_ID%
	return
	
;----------|| End: GuiSubs ||----------
	
;----------|| Start: Functions ||---------------------------------------------------------------------------------------------------------------
;----------------------------------------------------------------------------------------------------------------------------------------------------------

	ParseActions(){ 
	
	
		Collect = 0
		Item = 0
		Loop, Read, D:\z C Drive Redirect\Documents\AutoHotkey\. Kwik Launch\Script\KwikActions.ahk
		{
			CELoc = 0
			StringReplace, CurrentLine, A_LoopReadLine, %A_Tab%, ,All
			StringReplace, CurrentLine, CurrentLine, %A_Space%, ,All
			ReadLine := Trim(A_LoopReadLine)
			If( ReadLine = "return" ){
				Collect = 0
			}
			IsCommentLine := ( InStr(Trim(ReadLine),";") = 1 ? 1 : 0 )
			If( !IsCommentLine ){
				CELoc := InStr(ReadLine,":=")
				If( !CELoc ){
					ELoc := InStr(ReadLine,"=")
				}
				TypeText := (CELoc ? SubStr(ReadLine,1,CELoc-1) : SubStr(ReadLine,1,ELoc-1) ) 
				ReturnText := (CELoc ? SubStr(ReadLine,CELoc+4) : SubStr(ReadLine,ELoc+2) ) 
				TypeText := StrReplace(TypeText, " " , "")
			}
			If( TypeText = "Trigger" OR TypeText = "SubTrigger"){
				ReturnText := StrReplace(LTRIM(ReturnText), """" , "")
			}
			If( Collect = 1 ){
				if( TypeText AND TypeText != ""  ){
					Kwik_Actions[Item].Insert(TypeText, ReturnText)			
				}
			}
			If( SubStr(ReadLine, StrLen(ReadLine) ) = ":" ){ 
				Collect = 1
				Item += 1
				Kwik_Actions[Item] := {}	
			}
		}
	}
	
	LaunchKwik(p_Actions,p_FoundIndex){
		If( p_Actions.DropHeader != "" ){
			If( p_Actions.SubTrigger){
				DoubleLineGUI(p_Actions.DropHeader,"SubTrigger",p_Actions.SubTrigger, p_FoundIndex)
			}
			Else If( p_Actions.SearchURL){
				DoubleLineGUI(p_Actions.DropHeader,"SearchURL",p_Actions.SearchURL, p_FoundIndex)
			}	
		}
		Else If(p_Actions.StringToSend != "" ){
			TheString := p_Actions.StringToSend
			Gui Main: Destroy
			Send %TheString%
			reload
		}
		Else {
			fRun(p_Actions.PathToRun, p_Actions.PathToRunWith)
			reload
		}
	}
	
	ToURI(str) {
		f = %A_FormatInteger%
		SetFormat, Integer, Hex
		If RegExMatch(str, "^\w+:/{0,2}", pr)
			StringTrimLeft, str, str, StrLen(pr)
		StringReplace, str, str, `%, `%25, All
		Loop
			If RegExMatch(str, "i)[^\w\.~%/:]", char)
			   StringReplace, str, str, %char%, % "%" . SubStr(Asc(char),3), All
			Else Break
		SetFormat, Integer, %f%
		Return, pr . str
	}
	
	
	
	fRun(p_Run, p_RunWith="") {
		If(p_RunWith=""){
			Run  %p_Run%
		}
		Else {
			Run  %p_RunWith% %p_Run%
		}
	}
	
	fGuiControlGet(hwnd){
		GuiControlGet, ControlValue,, %hwnd%
		return ControlValue
	}
	
	fGuiControlSet(hwnd,TextToSet){
		ControlSetText,, %TextToSet%, AHK_ID %hwnd%
		return 1
	}
	
;----------|| End: Functions ||----------
