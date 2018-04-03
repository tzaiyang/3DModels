//PCB parameter
Shell_Thickness=1.5;
PCB_Length=73;
PCB_Width=58;
PCB_Thickness=0;
Battery_Thickness=10;
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
//resolution ratio
resolution=25;

difference(){
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
        translate([Shell_Thickness,Shell_Thickness,Shell_Thickness])
        corner();
        //corner 2
        translate([Cube_Length-Corner_Length-Shell_Thickness,Shell_Thickness,Shell_Thickness])
        corner();
        //corner 3
        translate([Cube_Length-Corner_Length-Shell_Thickness,Cube_Width-Corner_Length-Shell_Thickness,Shell_Thickness])
        corner();
        //corner 4
        translate([Shell_Thickness,Cube_Width-Corner_Length-Shell_Thickness,Shell_Thickness])
        corner();
    };
    //length>height
    //connector_drill(12,0,length,height);
    //length<height
    //connector_drill(15,0,height,length);
    Camera_SH12A_Length=14;
    Camera_SH12A_Height=3.05;
    IXP_Length=4.4;
    IXP_Height=2;
    Touch_SH8A_Length=10;
    Touch_SH8A_Height=3.05;
    Touch_SH6A_Length=8;
    Touch_SH6A_Height=3.05;
    MIC_Length=4;
    MIC_Height=3.05;
    Phone_Length=4;
    Phone_Height=3.05;
    Micro_USB_Length=7.6;
    Micro_USB_Height=3;
    LED_Radius=1.5;
    Power_Length=8.1;
    Power_Height=6;
    TF_SH10A_Length=12;
    TF_SH10A_Height=3.05;
    
    connector_drill(24.25+Shell_Thickness+Corner_Length/2,0,Camera_SH12A_Length,Camera_SH12A_Height);
    connector_drill(40.25+Shell_Thickness+Corner_Length/2,0,Camera_SH12A_Length,Camera_SH12A_Height);
    connector_drill(58.75+Shell_Thickness+Corner_Length/2,0,IXP_Length,IXP_Height);
    
    connector_drill(60.8+Shell_Thickness+Corner_Length/2-Touch_SH6A_Length,58,Touch_SH6A_Length,Touch_SH6A_Height);
    connector_drill(50.1+Shell_Thickness+Corner_Length/2-Touch_SH8A_Length,58,Touch_SH8A_Length,Touch_SH8A_Height);
    connector_drill(37.5+Shell_Thickness+Corner_Length/2-Touch_SH8A_Length,58,Touch_SH8A_Length,Touch_SH8A_Height);
    
    connector_drill(24.8+Shell_Thickness+Corner_Length/2-MIC_Length,58,MIC_Length,MIC_Height);
    connector_drill(18.1+Shell_Thickness+Corner_Length/2-Phone_Length,58,Phone_Length,Phone_Height); 
    
    connector_drill(0,46.9+Shell_Thickness+Corner_Length/2-Micro_USB_Length,Micro_USB_Length,Micro_USB_Height);
    led_drill(0,38.4+Shell_Thickness+Corner_Length/2-LED_Radius*2,LED_Radius);
    led_drill(0,32.4+Shell_Thickness+Corner_Length/2-LED_Radius*2,LED_Radius);
    connector_drill(0,25.4+Shell_Thickness+Corner_Length/2-Power_Length,Power_Length,Power_Height);
    connector_drill(0,16.5+Shell_Thickness+Corner_Length/2-TF_SH10A_Length,TF_SH10A_Length,TF_SH10A_Height);
}

module corner(){
difference(){
        cube([Corner_Length,Corner_Length,Cube_Height-Shell_Thickness-PCB_Thickness]);
        translate([Corner_Length/2,Corner_Length/2,0])
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
            $fn=resolution;
            translate([pos_x,pos_y,pos_z])
            cylinder(h=Cube_Height,r=Spiral_Hole_Radius);
            translate([pos_x,pos_y,pos_z])
            cylinder(h=Spiral_Hole_cap_Height,r=Spiral_Hole_cap_Radius);
}
module connector_drill(connector_pos_x,connector_pos_y,connector_length,connector_height){
    translate([connector_pos_x,connector_pos_y,Cube_Height-connector_height])
    cube(connector_length,Shell_Thickness,connector_height);    
}

module led_drill(connector_pos_x,connector_pos_y,Radius){
    translate([connector_pos_x,connector_pos_y,Cube_Height-Radius])
    rotate(a=[0,90,0])
    cylinder(r=Radius,h=Shell_Thickness+0.01,$fn=resolution);
}