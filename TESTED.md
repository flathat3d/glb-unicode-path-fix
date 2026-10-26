# Verification — 2.0.0

Test date: 2026-10-26. Tests used isolated, normal GUI instances of Max and a sphere with glTFMaterial + Bitmaptexture. Original user scenes and source assets were not modified.

| Check | Max 2023, 25.0.0.997 | Max 2025.3, 27.3.0.30874 |
|---|---|---|
| Native exporter with Chinese Export directory reproduces black fallback, no images or TEXCOORD_0 | Reproduced | Reproduced |
| MZP installation and repeated installation | Passed | Passed |
| Original GLTF_Export after path correction, Chinese destination filename | Passed | Passed |
| Embedded JPEG, baseColorTexture, TEXCOORD_0 | Present | Present |
| Output file size for test fixture | 5,654,148 bytes | 5,654,184 bytes |
| Switch to a Chinese project directory | Export path remains ASCII | Export path remains ASCII |
| Restore original project | Passed | Passed |
| Remove startup correction and reinstall | Passed | Passed |

The final Max 2025 native export was independently imported and rendered in Blender 4.5.0: one mesh, 559 vertices, one UV layer and the embedded 3277×4096 image rendered visibly. An earlier Max 2023 native-export test was also rendered successfully. Images and user-provided source files are not distributed in this package.

The first 2025 render used an inappropriate fixed camera near plane for the scene's millimeter units; a scale-aware camera corrected that test setup. The exported GLB itself was not changed. This was separate from the original missing-material defect.

Native export was invoked through Max's original `GLTF_Export` class with the normal export pipeline; the tests did not automate clicking through every File menu dialog. MZP execution was verified through `fileIn`; drag/drop metadata is included, but an actual drag/drop gesture was not automated. The startup loader was executed and verified in running test sessions; a full restart of the user's working Max was not performed.

Other Max releases are not individually verified. Feature detection enables use where the native exporter and required APIs exist. Broad material conversion support, every Unicode image/material name, and arbitrary third-party exporters are not covered by these tests.
