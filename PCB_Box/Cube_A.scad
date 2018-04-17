//PCB parameter
Shell_Thickness=1.0;
PCB_Length=72.5;
PCB_Width=56;
PCB_Thickness=0;
Core_PCB_Thickness=3;
Cube_A_Edge_Shell_Thickness=1.0;
Cube_A_Edge_Shell_Height=Core_PCB_Thickness;
Battery_Thickness=0;

Corner_Length=6;
Spiral_Hole_Radius=1.5;
Spiral_Hole_cap_Radius=2.5;
Spiral_Hole_cap_Height=2.0;

Cooling_layer_Thickness=3.0;

Cube_Length=PCB_Length;
Cube_Width=PCB_Width;
Cube_Height=Battery_Thickness+
            Shell_Thickness+
            PCB_Thickness+
            Core_PCB_Thickness+
            Cooling_layer_Thickness;

//Thermal Via parameter
drill_start_x=10;
drill_start_y=10;
drill_num_x=11;
drill_num_y=8;
drill_Radius=1;
drill_gap_x=(Cube_Length-2*drill_start_x)/drill_num_x;
drill_gap_y=(Cube_Width-2*drill_start_y)/drill_num_y;

//resolution ratio
resolution=30;

//cover
difference(){
    //all cube
    cube([Cube_Length,Cube_Width,Cube_Height]);
    //drill origin
    drill_Spiral_Hole(Corner_Length/2,Corner_Length/2,0);
    //drill left of top
    drill_Spiral_Hole(Corner_Length/2,Cube_Width-(Corner_Length/2),0);
    //drill right of top
    drill_Spiral_Hole(Cube_Length-(Corner_Length/2),Cube_Width-(Corner_Length/2),0);
    //drill right
    drill_Spiral_Hole(Cube_Length-(Corner_Length/2),Corner_Length/2,0);
    
    //drill Thermal Via
    for(z=[0:drill_num_x]){
    drill(drill_start_x,drill_start_x,drill_gap_x,drill_gap_y,z,drill_num_y);
    }

    //inside cube
    translate([Corner_Length,Shell_Thickness,Shell_Thickness])
    cube([Cube_Length-2*Corner_Length,Cube_Width-2*Shell_Thickness,Cube_Height-Shell_Thickness]);

    translate([Shell_Thickness,Corner_Length,Shell_Thickness])
    cube([Cube_Length-2*Shell_Thickness,Cube_Width-2*Corner_Length,Cube_Height-Shell_Thickness]);

/*    translate([Cube_A_Edge_Shell_Thickness,Corner_Length,Cube_Height-Cube_A_Edge_Shell_Height])
    cube([Cube_Length-2*Cube_A_Edge_Shell_Thickness,Cube_Width-2*(Corner_Length),Cube_Height-Shell_Thickness]); */
}

module drill(move_x,move_y,gap_x,gap_y,number,num_y)
{
    for(z=[0:num_y]){
    translate([move_x+number*gap_x,move_y+z*gap_y,0])cylinder(h=Cube_Height,r=drill_Radius,$fn=resolution);
    }
}

module drill_Spiral_Hole(pos_x,pos_y,pos_z){
            //resolution
            $fn=resolution;
            translate([pos_x,pos_y,pos_z])
            cylinder(h=Cube_Height,r=Spiral_Hole_Radius);
            translate([pos_x,pos_y,pos_z])
            cylinder(h=Spiral_Hole_cap_Height,r=Spiral_Hole_cap_Radius);
}
