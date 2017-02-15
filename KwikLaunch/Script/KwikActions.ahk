; AHK Application Path = C:\Program Files\AutoHotkey\AutoHotkey.exe
; https://regex101.com/



;==========|| Start: Search ||====================================================================================================================================================
;=================================================================================================================================================================================

 	
	1001.SearchUsing|?|Google: 
		Action = Search Google
		Trigger := "g " 
		DropHeader = Search Google
		SearchURL = https://www.google.com/search?num=50&safe=off&site=&source=hp&q=URISTRING&btnG=Search&oq=&gs_l=
	return
	
	1002.SearchUsing|?|Google: 
		Action = Incognito mode
		Trigger := "i " 
		DropHeader = Search Google ( Incognito )
		SearchURL = C:\Program Files (x86)\Google\Chrome\Application\chrome.exe -incognito https://www.google.com/search?safe=off&q=URISTRING
	return	
	
	1003.SearchUsing|?|Google: 
		Action = AHK based search
		Trigger := "a " 
		DropHeader = Search Google ( For AHK Results )
		SearchURL := "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe -new-window https://www.google.com/search?num=50&safe=off&site=&source=hp&q=AutoHotKey%20URISTRING&btnG=Search&oq=&gs_l="
	return
	
	1004.SearchUsing|?|Google:
		Action = Exvius based search
		Trigger := "x " 
		DropHeader = Search Google ( For Exvius Results )
		SearchURL := "https://www.google.com/search?num=50&safe=off&site=&source=hp&q=Exvius`%20URISTRING&btnG=Search&oq=&gs_l="
	return

	1011.SearchUsing|?|YouTube:
		Action = Search YouTube
		Trigger := "y " 
		DropHeader = Search YouTube
		SearchURL := "https://www.youtube.com/results?search_query=URISTRING"
	return
	
	1021.SearchUsing|?|Craigslist:
		Action = Search Craigslist
		Trigger := "cl " 
		DropHeader = Search Craigslist
		SearchURL := "https://austin.craigslist.org/search/sss?query=URISTRING&sort=rel"
	return

	1022.SearchUsing|?|Craigslist:
		Action = Search Craigslist (Free)
		Trigger := "clf " 
		DropHeader = Search Craigslist (Free)
		SearchURL := "https://austin.craigslist.org/search/zip?query=URISTRING"
	return
	

;==========|| End: Search ||==========





;==========|| Start: RunWith ||===================================================================================================================================================
;=================================================================================================================================================================================
	
	
	1101.RunWith|?|Notepad++:
		Action = 
		Trigger := "e " 
		SubTrigger := "as4t"
		DropHeader = Edit File in Notepad++
		PathToRunWith = D:\201612_ProgramFiles(x86)\Notepad++\notepad++.exe
		PathToRun = D:\z C Drive Redirect\Documents\AutoHotkey\. AppSpec\AppSpec_4TTM.ahk
	return
	
	
;==========|| End: RunWith ||==========	





;==========|| Start: StartProg ||=================================================================================================================================================
;=================================================================================================================================================================================


	1201.StartProg:
		Action = 
		Trigger := "cc" 
		PathToRun = C:\Sysop\zh-HANX\Basic\Curse Client.appref-ms
	return

	1202.StartProg:
		Action = 
		Trigger := "fb" 
		PathToRun = C:\Perl64\coop_Temp_FiBo.lnk
	return	
	
	1203.StartProg:
		Action = 
		Trigger := "ed" 
		PathToRun = C:\Program Files (x86)\Notepad++\notepad++.exe
	return
	
	1204.StartProg:
		Action = 
		Trigger := "bs" 
		PathToRun = C:\Program Files (x86)\Bluestacks\Bluestacks.exe
	return
	
	1205.StartProg:
		Action = 
		Trigger := "xc" 
		PathToRun = C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Microsoft Office 2013\Excel 2013.lnk
	return
	
	
;==========|| End: StartProg ||==========





;==========|| Start: EditScript ||================================================================================================================================================
;=================================================================================================================================================================================

	
	1301.EditScript:
		Action = 
		Trigger := "eNPP" 
		PathToRunWith = D:\201612_ProgramFiles(x86)\Notepad++\notepad++.exe
		PathToRun = D:\z C Drive Redirect\Documents\AutoHotkey\. AppSpec\AppSpec_Notepad++.ahk
	return
	
	1302.EditScript:
		Action = 
		Trigger := "egf" 
		PathToRunWith = D:\201612_ProgramFiles(x86)\Notepad++\notepad++.exe
		PathToRun = D:\z C Drive Redirect\Documents\AutoHotkey\Lib\GF.ahk
	return
	
	1303.EditScript:
		Action = 
		Trigger := "eAH" 
		PathToRunWith = D:\201612_ProgramFiles(x86)\Notepad++\notepad++.exe
		PathToRun = D:\z C Drive Redirect\Documents\AutoHotkey\. ActionHub\ActionHub.ahk
	return
	
	
;==========|| End: EditScript ||==========





;==========|| Start: FileBrowser ||===============================================================================================================================================
;=================================================================================================================================================================================


	1401.FileBrowser:
		Action = 
		Trigger := "rb" 
		PathToRun := "::{645FF040-5081-101B-9F08-00AA002F954E}"
	return
	
	1402.FileBrowser:
		Action = 
		Trigger := "ahk" 
		PathToRun = D:\z C Drive Redirect\Documents\AutoHotkey
	return
	
	1403.FileBrowser:
		Action = 
		Trigger := "alib" 
		PathToRun = D:\z C Drive Redirect\Documents\AutoHotkey\Lib
	return
	
	
;==========|| End: FileBrowser ||==========





;==========|| Start: Write ||=====================================================================================================================================================
;=================================================================================================================================================================================
	
	
	1501.Write:
		Action = 
		Trigger := "ea" 
		StringToSend = slettenmd@gmail.com
	return


;==========|| End: Write ||==========




;==========|| Start: GoToURL ||===================================================================================================================================================
;=================================================================================================================================================================================


	1601.GoToURL:
		Action = 
		Trigger := "@" 
		PathToRun = https://inbox.google.com/u/0/
	return
	
	
;==========|| End: GoToURL ||==========