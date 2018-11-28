import bpy  
import os
import subprocess
import sys


bExportAnims = False
bPackAnims = False
sExportDirectory = 0
nExportAnims = 0

nFBXTexture = 0
nFBXGlobal = 0

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
        
        #anim handling
        if (argv[1] != None):
            if (argv[1] != ""):
                nExportAnims = argv[1]
                print ("found nExportAnims export arg: " + argv[1])

        #texture handling
        if (argv[2] != None):
            if (argv[2] != ""):
                nFBXTexture = argv[2]
				
        #space baking
        if (argv[3] != None):
            if (argv[3] != ""):
                nFBXGlobal = argv[3]
				
    else :
        print ("")
        print ("no arguments found after --")
else :
    print ("no arguments at all!" )

# just an emtpy line
print (" ")


# -----------------------------------
# animation switch - for the future

#anim handling - only 0 and 2 are valid ATM
nExportAnims = int(nExportAnims)
if (nExportAnims == 0) :
    bExportAnims = False
    bPackAnims = False
    print ("No animation processing.")
elif (nExportAnims == 1) :
    bExportAnims = True
    bPackAnims = False
    print ("Exporting all animations.")
elif (nExportAnims == 2) :
    bExportAnims = False
    bPackAnims = True
    print ("Pack animations to FBX.")


# -----------------------------------
# export directory

sBlendFilePath = bpy.data.filepath
sBlendDirectory = os.path.dirname(sBlendFilePath)

sBlendFileName = bpy.path.basename(bpy.context.blend_data.filepath)
sStripBlendFileName = sBlendFileName[:-6]

sFBXFilePath = ""
# sAnimFilePath = ""

print ("Requested export directory is: " + sExportDirectory)
sExportDirectory = sExportDirectory.replace('"', '')
sExportDirectory = sExportDirectory.replace("'", '')
sFBXFullPath = sExportDirectory + sStripBlendFileName + ".fbx"
# sAnimFilePath = sExportDirectory + sCustomPrefix + sStripBlendFileName + sCustomSuffix

print("FBX exporting to: " + sFBXFullPath )


# -----------------------------------
# FBX export

bCheckExisting=False
sFilePath=sExportDirectory
sFilterGlob="*.fbx"
sVersion="ASCII6100"
bUseSelection=True
nGlobalScale=1.0
sAxisForward="-Z"
sAxisUp="Y"
bBakeSpace= (nFBXGlobal == True)
eObjectTypes={"MESH","ARMATURE"}
bUseMeshModifiers=True
sMeshSmoothType="OFF"
bUseMeshEdges=False
bUseTSpace=True
bUseCustomProps=False
bDeformOnly=True
bBakeAnim=True
bUseNLA=False
bUseAllActions=False
nAnimStep=1.0
nAnimSimplifyFactor=1.0
bUseAnimAllAction=False
bUseAnim=False
bUseDefaultTake=True
bUseAnimOptimize=True
nAnimOptimizePrecision=6.0
sPathMode="AUTO"
bEmbedTextures= (nFBXTexture == True)
sBatchMode="OFF"
bBatchOwnDir=True
bUseMeta=True

# get each tagged object
scene = bpy.context.scene
sObjectName = ""
oSelect = None
allObjects = scene.objects

# this will eventually work to export all shivaModel objects separately
for obj in allObjects:
    if ("shivaModel" in obj) :
        print ("Found object set for ShiVa.")
        sObjectName = obj.name
        obj.select = True
        bpy.context.scene.objects.active = obj
        oSelect = obj
        break
    else :
        obj.select = False #deselect everything else
        
# pack anims
if (bPackAnims) :
    bUseAnim=True
    bUseAnimAllAction = True

# export initial model (pack anims bUseAnims if selected)
if (oSelect != None) : 
    
    bpy.ops.export_scene.fbx(check_existing=bCheckExisting, filepath=sFBXFullPath, filter_glob=sFilterGlob, version=sVersion, use_selection=bUseSelection, global_scale=nGlobalScale, axis_forward=sAxisForward, axis_up=sAxisUp, bake_space_transform=bBakeSpace, object_types=eObjectTypes, use_mesh_modifiers=bUseMeshModifiers, mesh_smooth_type=sMeshSmoothType, use_mesh_edges=bUseMeshEdges, use_tspace=bUseTSpace, use_custom_props=bUseCustomProps, use_armature_deform_only=bDeformOnly, bake_anim=bBakeAnim, bake_anim_use_nla_strips=bUseNLA, bake_anim_use_all_actions=bUseAllActions, bake_anim_step=nAnimStep, bake_anim_simplify_factor=nAnimSimplifyFactor, use_anim=bUseAnim, use_anim_action_all=bUseAnimAllAction, use_default_take=bUseDefaultTake, use_anim_optimize=bUseAnimOptimize, anim_optimize_precision=nAnimOptimizePrecision, path_mode=sPathMode, embed_textures=bEmbedTextures, batch_mode=sBatchMode, use_batch_own_dir=bBatchOwnDir, use_metadata=bUseMeta)
else :
    print ("Did not find object set for ShiVa.")
    