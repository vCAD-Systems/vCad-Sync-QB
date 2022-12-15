function CreateDialog(OnScreenDisplayTitle_shopmenu)
	AddTextEntry(OnScreenDisplayTitle_shopmenu, OnScreenDisplayTitle_shopmenu)
	DisplayOnscreenKeyboard(1, OnScreenDisplayTitle_shopmenu, "", "", "", "", "", 32)
	while (UpdateOnscreenKeyboard() == 0) do
		DisableAllControlActions(0);
		Wait(0);
	end
	if (GetOnscreenKeyboardResult()) then
		local displayResult = GetOnscreenKeyboardResult()
		return displayResult
	end
end