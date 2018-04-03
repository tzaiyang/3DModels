//PCB parameter
Shell_Thickness=1.5;
PCB_Length=73;
PCB_Width=58;
PCB_Thickness=1.5;
Battery_Thickness=0;
Spiral_Hole_Radius=1.5;
Spiral_Hole_cap_Radius=2;
Spiral_Hole_cap_Height=1.5;
Corner_Length=5;
Cube_Length=PCB_Length+Shell_Thickness*2;
Cube_Width=PCB_Width+Shell_Thickness*2;
Cube_Height=Battery_Thickness+Shell_Thickness+6;

//Thermal Via parameter
drill_start_x=10;
drill_start_y=10;
drill_num_x=11;
drill_num_y=8;
drill_Radius=1;
drill_gap_x=(Cube_Length-2*drill_start_x)/drill_num_x;
drill_gap_y=(Cube_Width-2*drill_start_y)/drill_num_y;

resolution=25;

union(){
    //cover
    difference(){
        //all cube
        difference(){
            //all cube
            cube([Cube_Length,Cube_Width,Cube_Height]);
            //drill origin
            drill_Spiral_Hole(Corner_Length/2+Shell_Thickness,Corner_Length/2+Shell_Thickness,0);
            //drill left of top
            drill_Spiral_Hole(Corner_Length/2+Shell_Thickness,Cube_Width-(Corner_Length/2+Shell_Thickness),0);
            //drill right of top
            drill_Spiral_Hole(Cube_Length-(Corner_Length/2+Shell_Thickness),Cube_Width-(Corner_Length/2+Shell_Thickness),0);
            //drill right
            drill_Spiral_Hole(Cube_Length-(Corner_Length/2+Shell_Thickness),Corner_Length/2+Shell_Thickness,0);
            
            //drill Thermal Via
            for(z=[0:drill_num_x]){
            drill(drill_start_x,drill_start_x,drill_gap_x,drill_gap_y,z,drill_num_y);
            }
        };
        //inside cube
        translate([Shell_Thickness,Shell_Thickness,Shell_Thickness])
        cube([Cube_Length-2*Shell_Thickness,Cube_Width-2*Shell_Thickness,Cube_Height-Shell_Thickness]);
    };
    
    //corner 1
    corner(Shell_Thickness,Shell_Thickness,Shell_Thickness);
    //corner 2
    corner(Cube_Length-Corner_Length-Shell_Thickness,Shell_Thickness,Shell_Thickness);
    //corner 3
    corner(Cube_Length-Corner_Length-Shell_Thickness,Cube_Width-Corner_Length-Shell_Thickness,Shell_Thickness);
    //corner 4
    corner(Shell_Thickness,Cube_Width-Corner_Length-Shell_Thickness,Shell_Thickness);
    
}

module corner(pos_x,pos_y,pos_z){
    translate([pos_x,pos_y,pos_z])
    difference(){
            cube([Corner_Length,Corner_Length,Cube_Height-Shell_Thickness-PCB_Thickness]);
            translate([Corner_Length/2,Corner_Length/2,0])
            //resolution
            cylinder(h=Cube_Height-Shell_Thickness-PCB_Thickness,r=Spiral_Hole_Radius,$fn=resolution);
        }
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
