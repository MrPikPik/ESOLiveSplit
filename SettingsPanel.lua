local ESOLS = ESOLS or {}

-- Creates the addon settings menu
function ESOLS.InitializeAddonMenu()
	local panelData = {
		type = "panel",
		name = "ESO Live Split",
		displayName = "ESO Live Split",
		author = "MrPikPik",
		version = ESOLS.version,
		website = 'https://www.esoui.com/downloads/info3782-ESOLiveSplit.html#donate',
		donation = function()
			SCENE_MANAGER:Show('mailSend')
			zo_callLater(function()
				ZO_MailSendToField:SetText("@MrPikPik")
				ZO_MailSendSubjectField:SetText("Thank you for making addons!")
				ZO_MailSendBodyField:SetText("I like using your addon 'ESO Live Split'")
				ZO_MailSendBodyField:TakeFocus()
			end, 250)
		end,
		registerForRefresh = true,
		registerForDefaults = true
	}

	local optionsData = {}

    -- Appearance header
	table.insert(optionsData, {
		type = "header",
		name = GetString(SI_LIVE_SPLIT_HEADER_APPEARANCE),
	})

	-- Additional info
    table.insert(optionsData, {
		type = "checkbox",
		name = GetString(SI_LIVE_SPLIT_SHOWINFO_SETTING),
		tooltip = GetString(SI_LIVE_SPLIT_SHOWINFO_SETTING_TT),
		default = ESOLS.defaults.additionalInfo,
		getFunc = function() return ESOLS.SV.additionalInfo end,
		setFunc = function(showInfo)
            LIVE_SPLIT:ShowAdditionalInfo(showInfo)
        end,
	})

	-- NumSplitsShown
	table.insert(optionsData, {
		type = "slider",
		name = GetString(SI_LIVE_SPLIT_MAXSHOWN),
		tooltip = GetString(SI_LIVE_SPLIT_MAXSHOWN_TT),
        min = 3,
        max = 10,
		default = ESOLS.defaults.maxsplitsshown,
		getFunc = function()
            return ESOLS.SV.maxsplitsshown
        end,
		setFunc = function(newValue)
            LIVE_SPLIT:SetMaxDisplaySplits(newValue)
        end,
	})

	-- Scale
	table.insert(optionsData, {
		type = "slider",
		name = GetString(SI_LIVE_SPLIT_SCALE) .. " (in %)",
		tooltip = GetString(SI_LIVE_SPLIT_SCALE_TT),
        min = 50,
        max = 100,
		step = 5,
		clampInput = true,
		default = ESOLS.defaults.scale * 100,
		getFunc = function()
            return ESOLS.SV.scale * 100
        end,
		setFunc = function(newValue)
            LIVE_SPLIT:SetScale(newValue / 100)
        end,
	})

    -- Divider
    table.insert(optionsData, {
		type = "divider",
	})

	-- Behavioue header
	table.insert(optionsData, {
		type = "header",
		name = GetString(SI_LIVE_SPLIT_HEADER_BEHAVIOR),
	})

    -- Operation Mode
	table.insert(optionsData, {
		type = "dropdown",
		name = GetString(SI_LIVE_SPLIT_MODE),
		tooltip = GetString(SI_LIVE_SPLIT_MODE_TT),
		choices = {
            GetString(SI_LIVE_SPLIT_MODE_AUTO),
            GetString(SI_LIVE_SPLIT_MODE_MIXED),
            GetString(SI_LIVE_SPLIT_MODE_MANUAL)
        },
		getFunc = function()
			if ESOLS.SV.mode == 1 then
				return GetString(SI_LIVE_SPLIT_MODE_AUTO)
			elseif ESOLS.SV.mode == 2 then
				return GetString(SI_LIVE_SPLIT_MODE_MIXED)
			elseif ESOLS.SV.mode == 3 then
				return GetString(SI_LIVE_SPLIT_MODE_MANUAL)
			end
		end,
		setFunc = function(newValue)
			if newValue == GetString(SI_LIVE_SPLIT_MODE_AUTO) then
				LIVE_SPLIT:UpdateMode(1)
			elseif newValue == GetString(SI_LIVE_SPLIT_MODE_MIXED) then
				LIVE_SPLIT:UpdateMode(2)
			elseif newValue == GetString(SI_LIVE_SPLIT_MODE_MANUAL) then
				LIVE_SPLIT:UpdateMode(3)
			end
		end,
		default = ESOLS.defaults.mode,
	})

	-- Commit immediately
    table.insert(optionsData, {
		type = "checkbox",
		name = GetString(SI_LIVE_SPLIT_COMMIT_IMMEDIATELY),
		tooltip = GetString(SI_LIVE_SPLIT_COMMIT_IMMEDIATELY_TT),
		default = ESOLS.defaults.commitImmediately,
		getFunc = function() return ESOLS.SV.commitImmediately end,
		setFunc = function(value)
			ESOLS.SV.commitImmediately = value
            LIVE_SPLIT.commitImmediately = value
        end,
	})

	--local count = 1
	local optionsPanel = LibAddonMenu2:RegisterAddonPanel(ESOLS.name, panelData)
	LibAddonMenu2:RegisterOptionControls(ESOLS.name, optionsData)
end