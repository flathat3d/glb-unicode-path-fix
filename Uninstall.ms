(
    callbacks.removeScripts id:#GLBUnicodePathFix
    local startup = (getDir #userStartupScripts) + "/GLBUnicodePathFix.ms"
    if doesFileExist startup do
        if not deleteFile startup do throw "Cannot remove the GLB path-fix startup loader."
    if not (globalVars.isGlobal #GLBUnicodePathFixSilentInstall and globalVars.get #GLBUnicodePathFixSilentInstall == true) do
        messageBox "Automatic path correction removed. The current Export directory is retained; change it in Configure User and System Paths if desired. Existing exports are untouched." title:"GLB Unicode Path Fix"
)
