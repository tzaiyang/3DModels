USB_L = 12.5;
USB_W = 4.8;
USB_H = 14;

USB_WW = 5;
USB_LL = 6;
USB_EDGE = 3;


Hub_L = (USB_L+USB_WW)*(5-1)+USB_L+3*2;
Hub_W = USB_W+USB_LL*2;
Hub_bottom = 2;
Hub_H = USB_H-Hub_bottom;

union(){
    difference(){
        cube([Hub_L,Hub_W,Hub_H]);
        translate([USB_EDGE,USB_LL,Hub_bottom])
        cube([USB_L,USB_W,USB_H]);
        translate([(USB_WW+USB_L)+USB_EDGE,USB_LL,Hub_bottom])
        cube([USB_L,USB_W,USB_H]);
        translate([(USB_WW+USB_L)*2+USB_EDGE,USB_LL,Hub_bottom])
        cube([USB_L,USB_W,USB_H]);
        translate([(USB_WW+USB_L)*3+USB_EDGE,USB_LL,Hub_bottom])
        cube([USB_L,USB_W,USB_H]);
        translate([(USB_WW+USB_L)*4+USB_EDGE,USB_LL,Hub_bottom])
        cube([USB_L,USB_W,USB_H]);
    };
};
