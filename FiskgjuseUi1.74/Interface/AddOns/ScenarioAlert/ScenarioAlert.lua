ScenarioAlert = {}
ScenarioAlert.logFileName = "scenarioAlert"

function ScenarioAlert.OnInitialize()
	
	TextLogCreate(ScenarioAlert.logFileName, 18000)
	TextLogSetEnabled(ScenarioAlert.logFileName, true)
	TextLogSetIncrementalSaving(ScenarioAlert.logFileName, true, StringToWString("logs/"..ScenarioAlert.logFileName..".log"))	

	RegisterEventHandler(SystemData.Events.SCENARIO_SHOW_JOIN_PROMPT, "ScenarioAlert.recordScPop")
end

function ScenarioAlert.recordScPop()
	TextLogAddEntry(ScenarioAlert.logFileName, 0, towstring("pop"))
	TextLogSaveLog(ScenarioAlert.logFileName,towstring(""))
end

-- /script ScenarioAlert.recordScPop()
-- /script TextLogDestroy("scenarioAlert.log")
-- /script ScenarioAlert.clearLogFile()
function ScenarioAlert.clearLogFile()
	TextLogDestroy("scenarioAlert")
	TextLogCreate(ScenarioAlert.logFileName, 18000)
	TextLogSetEnabled(ScenarioAlert.logFileName, true)
	TextLogSetIncrementalSaving(ScenarioAlert.logFileName, true, StringToWString("logs/"..ScenarioAlert.logFileName..".log"))	
end