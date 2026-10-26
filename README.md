# GLB Unicode Path Fix 2.0.0

Install once, then keep using **File → Export / Export Selected → GLB**. No extra exporter, toolbar button, custom material or scene conversion is required.

This package addresses a reproduced native 3ds Max exporter failure: a non-ASCII Export directory can make intermediate MaterialX loading fail, resulting in a black fallback material, missing images and no declared UV attribute.

## Install

Drag `GLB_Unicode_Path_Fix_2.0.0.mzp` into Max, or select it through **Scripting → Run Script**. It applies immediately in that Max instance and loads automatically on subsequent launches. Install separately in each Max version/language profile you use. No administrator access, SDK or plug-in DLL is needed.

## What changes

The original Autodesk exporter remains in place. If Max's configured **Export directory** contains non-ASCII characters, the package redirects it to an ASCII directory under the Windows Local AppData folder, or Public Documents if needed. An already-ASCII Export directory is left unchanged. The check also runs after a project-folder change.

This is a configuration workaround, **not a binary patch of Autodesk's exporter**. The Export directory is shared by Max's export workflows, so their default folder can change too. You can still choose your final output folder and filename, including Chinese paths. No pre-export hook intercepts other exporters, and no materials, geometry or original assets are rewritten by this package.

The change is intentionally persistent for the active session. It does not restore the broken default after each export. Native overwrite prompts and export options remain Autodesk's behavior. The default Export directory and intermediate files reside under `<LocalAppData>/GLBUnicodePathFix/Export/<Max major version>` (or Public Documents fallback).

## Compatibility

The installer checks for the built-in `GLTF_Export` class instead of hardcoding supported year numbers. It is intended for Max versions with that exporter and the APIs used by the script. It does not add GLB export to versions without it. **Actually tested: Max 2023 (25.0.0.997) and Max 2025.3 (27.3.0.30874).** Other versions are capability-targeted, not claimed as tested.

Changing the Export directory manually back to a non-ASCII path can reintroduce the issue until the correction runs again. Rerun the installer or restart Max in that case. Unsupported materials/maps, missing source images and other GLB defects are outside this fix. If both storage candidates contain non-ASCII characters, installation reports the path problem instead of claiming success.

## Remove

Run the included `Uninstall.ms` in the Max profile where you installed the fix. It removes the startup loader and project-change callback. It leaves the current Export path and existing output files intact; choose another Export directory in **Configure User and System Paths** if desired. No backup copies are created. Remaining readable scripts reside under `<userScripts>/GLBUnicodePathFix/2.0.0` and may be removed manually.

## Source and license

All scripts are readable and included under the MIT license. No Autodesk binaries, SDK files, user photos, scenes or machine-specific paths are included. This is an independent community workaround, not an Autodesk product or certified plug-in. Autodesk and 3ds Max are trademarks of Autodesk, Inc.

## 中文說明

將 `.mzp` 拖入 Max，或用 **Scripting → Run Script** 執行即可安裝。之後照常用原本的 **File → Export / Export Selected → GLB**，不用額外按鈕。

工具會把含中文等非 ASCII 字元的 Export 預設目錄改到英文路徑，修正中間材質檔讀取失敗；最終輸出仍能選中文資料夾與檔名。這是原功能的路徑設定修正，沒有修改 Autodesk DLL。Export 目錄為共用設定，因此其他格式的預設匯出資料夾也可能改變。

已實測 2023、2025.3；其他具備原生 GLB 匯出器的版本採功能偵測，不代表逐版實測。執行 `Uninstall.ms` 移除自動修正；不備份、不刪除模型、貼圖或輸出成果。
