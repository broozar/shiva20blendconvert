bl_info = {
    "name": "Blender To ShiVa",
    "description": "Set mesh objects for import using BlendSuite in ShiVa 2.",
    "author": "http://shotiris.net",
    "version": (0, 9),
    "blender": (2, 65, 0),
    "location": "View3d > Tools",
    "warning": "Emmanuel woz ere",
    "tracker_url": "http://shotiris.net",
    "support": "COMMUNITY",
    "category": "Object"
}

import bpy

class ShivaPanel(bpy.types.Panel) :
    bl_space_type = "VIEW_3D"
    bl_region_type = "TOOLS"
    bl_context = "objectmode"
    bl_label = "ShiVa Model"
    
    def draw(self, context) :
        layout = self.layout
        scene = context.scene
        column = self.layout.column(align = True)
        column.operator("mesh.set_shiva", text = "Set For ShiVa")
        column.operator("mesh.unset_shiva", text = "Unset For ShiVa")
        

class SetShiVa(bpy.types.Operator) :
    bl_idname = "mesh.set_shiva"
    bl_label = "Set For ShiVa"
    bl_options = {"UNDO"}

    def invoke(self, context, event) :
        print ("Set property successfully.")
        obj = bpy.context.scene.objects.active
        #add property
        if (obj.type == "MESH") :
            bpy.types.Object.shivaModel = bpy.props.BoolProperty()
            obj.shivaModel = True
        else :
            print ("Unable to set shiva obj type: " + obj.type )
            
        return {"FINISHED"}
    
class UnsetShiVa(bpy.types.Operator) :
    bl_idname = "mesh.unset_shiva"
    bl_label = "Unset For ShiVa"
    bl_options = {"UNDO"}

    def invoke(self, context, event) :
        print ("Successfully removed property.")
        #remove property
        obj = bpy.context.scene.objects.active
        if (obj.type == "MESH") :
            if ("shivaModel" in obj) :
                del obj["shivaModel"]
                
        return {"FINISHED"}

def register() :
    bpy.utils.register_class(UnsetShiVa)
    bpy.utils.register_class(SetShiVa)
    bpy.utils.register_class(ShivaPanel)

def unregister() :
    bpy.utils.unregister_class(UnsetShiVa)
    bpy.utils.unregister_class(SetShiVa)
    bpy.utils.unregister_class(ShivaPanel)

if __name__ == "__main__" :
    register()