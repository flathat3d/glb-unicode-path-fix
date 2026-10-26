"""Build the installer from this checkout using Python's standard library."""
from pathlib import Path
import zipfile

root = Path(__file__).resolve().parent
output = root / "dist" / "GLB_Unicode_Path_Fix_2.0.0.mzp"
output.parent.mkdir(exist_ok=True)
files = ("install.ms", "NativePathFix.ms", "Uninstall.ms", "README.md", "TESTED.md", "LICENSE")
control = ('name "GLB Unicode Path Fix"\nversion 2.0\n'
           'description "Repair the original native GLB export path"\n'
           'run "install.ms"\ndrop "install.ms"\nkeep temp\n')
with zipfile.ZipFile(output, "w", zipfile.ZIP_DEFLATED) as archive:
    archive.writestr("mzp.run", control)
    for name in files:
        archive.write(root / name, name)
with zipfile.ZipFile(output) as archive:
    assert archive.testzip() is None, "Corrupt installer archive"
    for name in files:
        assert archive.read(name) == (root / name).read_bytes(), name
print(output)
