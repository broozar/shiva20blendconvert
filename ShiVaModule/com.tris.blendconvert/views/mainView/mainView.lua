-- BLENDCONVERT - November 2018
-- Felix Caffier

--------------------------------------------------------------------------------
-- TOOLS
--------------------------------------------------------------------------------

function getBlenderExePath ( )

	local p = "" -- out
	local sMID = this.getModuleIdentifier ( )
	local sB3DPat = project.getUserProperty ( nil, sMID ..".config.blend.blender.path" )

	if system.getOSType() == system.kOSTypeWindows then
		p = sB3DPat .."/blender.exe"
	elseif system.getOSType() == system.kOSTypeMac then
		p = sB3DPat .."/Blender.app/Contents/MacOS/blender"
	elseif system.getOSType() == system.kOSTypeLinux then
		p = sB3DPat .."/blender"
	else
		log.warning ("BlendConvert: Could not locate Blender binary, unsupported OS!")
		return false, ""
	end
	
	if system.fileExists ( p ) then
		return true, p
	else
		log.warning ("BlendConvert: Could not locate Blender binary!")
		return false, ""
	end
	
end

--------------------------------------------------------------------------------
-- INIT / DESTROY
--------------------------------------------------------------------------------

function onMainViewInit ( )

    onConfigLoad ( )

end

function onMainViewDestroy ( )

end

--------------------------------------------------------------------------------
-- STARTUP CONFIG
--------------------------------------------------------------------------------

function onConfigLoad ( )

    local sMID = this.getModuleIdentifier ( )

    local hOutPat = gui.getComponent ( "blend.output.folder.path" )
    local hOutClr = gui.getComponent ( "blend.output.folder.clear" )
	
	local hB3DPat = gui.getComponent ( "blend.blender.path" )
	local hB3DFbx = gui.getComponent ( "blend.blender.fbx" )

    --local hImpMat = gui.getComponent ( "blend.import.material" )
    local hImpTex = gui.getComponent ( "blend.import.texture" )
    --local hImpLnk = gui.getComponent ( "blend.import.link" )
    --local hImpShp = gui.getComponent ( "blend.import.shape" )
    local hImpAni = gui.getComponent ( "blend.import.animation" )
    local hImpGlo = gui.getComponent ( "blend.import.global" )

	
    local sOutPat = project.getUserProperty ( nil, sMID ..".config.blend.output.folder.path" )
    local bOutClr = project.getUserProperty ( nil, sMID ..".config.blend.output.folder.clear" )
	
	local sB3DPat = project.getUserProperty ( nil, sMID ..".config.blend.blender.path" )
	local bB3DFbx = project.getUserProperty ( nil, sMID ..".config.blend.blender.fbx" )

    --local bImpMat = project.getUserProperty ( nil, sMID ..".config.blend.import.material" )
    local bImpTex = project.getUserProperty ( nil, sMID ..".config.blend.import.texture" )
    --local bImpLnk = project.getUserProperty ( nil, sMID ..".config.blend.import.link" )
    --local bImpShp = project.getUserProperty ( nil, sMID ..".config.blend.import.shape" )
    local bImpAni = project.getUserProperty ( nil, sMID ..".config.blend.import.animation" )
    local bImpGlo = project.getUserProperty ( nil, sMID ..".config.blend.import.global" )

	
    if ( hOutPat ) then gui.setEditBoxText ( hOutPat, sOutPat or "" ) end
    if ( hOutClr ) then gui.setCheckBoxState ( hOutClr, bOutClr and gui.kCheckStateOn or gui.kCheckStateOff ) end
    if ( hOutImp ) then gui.setCheckBoxState ( hOutImp, bOutImp and gui.kCheckStateOn or gui.kCheckStateOff ) end
	
	if ( hB3DPat ) then gui.setEditBoxText ( hB3DPat, sB3DPat or "" ) end
	if ( hB3DFbx ) then gui.setCheckBoxState ( hB3DFbx, bB3DFbx and gui.kCheckStateOn or gui.kCheckStateOff ) end

    --if ( hImpMat ) then gui.setCheckBoxState ( hImpMat, bImpMat and gui.kCheckStateOn or gui.kCheckStateOff ) end
    if ( hImpTex ) then gui.setCheckBoxState ( hImpTex, bImpTex and gui.kCheckStateOn or gui.kCheckStateOff ) end
    --if ( hImpLnk ) then gui.setCheckBoxState ( hImpLnk, bImpLnk and gui.kCheckStateOn or gui.kCheckStateOff ) end
    --if ( hImpShp ) then gui.setCheckBoxState ( hImpShp, bImpShp and gui.kCheckStateOn or gui.kCheckStateOff ) end
    if ( hImpAni ) then gui.setCheckBoxState ( hImpAni, bImpAni and gui.kCheckStateOn or gui.kCheckStateOff ) end
    if ( hImpGlo ) then gui.setCheckBoxState ( hImpGlo, bImpGlo and gui.kCheckStateOn or gui.kCheckStateOff ) end

end

function onConfigSave ( )

    local sMID = this.getModuleIdentifier ( )

    local hOutPat = gui.getComponent ( "blend.output.folder.path" )
    local hOutClr = gui.getComponent ( "blend.output.folder.clear" )
	
	local hB3DPat = gui.getComponent ( "blend.blender.path" )
	local hB3DFbx = gui.getComponent ( "blend.blender.fbx" )

    --local hImpMat = gui.getComponent ( "blend.import.material" )
    local hImpTex = gui.getComponent ( "blend.import.texture" )
    --local hImpLnk = gui.getComponent ( "blend.import.link" )
    --local hImpShp = gui.getComponent ( "blend.import.shape" )
    local hImpAni = gui.getComponent ( "blend.import.animation" )
    local hImpGlo = gui.getComponent ( "blend.import.global" )


    project.setUserProperty ( nil, sMID ..".config.blend.output.folder.path", gui.getEditBoxText ( hOutPat ) )
    project.setUserProperty ( nil, sMID ..".config.blend.output.folder.clear", gui.getCheckBoxState ( hOutClr ) == gui.kCheckStateOn )
	
	project.setUserProperty ( nil, sMID ..".config.blend.blender.path", gui.getEditBoxText ( hB3DPat ) )
	project.setUserProperty ( nil, sMID ..".config.blend.blender.fbx", gui.getCheckBoxState ( hB3DFbx ) == gui.kCheckStateOn )

    --project.setUserProperty ( nil, sMID ..".config.blend.import.material", gui.getCheckBoxState ( hImpMat ) == gui.kCheckStateOn )
    project.setUserProperty ( nil, sMID ..".config.blend.import.texture", gui.getCheckBoxState ( hImpTex ) == gui.kCheckStateOn )
    --project.setUserProperty ( nil, sMID ..".config.blend.import.link", gui.getCheckBoxState ( hImpLnk ) == gui.kCheckStateOn )
    --project.setUserProperty ( nil, sMID ..".config.blend.import.shape", gui.getCheckBoxState ( hImpShp ) == gui.kCheckStateOn )
    project.setUserProperty ( nil, sMID ..".config.blend.import.animation", gui.getCheckBoxState ( hImpAni ) == gui.kCheckStateOn )
    project.setUserProperty ( nil, sMID ..".config.blend.import.global", gui.getCheckBoxState ( hImpGlo ) == gui.kCheckStateOn )

end

--------------------------------------------------------------------------------
-- INPUT
--------------------------------------------------------------------------------

function onInputAdd ( )

    local hTree = gui.getComponent ( "blend.input.resource.tree" )
    local cTree = gui.getTreeItemCount ( hTree )
    local tOldFiles = {}
    for j=1, cTree do
        table.insert ( tOldFiles, gui.getTreeItemText ( gui.getTreeItem ( hTree, j ) ) )
    end


    local tNewFiles = gui.showFileChooserDialog ( "Add files...", "", "All files (*.*);;Blender (*.blend)", gui.kFileChooserDialogOptionOpenFiles )
    if ( tNewFiles and ( utils.getVariableType ( tNewFiles ) == utils.kVariableTypeTable ) and ( #tNewFiles > 0 ) ) then
        for i = 1, #tNewFiles do
            local it = tNewFiles[i]
            if ( cTree > 0 ) then
                if ( table.find ( tOldFiles, it ) ) then
                    log.message ( "BlendConvert: Ignoring duplicate file '" ..it .."'" )
                else
                    local item = gui.appendTreeItem ( hTree )
                    gui.setTreeItemData ( item, gui.kDataRoleDisplay, it )
                end
            else
                local item = gui.appendTreeItem ( hTree )
                gui.setTreeItemData ( item, gui.kDataRoleDisplay, it )
            end
        end
    end

end

function onInputRemoveAll ( )

    local hTree = gui.getComponent ( "blend.input.resource.tree" )
    local cTree = gui.getTreeItemCount ( hTree )
    if cTree < 1 then return end
    for j=cTree, 1, -1 do
        gui.removeTreeItem ( hTree, gui.getTreeItem ( hTree, j ) )
    end

end

function onInputRemove ( )

    local hTree = gui.getComponent ( "blend.input.resource.tree" )
    local cTree = gui.getTreeItemCount ( hTree )
    if cTree < 1 then return end

    for i=cTree, 1, -1 do
        local it = gui.getTreeItem ( hTree, i )
        if gui.isTreeItemSelected ( hTree, it ) then
            gui.removeTreeItem ( hTree, it )
        end
    end

end

--------------------------------------------------------------------------------
-- FBX and DAE EXPORT
--------------------------------------------------------------------------------

function onExportFBX ( )

	local sMID = this.getModuleIdentifier ( )

	local sPyFBXPath = module.getRootDirectory ( this.getModule() ) .."python/si_meshAnimsToFBX2.py"
	if (system.fileExists(sPyFBXPath) == false) then
		log.warning ("BlendConvert: Blender FBX python script not found, aborting...")
		return
	end
	
	local bOK, sBlenderExePath = getBlenderExePath ()
	if (bOK == false) then
		log.warning ("BlendConvert: Blender path not found, aborting...")
		return
	end
	
	local sOutputDir = project.getUserProperty ( nil, sMID ..".config.blend.output.folder.path" ) .."/"
	
	-- FBX options
    --local bImpMat = project.getUserProperty ( nil, sMID ..".config.blend.import.material" ) and 1 or 0
    local bImpTex = project.getUserProperty ( nil, sMID ..".config.blend.import.texture" ) and 1 or 0
    --local bImpLnk = project.getUserProperty ( nil, sMID ..".config.blend.import.link" ) and 1 or 0
    --local bImpShp = project.getUserProperty ( nil, sMID ..".config.blend.import.shape" ) and 1 or 0
	local bImpAni = project.getUserProperty ( nil, sMID ..".config.blend.import.animation" ) and 1 or 0
    local bImpGlo = project.getUserProperty ( nil, sMID ..".config.blend.import.global" ) and 1 or 0
	
	-- construct other arguments
	local aBackground = "-b"
	local aPython = "--python"
	local aPyScript = sPyFBXPath
	local aOutPath = sOutputDir
	local aAnim = 0 -- ANIM 0 none; 2 pack in FBX
	if ( bImpAni == 1 ) then aAnim = 2 end
	
	-- iterate tree
	local hTree = gui.getComponent ( "blend.input.resource.tree" )
    local cTree = gui.getTreeItemCount ( hTree )
    for i=1, cTree do
        
		local aFilename = gui.getTreeItemText ( gui.getTreeItem ( hTree, i ) )
		
		local tArgs = { aBackground, aFilename, aPython, aPyScript, "--", aOutPath, aAnim, bImpTex, bImpGlo }
        
		system.execute ( sBlenderExePath, tArgs )
		log.message ( "BlendConvert: Running FBX -> " ..aFilename )
		
	end
	
	log.message ("BlendConvert: Conversion from .blend to .fbx finished!")

end

function onExportDAE ( )

	local sMID = this.getModuleIdentifier ( )

	local sPyDAEPath = module.getRootDirectory ( this.getModule() ) .."python/si_meshToDAE.py"
	if (system.fileExists(sPyDAEPath) == false) then
		log.warning ("BlendConvert: Blender DAE python script not found, aborting...")
		return
	end
	
	local bOK, sBlenderExePath = getBlenderExePath ()
	if (bOK == false) then
		log.warning ("BlendConvert: Blender path not found, aborting...")
		return
	end
	
	local sOutputDir = project.getUserProperty ( nil, sMID ..".config.blend.output.folder.path" ) .."/"
	
	-- construct arguments
	local aBackground = "-b"
	local aPython = "--python"
	local aPyScript = sPyDAEPath
	local aOutPath = sOutputDir
	
	-- iterate tree
	local hTree = gui.getComponent ( "blend.input.resource.tree" )
    local cTree = gui.getTreeItemCount ( hTree )
    for i=1, cTree do
        
		local aFilename = gui.getTreeItemText ( gui.getTreeItem ( hTree, i ) )
		
		local tArgs = { aBackground, aFilename, aPython, aPyScript, "--", aOutPath }
        
		system.execute ( sBlenderExePath, tArgs )
		log.message ( "BlendConvert: Running DAE -> " ..aFilename )
		
	end

	log.message ("BlendConvert: Conversion from .blend to .dae finished!")

end

function onRunImport ( )

    onConfigSave ( )
	
	local sMID = this.getModuleIdentifier ( )
	
	-- check file name input
	
	local hTree = gui.getComponent ( "blend.input.resource.tree" )
    local cTree = gui.getTreeItemCount ( hTree )
    if cTree < 1 then
        log.warning ( "BlendConvert: nothing to import..." )
        return
    end
	
	-- clear target if requested
	
    local sOutPat = project.getUserProperty ( nil, sMID ..".config.blend.output.folder.path" ) or ""
	if (sOutPat == "") then
		log.warning ( "BlendConvert: empty output folder path..." )
        return
	end
	
	
    local bOutClr = project.getUserProperty ( nil, sMID ..".config.blend.output.folder.clear" )  and 1 or 0
	
    if bOutClr == 1 then

        local r = system.findFiles ( sOutPat, false )
        if (r) then
            for i=1, #r do
                local e = project.getFileExtension ( r[i] )
                if string.lower ( e ) == "dae" or string.lower ( e ) == "fbx" then
                    log.message ( "BlendConvert: deleting " ..sOutPat .."/" ..project.getFileFullName ( r[i] ) )
                    project.destroyFile ( r[i] )
                end
            end
        end
		
    end
	
	-- start
	
    log.message ( "-------------------------------\nBlendConvert: Starting the conversion process" )

	if ( project.getUserProperty ( nil, sMID ..".config.blend.blender.fbx" ) ) then
		onExportFBX ( )
	else
		onExportDAE ( )
	end

end

