HideHiddenFrames = {}
local begin
local toggle

function HideHiddenFrames.Initialize()
    begin = LayoutEditor.Begin
    LayoutEditor.Begin = HideHiddenFrames.Begin

    toggle = LayoutEditor.OnToggleHidden
    LayoutEditor.OnToggleHidden = HideHiddenFrames.OnToggleHidden
end

function HideHiddenFrames.Begin()

    -- LayoutEditor.isActive = true
    
    -- WindowUtils.ClearOpenList()
    
    -- -- Create the base editor window.
    -- CreateWindow( LayoutEditor.WINDOW_NAME, true )
    -- WindowAssignFocus( LayoutEditor.WINDOW_NAME, true )     
           

    -- -- Initialize the HUD Controls
    -- LabelSetText("LayoutEditorWindowHUDControlsTitleBarText", GetStringFromTable( "CustomizeUiStrings", StringTables.CustomizeUi.LABEL_CONTROLS ) )
    -- ButtonSetText("LayoutEditorWindowHUDControlsOptionsButton",  GetStringFromTable( "CustomizeUiStrings", StringTables.CustomizeUi.LABEL_OPTIONS_BUTTON ) )    
    -- ButtonSetText("LayoutEditorWindowHUDControlsWindowsBrowserButton",  GetStringFromTable( "CustomizeUiStrings", StringTables.CustomizeUi.LABEL_WINDOWS_BUTTON ) )    
    -- ButtonSetText("LayoutEditorWindowHUDControlsRestoreDefaultsButton",  GetStringFromTable( "CustomizeUiStrings", StringTables.CustomizeUi.LABEL_RESTORE_DEFAULTS ) )
    -- ButtonSetText("LayoutEditorWindowHUDControlsExitButton",  GetStringFromTable( "CustomizeUiStrings", StringTables.CustomizeUi.LABEL_EXIT ) )    
     
    -- ButtonSetStayDownFlag( "LayoutEditorWindowHUDControlsWindowsBrowserButton", true ) 
           
    -- -- Initialize the Control Screen
    -- LabelSetText("LayoutEditorWindowControlScreenDialogTitleBarText", GetStringFromTable( "CustomizeUiStrings", StringTables.CustomizeUi.LABEL_LAYOUT_EDITOR ) )
    -- LabelSetText("LayoutEditorWindowControlScreenDialogScrollWindowScrollChildContainerDescText",  GetStringFromTable( "CustomizeUiStrings", StringTables.CustomizeUi.LABEL_LAYOUT_EDITOR_INTRO ) )
    -- LabelSetText("LayoutEditorWindowControlScreenDialogScrollWindowScrollChildContainerInstructionsLabel",  GetStringFromTable( "CustomizeUiStrings", StringTables.CustomizeUi.LABEL_INSTRUCTIONS ) )
    -- LabelSetText("LayoutEditorWindowControlScreenDialogScrollWindowScrollChildContainerInstructionsText",  GetStringFromTable( "CustomizeUiStrings", StringTables.CustomizeUi.TEXT_LAYOUT_EDITOR_INSTRUCTIONS ) )
    -- ScrollWindowUpdateScrollRect( "LayoutEditorWindowControlScreenDialogScrollWindow" )    
    -- ScrollWindowSetOffset( "LayoutEditorWindowControlScreenDialogScrollWindow", 0 )

    -- ButtonSetText("LayoutEditorWindowControlScreenDialogStartButton",  GetStringFromTable( "CustomizeUiStrings", StringTables.CustomizeUi.LABEL_START_LAYOUT_MODE ) )
    -- ButtonSetText("LayoutEditorWindowControlScreenDialogExitButton",  GetStringFromTable( "CustomizeUiStrings", StringTables.CustomizeUi.LABEL_EXIT ) )
    -- ButtonSetText("LayoutEditorWindowControlScreenDialogRestoreDefaultsButton",  GetStringFromTable( "CustomizeUiStrings", StringTables.CustomizeUi.LABEL_RESTORE_DEFAULTS ) )

        
       
    -- -- Create Manipulation framesList for each of the resistered windows.    
    -- for windowName, windowData in pairs( LayoutEditor.windowsList )
    -- do    
    --     -- if (not windowData.isUserHidden) then
    --         local frame = LayoutFrame:Create( windowData, LayoutEditor.WINDOW_NAME )   
    --         LayoutEditor.framesList[ windowName ] = frame
    --     -- end
    -- end
    
    -- -- Initialize all the framesList AFTER creation. 
    -- for _, frame in pairs( LayoutEditor.framesList ) 
    -- do   
    --     if( frame )
    --     then
    --         frame:Attach()               
    --     end
    -- end
    
    
    -- RegisterEventHandler( SystemData.Events.L_BUTTON_UP_PROCESSED,   "LayoutEditor.OnLButtonUpProcessed")  
    
    -- -- Initialize the Sub Windows
    -- LayoutEditor.InitializeWindowBrowser()
    -- LayoutEditor.InitializeOptions()
    
    -- LayoutEditor.CallRegisteredEditorCallbacks( LayoutEditor.EDITING_BEGIN )      
    begin()

    for _, frame in pairs( LayoutEditor.framesList ) 
    do   
        if( frame.m_windowData.isUserHidden )
        then
            frame:Show(false)               
        end
    end
end

function HideHiddenFrames.OnToggleHidden()

    local rowIndex  = WindowGetId( WindowGetParent( SystemData.ActiveWindow.name ) )
    local dataIndex = ListBoxGetDataIndex( "LayoutEditorWindowControlScreenBrowserWindowsList", rowIndex )
    local frame = LayoutEditor.windowBrowserDataList[dataIndex]
    -- local frame = LayoutEditor.windowBrowserDataList[dataIndex]    
    -- frame:SetHidden( not frame:IsHidden() )
    
    -- -- If showing the frame, auto-select it
    -- if( not frame:IsHidden() )
    -- then
    --     LayoutEditor.SetActiveFrame( frame )
    -- end
    
    toggle()
    
    frame:Show(not frame:IsHidden())
end