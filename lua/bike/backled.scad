width=30;
height=30;
depth=2;
wing=10;

difference() {
    // baseplate
    cube([width+(wing*2),height,depth]);

    translate([wing+7,7,0]){
      cylinder(r=1.5, h=height);
    }

    translate([width+wing-7,7,0]){
      cylinder(r=1.5, h=height);
    }

    translate([wing+7,height-7,0]){
      cylinder(r=1.5, h=height);
    }

    translate([width+wing-7,height-7,0]){
      cylinder(r=1.5, h=height);
    }
    
    translate([0,wing,0]) {
        cube([wing, height-wing, 2]);
    }

    translate([width+wing,wing,0]) {
        cube([wing, height-wing, 2]);
    }

    translate([wing/2,wing/2,0]){
      cylinder(r=2, h=height);
    }

    translate([(width+wing)+(wing/2), wing/2,0]){
      cylinder(r=2, h=height);
    }
}
