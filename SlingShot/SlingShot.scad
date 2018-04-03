Hand_Length=70;
Radius=5;
Shot_Tree_Angle=20;
Shot_Tree_Length=90;
Shot_Set_Height=5;
Shot_Set_Thickness=1.5;

//Right
rotate([0,Shot_Tree_Angle,0])
Shot_Tree();
//Left
rotate([0,-Shot_Tree_Angle,0])
Shot_Tree();
//Hand
translate([0,0,-Hand_Length])
cylinder(h=Hand_Length,r=Radius);
//resolution ratio
resolution=100;
$fn=resolution;
module Shot_Tree(){
    difference(){
        cylinder(h=Shot_Tree_Length,r=Radius);
        difference(){
            translate([0,0,Shot_Tree_Length-2*Shot_Set_Height])
            cylinder(h=Shot_Set_Height,r=Radius);
                
            translate([0,0,Shot_Tree_Length-2*Shot_Set_Height])
            cylinder(h=Shot_Set_Height,r=Radius-Shot_Set_Thickness);
        }
    }  
}