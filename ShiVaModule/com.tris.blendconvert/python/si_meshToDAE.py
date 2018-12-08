import bpy  
import os
import subprocess
import sys

sExportDirectory = 0

# -----------------------------------
# tools

def dequote (sIn):
	sIn.replace('"', '')
	sIn.replace("'", "")
	return sIn

# -----------------------------------
# arg handling
	
argv = sys.argv

if (argv != None) :
    if ("--" in argv) :
        argv = argv[argv.index("--") + 1:]  # get all args after "--"
        
        #export directory
        if (argv[0] != None):
            if (argv[0] != ""):
                sExportDirectory = argv[0]
                print ("found fbx export arg: " + argv[0])
    else :
        print ("")
        print ("no arguments found")
else :
    print ("no arguments at all!" )

# just an emtpy line
print (" ")


# -----------------------------------
# file name synthesis

#custom filename prefix
sCustomPrefix = ""
#custom filename suffix
sCustomSuffix = ""

sBlendFilePath = bpy.data.filepath
sBlendDirectory = os.path.dirname(sBlendFilePath)

sBlendFileName = bpy.path.basename(bpy.context.blend_data.filepath)
sStripBlendFileName = sBlendFileName[:-6]

sDAEFilePath = ""

#export directory
if (sExportDirectory == "0" or sExportDirectory == 0) :
    print ("Export directory is same as blend file.")
    sExportDirectory = sBlendDirectory
    sDAEFilePath = sExportDirectory + "/" + sCustomPrefix + sStripBlendFileName + sCustomSuffix + ".dae"
else :
    print ("Requested export directory is: " + sExportDirectory)
    sExportDirectory = dequote(sExportDirectory)
    sDAEFilePath = sExportDirectory + sCustomPrefix + sStripBlendFileName + sCustomSuffix + ".dae"

print ("DAE exporting to: " + sDAEFilePath)


# -----------------------------------
# DAE export

##DAE EXPORT ARGUMENTS
sFilepath=sDAEFilePath
bCheckExisting=True
nFilemode=8
sDisplayType='DEFAULT'
sSortMethod='FILE_SORT_ALPHA'
bApplyModifiers=False
nExportMeshType=0
sExportMeshTypeSelection='view'
bSelected=True
bIncludeChildren=False
bIncludeArmatures=True
bIncludeShapekeys=False
bDeformBonesOnly=False
bActiveUvOnly=False
bUseTextureCopies=True
bTriangulate=True
bUseObjectInstantiation=False
bUseBlenderProfile=False
bSortByName=False
nExportTransformationType=0
sExportTransformationTypeSelection='matrix'
bOpenSim=False

#get each tagged object
scene = bpy.context.scene
sObjectName = ""
oSelect = None
allObjects = scene.objects
for obj in allObjects:
    if ("shivaModel" in obj) :
        print ("Found object set for ShiVa.")
        sObjectName = obj.name
        obj.select = True
        bpy.context.scene.objects.active = obj
        oSelect = obj
        break
    else :
        obj.select = False
    

if (oSelect != None) : 
    bpy.ops.wm.collada_export(filepath=sFilepath, check_existing=bCheckExisting, filemode=nFilemode, display_type=sDisplayType, sort_method=sSortMethod, apply_modifiers=bApplyModifiers, export_mesh_type=nExportMeshType, export_mesh_type_selection=sExportMeshTypeSelection, selected=bSelected, include_children=bIncludeChildren, include_armatures=bIncludeArmatures, include_shapekeys=bIncludeShapekeys, deform_bones_only=bDeformBonesOnly, active_uv_only=bActiveUvOnly, use_texture_copies=bUseTextureCopies, triangulate=bTriangulate, use_object_instantiation=bUseObjectInstantiation, use_blender_profile=bUseBlenderProfile, sort_by_name=bSortByName, export_transformation_type=nExportTransformationType, export_transformation_type_selection=sExportTransformationTypeSelection, open_sim=bOpenSim)
    print ("Exported DAE.")
else :
    print ("Did not find object set for ShiVa.")

