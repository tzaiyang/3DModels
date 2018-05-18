 radius_bottom = 12.5;
 radius_top = 15;
 radius = 12.5;
 length = 25;
 height = 10+2;
 thickness =2;
 
 //resolution=256;

 //$fn=resolution;
 
module body(x,y,z)
{ 
$fn=120;
color([.8,.7,.7])
translate([0,0,0])
resize(newsize=[x,y,z])
sphere(1);
}
module difcube(x,y,z,width)
{
color([.8,.7,.7])
//-y
translate([-x/2,-y/2,0])
cube([x,y/2-width,z/2]);
    
//+y
translate([-x/2,width,0])
cube([x,y/2-width,z/2]);

//-z
translate([-x/2,-y/2,-z/2])
cube([x,y,z/2]);
}

module arc(x,y,z)
{
color([.8,.7,.7])
difference() {
body(x,y,z);
difcube(x,y,z,width);
}
}

module base(x,y,z,k)
{
difference(){
arc(x,y,z);
translate([k,0,0])
arc(x/2,y,z/1.6);
}
}

module base1(x,y,z,k)
{
difference(){
arc(x-thicks,y,z-thicks);
translate([k,0,0])
arc((x-thicks)/2+1.5*thicks,y,(z-thicks)/1.6+1.5*thicks);
};
}

x=80;
y=1000;
z=208;
k=14.6;

width = 15;
thicks = 2;
difference(){
    
color([.8,.7,.7])
base(x,y,z,k);
    
translate([0,-thicks,0])
base1(x,y,z,k);

translate([0,width*2-thicks/2,0])
base1(x,y,z,k);

rotate([0,-8,0])
translate([-50,-width,0])
cube([50,2*width,6]);

translate([-31,0,68])
rotate([108,0,90])
speaker();  

}




module speaker()
{
 radius_bottom = 12.5;
 radius_top = 15;
 radius = 12.5;
 length = 25;
 width = 10;
 height = 10+2;
 thickness =2;
 
 resolution=250;
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
 translate([0,0,thickness+10])
 cylinder(h=height-thickness, r=radius-thickness); 
 translate([-radius,0,thickness+10])
 cube([radius*2,radius*2,height]);
 }
 
} 
