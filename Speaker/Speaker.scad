 radius_bottom = 12.5;
 radius_top = 15;
 radius = 12.5;
 length = 25;
 width = 10;
 height = 10+2;
 thickness =2;
 
 resolution=250;

//translate([length,10,height])
// difference() {
// cylinder(h=height, r1=radius_bottom, r2=radius_top, center=false);
// translate([-radius_top,0,0])
// cube([radius_top*2,radius_top*2,height]);
// cylinder(h=height, r1=radius_bottom-2, r2=radius_top-2, center=false);
// }

//translate([0,40,0])

 
 //translate([0,radius_bottom/2+10,0])
 //rotate([0,0,45])
 //cylinder(h=height,r1=radius_bottom*1.414,r2=radius_top*1.414,$fn=4);
 $fn=resolution;
 
 difference() {
 cylinder(h=height,r=radius);
 translate([0,0,thickness])
 cylinder(h=height-thickness, r=radius-thickness); 
 translate([-radius,0,thickness])
 cube([radius*2,radius*2,height]);
 }
 
 difference() {
 translate([-length/2,0,0])
 cube([length,width,height]);
     
 //translate([-length/2,0,thickness])
 //cube([length,width,height-thickness]);
     
 translate([-(length-thickness*2)/2,0,thickness])
 cube([length-thickness*2,width,height-thickness]);
 }
 
 translate([0,width,0])
 rotate([0,0,180])
 difference() {
 cylinder(h=height,r=radius);
 translate([0,0,thickness])
 cylinder(h=height-thickness, r=radius-thickness); 
 translate([-radius,0,thickness])
 cube([radius*2,radius*2,height]);
 }
 

 
