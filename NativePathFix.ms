/* GLB Unicode Path Fix 2.0.0: repair the native export path, no alternate exporter. */
global GLBUnicodePathFixApply
fn GLBUnicodePathFixApply =
(
    if (execute "GLTF_Export") == undefined do return false
    local current = getDir #export
    fn asciiPath value =
    (
        for index = 1 to value.count where bit.charAsInt value[index] > 127 do return false
        true
    )
    if asciiPath current do return true
    local environment = dotNetClass "System.Environment"
    local folders = dotNetClass "System.Environment+SpecialFolder"
    local root = environment.GetFolderPath folders.LocalApplicationData
    if not asciiPath root do root = environment.GetFolderPath folders.CommonDocuments
    if root == "" or not asciiPath root do throw "GLB path fix: no ASCII storage path is available. Choose an ASCII Export path in Configure User and System Paths."
    local destination = (dotNetClass "System.IO.Path").Combine root ("GLBUnicodePathFix/Export/" + (((maxVersion())[1] / 1000) as string))
    (dotNetClass "System.IO.Directory").CreateDirectory destination
    if not setDir #export destination do throw "GLB path fix: cannot set the Export directory."
    format "GLB Unicode Path Fix: native Export path set to %\n" (getDir #export)
    true
)
callbacks.removeScripts id:#GLBUnicodePathFix
if (execute "GLTF_Export") != undefined do
(
    GLBUnicodePathFixApply()
    callbacks.addScript #postProjectFolderChange "GLBUnicodePathFixApply()" id:#GLBUnicodePathFix persistent:false
)
