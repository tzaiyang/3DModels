 radius_bottom = 12.5;
 radius_top = 15;
 radius = 12.5;
 length = 25;
 width = 10;
 height = 10+2;
 thickness =2;
 
 //resolution=256;

 //$fn=resolution;
 
 difference() {

 rotate([-90,0,0])
 cylinder(h=height,r=radius);
     
 translate([0,0,0])
 cylinder(h=height, r=radius-thickness); 
     
 translate([-radius,0,0])
 cube([radius*2,radius*2,height]);
     
 translate([-2*radius,-radius,0])
 cube([radius*2,radius*2,height]);
 }
 
 $fn=10;
module bag_bar(rr1,rr2,d)
{
rotate_extrude()
difference()
{

hull() //hull() fast in 2D, no good in 3D
{
circle(rr1);
translate([0,d])circle(rr2);

}
translate([-50,0,0])square(100,center=true);
} 
}
module body()
{ $fn=120;
color("white")
bag_bar(18,12.5,17);
color([.8,.7,.7])
translate([0,14,9])
rotate([25,0,0])
resize(newsize=[14,5.5,19])
sphere(1);
color([.8,.7,.7])
translate([0,-14,9])
rotate([-25,0,0])
resize(newsize=[14,5.5,19])
sphere(1);
}
module eye()
{$fn=30;
scale([.28,.28,.28])
color("black")
rotate([0,90,0])
union()
{ 
translate([0,10,0])cylinder(r=3.8,h=10,center=true);
translate([0,-10,0])cylinder(r=3.8,h=10,center=true);
cube([1.8,20,10],center=true);
}
}
module head()
{ $fn=80;
difference()
{
color("white")
resize(newsize=[14,14,10])
color("white")sphere(8);
translate([6,0,0])color("black")eye();
}
}
module leg()
{ 
$fn=50;
scale([.4,.4,.38])
{
color("white")bag_bar(13.5,17,15);
color([.8,.7,.7])
translate([0,0,-4])
resize(newsize=[26,25,26])
sphere(1);
color([.8,.7,.7])
resize(newsize=[25,14,28])
translate([0,19.8,14])sphere(13);
}
}
module arm_l()
{ $fn=50;
translate([0,0,-13])
color("white")
scale([1,0.75,1])
bag_bar(4.9,3.2,13);

translate([0,0,-14.5])
rotate([0,00,0])
color("white")
rotate([-18,.55,0])
translate([0,0,-15.2])
scale([1,0.9,1])
bag_bar(4.35,4.8,14);

color([.8,.7,.7])
translate([0,1.4,-15])
rotate([-3,0,0])
resize(newsize=[10,6.4,14])
sphere(1);
}
module arm_r()
{ $fn=50;
translate([0,0,-13])
color("white")
scale([1,0.75,1])
bag_bar(4.9,3.2,13);

translate([0,0,-13])
rotate([30,130,0])
color("white")
rotate([-18,0,0])
translate([0,0,-12.4])
scale([1,0.9,1])
bag_bar(4.35,4.8,11.5);

color([.8,.7,.7])
translate([0,-.1,-12.9])
rotate([-20,130,0])
resize(newsize=[10,9,10.5])
sphere(1);
}

module thumb()
{$fn=30;
{
resize(newsize=[5.5,5.5,4])rotate([-5,0,0])cylinder(r1=4,r2=1.6,h=13.6,centr=true);
translate([0,0,2.5])rotate([5,0,0])resize(newsize=[3.5,4,5])sphere(1,center=true);
translate([0,0,4])rotate([0,0,0])resize(newsize=[3.6,4,5])sphere(1,center=true);
}
}
module finger()
{$fn=30;
{
resize(newsize=[3.5,3.9,6])sphere(1);
translate([.3,0,1.2])rotate([0,10,0])resize(newsize=[3.4,3.9,5])sphere(1);
translate([.8,0,2.8])rotate([0,20,0])resize(newsize=[3.4,3.5,5])sphere(1);
}
}
module hand()
{ $fn=30;
scale([.72,.72,.72])
{
color("white")translate([1,-4,5])rotate([20,10,0])finger();
color("white")translate([1,0,7])rotate([0,30,0])finger();
color("white")translate([-1,4,6])rotate([-20,-10,0])finger();
color("white")translate([1.8,3.9,0])rotate([-72,11,-30])thumb();
color("white")resize(newsize=[6,11,11])sphere(1);
}
}
module hand_l()
{$fn=30;
mirror([0,1,0])hand();
}
module card_slot()
{$fn=40;
scale([.1,.1,.1])
rotate([0,90,0])
difference()
{color("white")cylinder(r=20,h=10,center=true);
color("gray")difference()
{translate([0,0,5])color("white")cylinder(r=22,h=4,center=true);
translate([0,0,6])color("white")cylinder(r=19,h=12,center=true);
}
translate([-6,0,0.1])color("black")cube([2.5,21.1,10],center=true);
translate([2,-17,0.1])color("black")cube([2.5,9.1,10],center=true);
translate([2,17,0.1])color("black")cube([2.5,9.1,10],center=true);

translate([-2,-11.5,0.1])color("black")rotate([0,0,66])cube([2.5,10,10],center=true);
translate([-2,11.5,0.1])color("black")rotate([0,0,-66])cube([2.5,10,10],center=true);
}

}
module support_bar(rr1,d)
{cylinder(r1=rr1,r2=0.8,h=d-1.3,center=false);
translate([0,0,d-1.31])cylinder(r1=0.8,r2=0.1,h=1.4,center=false);
}
//baymax
module baymax()
{ 
body();
translate([0,-1,33])rotate([3,0,0])head();
translate([0,-5.4,-23])rotate([0,0,180])leg(); 
translate([0,5.4,-23])leg();
translate([0,11,23])
rotate([35,0,0])
arm_l(); 

translate([0,-11,23])
rotate([35,0,160])
arm_r(); 
translate([7.8,-19.2,20.2])
rotate([20,1,0])
hand(); 
translate([-.4,24.9,-3.6])
rotate([-30,190,100])
hand_l(); 

translate([10.4,5.8,20.5])
rotate([-13,-20,28])
card_slot();
//support
$fn=20;
translate([-.5,23.72,-28])support_bar(4,2);
translate([-.5,23.72,-28])support_bar(1.1,15.5);

translate([-.5,23.6,-16])rotate([7,31.5,-6])support_bar(1,9.6);
translate([-.5,23.6,-15.8])rotate([24,-24,0])support_bar(1,6.9);
translate([-.5,23.6,-15.5])rotate([25,-30,-30.6])support_bar(1,8);
translate([-4.5,22.8,-10.5])rotate([33,-11,-30])support_bar(0.8,3.7);

translate([-2.2,-19.4,-28])support_bar(4,2);
translate([-2.2,-19.4,-28])support_bar(1.1,35.8);
}
//with stand plane
scale([1.5,1.5,1.5])
difference()
{baymax();
translate([0,0,-58])cube([60,60,60],center=true);
}

 
 
 

 
