//PCB parameter
Shell_Thickness=1.5;
PCB_Length=87;
PCB_Width=63;
PCB_Thickness=0;
Core_PCB_Thickness=3;
Battery_Thickness=15;

Corner_Length=6;
Spiral_Hole_Radius=1.5;
Spiral_Hole_cap_Radius=2.5;
Spiral_Hole_cap_Height=2.0;

Cooling_layer_Thickness=3.0;

Cube_Length=PCB_Length;
Cube_Width=PCB_Width;
Cube_Height_bottom=Shell_Thickness+
            PCB_Thickness+
            Core_PCB_Thickness+
            Cooling_layer_Thickness;
Cube_Height_cover=Battery_Thickness+
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

//margin
margin_offset=0.5;
//resolution ratio
resolution=3;

module AllCubeBody(Cube_Length,Cube_Width,Cube_Height,Corner_Length){
    difference(){
    //all cube
    cube([Cube_Length,Cube_Width,Cube_Height]);
    Spiral_Hole(Cube_Height);
    ThermalVia(Cube_Height);
    DifCube(Cube_Length,Cube_Width,Cube_Height,Corner_Length,Shell_Thickness);
    }
}

module DifCube(Cube_Length,Cube_Width,Cube_Height,Corner_Length,Shell_Thickness){
    translate([Corner_Length,Shell_Thickness,Shell_Thickness])
    cube([Cube_Length-2*Corner_Length,Cube_Width-2*Shell_Thickness,Cube_Height-Shell_Thickness]);

    translate([Shell_Thickness,Corner_Length,Shell_Thickness])
    cube([Cube_Length-2*Shell_Thickness,Cube_Width-2*Corner_Length,Cube_Height-Shell_Thickness]);
}
module ThermalVia(Cube_Height){
    //drill Thermal Via
    for(z=[0:drill_num_x]){
    drill(drill_start_x,drill_start_x,drill_gap_x,drill_gap_y,z,drill_num_y,Cube_Height);
    }
}
module drill(move_x,move_y,gap_x,gap_y,number,num_y,Cube_Height){
    for(z=[0:num_y]){
    translate([move_x+number*gap_x,move_y+z*gap_y,0])
    cylinder(h=Cube_Height,r=drill_Radius,$fn=resolution);
    }
}
module drill_Spiral_Hole(pos_x,pos_y,Cube_Height){
            //resolution
            $fn=resolution;
            translate([pos_x,pos_y,Spiral_Hole_cap_Height])
            cylinder(h=Cube_Height-Spiral_Hole_cap_Height,r=Spiral_Hole_Radius);
}
module Spiral_Hole(Cube_Height){
    //drill origin
    drill_Spiral_Hole(Corner_Length/2,Corner_Length/2,Cube_Height);
    //drill left of top
    drill_Spiral_Hole(Corner_Length/2,Cube_Width-(Corner_Length/2),Cube_Height);
    //drill right of top
    drill_Spiral_Hole(Cube_Length-(Corner_Length/2),Cube_Width-(Corner_Length/2),Cube_Height);
    //drill right of bottom
    drill_Spiral_Hole(Cube_Length-(Corner_Length/2),Corner_Length/2,Cube_Height);
}
module drill_Spiral_Cap(pos_x,pos_y){
            translate([pos_x,pos_y,0])
            cylinder(h=Spiral_Hole_cap_Height,r=Spiral_Hole_cap_Radius);
}
module Spiral_Cap(){
    drill_Spiral_Cap(Corner_Length/2,Corner_Length/2);
    drill_Spiral_Cap(Corner_Length/2,Cube_Width-(Corner_Length/2));
    drill_Spiral_Cap(Cube_Length-(Corner_Length/2),Cube_Width-(Corner_Length/2));
    drill_Spiral_Cap(Cube_Length-(Corner_Length/2),Corner_Length/2);
}
module connector_drill(connector_pos_x,connector_pos_y,connector_length,connector_height){
    translate([connector_pos_x,connector_pos_y,Cube_Height_cover-connector_height])
    cube(connector_length,Shell_Thickness,connector_height);    
}
module led_drill(connector_pos_x,connector_pos_y,Radius){
    translate([connector_pos_x,connector_pos_y,Cube_Height_cover-Radius-1.5])
    rotate(a=[0,90,0])
    cylinder(r=Radius,h=Shell_Thickness+0.01,$fn=resolution);
}

module TopEdge(){
    MIC_X=21.82;
    MIC_Length=10.88+2;
    MIC_Height=2.54;
    Touch_X1=33.45;
    Touch_SH8A_Length=17.35;
    Touch_SH8A_Height=2.30;

    connector_drill(MIC_X,PCB_Width-Shell_Thickness,MIC_Length,MIC_Height);
    connector_drill(Touch_X1,PCB_Width-Shell_Thickness,Touch_SH8A_Length,Touch_SH8A_Height);
}
module BottomEdge(){
    Touch_X1=49.00;
    Touch_Y_Height=10.94;
    Touch_SH8A_Length=13.56;
    Touch_SH8A_Height=3.0;

    //connector_drill(Touch_X1,0,Touch_SH8A_Length,Touch_SH8A_Height+Touch_Y_Height);
    translate([Touch_X1,0,Cube_Height_cover-(Touch_SH8A_Height+Touch_Y_Height)])
    cube([Touch_SH8A_Length,Shell_Thickness,Touch_SH8A_Height]); 
}
module  LeftEdge(){
    TF_Y=47.75-margin_offset;
    TF_SH10A_Length=8.6+margin_offset*2;
    TF_SH10A_Height=2.54;
    
    Micro_USB_Y=6.80-margin_offset;
    Micro_USB_Length=7.5+margin_offset*1.5;
    Micro_USB_Height=3;
    
    Touch_X1=6.09;
    Touch_Y_Height=10.94;
    Touch_SH8A_Length=13.56;
    Touch_SH8A_Height=3.0;

    //connector_drill(Touch_X1,0,Touch_SH8A_Length,Touch_SH8A_Height+Touch_Y_Height);
    translate([Touch_X1,Cube_Width-Shell_Thickness,Cube_Height_cover-(Touch_SH8A_Height+Touch_Y_Height)])
    cube([Touch_SH8A_Length,Shell_Thickness,Touch_SH8A_Height]); 
    
    connector_drill(0,TF_Y,TF_SH10A_Length,TF_SH10A_Height);
    connector_drill(0,Micro_USB_Y,Micro_USB_Length,Micro_USB_Height);
}
module BoxBottom(Cube_Length,Cube_Width,Cube_Height){
difference(){
    AllCubeBody(Cube_Length,Cube_Width,Cube_Height,Corner_Length);
    Spiral_Cap();
}
}
module DifThick(Cube_Height){
    //Right
    translate([Cube_Length-Shell_Thickness,Corner_Length,Shell_Thickness])
    cube([0.7,Cube_Width-2*Corner_Length,Cube_Height-Shell_Thickness]);
    //Bottom
    translate([Corner_Length,Shell_Thickness-0.3,Shell_Thickness])
    cube([Cube_Length-2*Corner_Length,0.3,Cube_Height-Shell_Thickness]);
}
module BoxCover(Cube_Length,Cube_Width,Cube_Height){
difference(){
    AllCubeBody(Cube_Length,Cube_Width,Cube_Height,Corner_Length);
    TopEdge();
    //BottomEdge();
    LeftEdge();
    DifThick(Cube_Height);
}
}

translate([0,-Cube_Width-10,0])
BoxBottom(Cube_Length,Cube_Width,Cube_Height_bottom);
BoxCover(Cube_Length,Cube_Width,Cube_Height_cover);