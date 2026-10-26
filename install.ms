global GLBUnicodePathFixApply
(
    if (execute "GLTF_Export") == undefined do throw "This Max installation has no native GLB exporter. No files were installed."
    local packageRoot = getFilenamePath (getThisScriptFilename())
    local source = packageRoot + "NativePathFix.ms"
    local destination = (getDir #userScripts) + "/GLBUnicodePathFix/2.0.0/"
    local startup = (getDir #userStartupScripts) + "/GLBUnicodePathFix.ms"
    local ioFile = dotNetClass "System.IO.File"
    local startupText = "fileIn ((getDir #userScripts) + \"/GLBUnicodePathFix/2.0.0/NativePathFix.ms\")\n"
    makeDir destination all:true
    -- These two paths belong exclusively to this tool. Installing replaces its previous release.
    ioFile.Copy source (destination + "NativePathFix.ms") true
    ioFile.Copy (packageRoot + "Uninstall.ms") (destination + "Uninstall.ms") true
    ioFile.WriteAllText startup startupText
    fileIn (destination + "NativePathFix.ms")
    if not (globalVars.isGlobal #GLBUnicodePathFixSilentInstall and globalVars.get #GLBUnicodePathFixSilentInstall == true) do
        messageBox "Installed. Continue using the original File > Export / Export Selected > GLB. No extra export action is required. A non-ASCII Export default directory is redirected to an ASCII directory; you can still choose a Unicode output filename." title:"GLB Unicode Path Fix"
)
