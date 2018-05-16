//PCB parameter
Shell_Thickness=1.5;
PCB_Length=72.5;
PCB_Width=56;
PCB_Thickness=0;
Core_PCB_Thickness=3;
Battery_Thickness=10;

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
resolution=30;

module AllCubeBody(Cube_Length,Cube_Width,Cube_Height,Corner_Length){
    difference(){
    //all cube
    cube([Cube_Length,Cube_Width,Cube_Height]);
    //drill origin
    drill_Spiral_Hole(Corner_Length/2,Corner_Length/2,0,Cube_Height);
    //drill left of top
    drill_Spiral_Hole(Corner_Length/2,Cube_Width-(Corner_Length/2),0,Cube_Height);
    //drill right of top
    drill_Spiral_Hole(Cube_Length-(Corner_Length/2),Cube_Width-(Corner_Length/2),0,Cube_Height);
    //drill right of bottom
    drill_Spiral_Hole(Cube_Length-(Corner_Length/2),Corner_Length/2,0,Cube_Height);
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
module drill(move_x,move_y,gap_x,gap_y,number,num_y,Cube_Height)
{
    for(z=[0:num_y]){
    translate([move_x+number*gap_x,move_y+z*gap_y,0])
    cylinder(h=Cube_Height,r=drill_Radius,$fn=resolution);
    }
}
module drill_Spiral_Hole(pos_x,pos_y,pos_z,Cube_Height){
            //resolution
            $fn=resolution;
            translate([pos_x,pos_y,pos_z])
            cylinder(h=Cube_Height,r=Spiral_Hole_Radius);
            translate([pos_x,pos_y,pos_z])
            cylinder(h=Spiral_Hole_cap_Height,r=Spiral_Hole_cap_Radius);
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
module BottomEdge(){
    BAT_X=21.24-margin_offset;
    BAT_Length=5+margin_offset*2;BAT_Height=4.8;
    CSI_X1=28.03-margin_offset;CSI_X2=44.39-margin_offset;
    Camera_SH12A_Length=14+margin_offset*2;Camera_SH12A_Height=3.05;
    // IXP_Length=4.4;IXP_Height=2;

    connector_drill(BAT_X,0,BAT_Length,BAT_Height);
    connector_drill(CSI_X1,0,Camera_SH12A_Length,Camera_SH12A_Height);
    connector_drill(CSI_X2,0,Camera_SH12A_Length,Camera_SH12A_Height);
}
module TopEdge(){
    Phone_X=16.41-margin_offset;
    Phone_Length=4+margin_offset*2;Phone_Height=3.05;
    MIC_X=23.01-margin_offset;
    MIC_Length=4+margin_offset*2;MIC_Height=3.05;
    Touch_X1=29.81-margin_offset;Touch_X2=42.36-margin_offset;
    Touch_SH8A_Length=10+margin_offset*2;Touch_SH8A_Height=3.05;
    Touch_X3=55.02-margin_offset;
    Touch_SH6A_Length=8+margin_offset*2;Touch_SH6A_Height=3.05;

    connector_drill(Phone_X,PCB_Width-Shell_Thickness,Phone_Length,Phone_Height); 
    connector_drill(MIC_X,PCB_Width-Shell_Thickness,MIC_Length,MIC_Height);
    connector_drill(Touch_X1,PCB_Width-Shell_Thickness,Touch_SH8A_Length,Touch_SH8A_Height);
    connector_drill(Touch_X2,PCB_Width-Shell_Thickness,Touch_SH8A_Length,Touch_SH8A_Height);
    connector_drill(Touch_X3,PCB_Width-Shell_Thickness,Touch_SH6A_Length,Touch_SH6A_Height);
}
module  LeftEdge(){
    TF_Y=6.69-margin_offset;
    TF_SH10A_Length=12+margin_offset*2;TF_SH10A_Height=3.05;
    Power_Y=20.26;
    Power_Length=8;Power_Height=7.0;
    LED_Y1=32.26;
    LED_Y2=38.2;LED_Radius=1.75;
    // LED_Y1=29.97;LED_Y2=35.94;
    // LED_Length=6;LED_Height=6;
    Micro_USB_Y=42.21-margin_offset;
    Micro_USB_Length=7.5+margin_offset*1.5;Micro_USB_Height=3;
    
    connector_drill(0,TF_Y,TF_SH10A_Length,TF_SH10A_Height);
    connector_drill(0,Power_Y,Power_Length,Power_Height);
    led_drill(0,LED_Y1,LED_Radius);
    led_drill(0,LED_Y2,LED_Radius);
    // connector_drill(0,LED_Y1,LED_Length,LED_Height);
    // connector_drill(0,LED_Y2,LED_Length,LED_Height);
    connector_drill(0,Micro_USB_Y,Micro_USB_Length,Micro_USB_Height);
}
module BoxBottom(Cube_Length,Cube_Width,Cube_Height){
difference(){
    AllCubeBody(Cube_Length,Cube_Width,Cube_Height,Corner_Length);
    ThermalVia(Cube_Height);
    DifCube(Cube_Length,Cube_Width,Cube_Height,Corner_Length,Shell_Thickness);
}
}
module BoxCover(Cube_Length,Cube_Width,Cube_Height){
difference(){
    BoxBottom(Cube_Length,Cube_Width,Cube_Height);
    BottomEdge();
    TopEdge();
    LeftEdge();
}
}

translate([0,-Cube_Width-10,0])
BoxBottom(Cube_Length,Cube_Width,Cube_Height_bottom);
BoxCover(Cube_Length,Cube_Width,Cube_Height_cover);