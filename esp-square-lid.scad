//21.55x28.01
w=21.7;
h=27.9;
z=0.3;
rim=0.118;
text="ftl";
fontsize=10;

union() {
 cube([w*(1+rim),h*(1+rim),z]);
 translate([w*rim/2,h*rim/2,-0.6]){
  cube([w,h,z*2]);
 }    

}

// text
translate([w*0.25,2,0]) {
    linear_extrude(height = 1) {
      text(text, size = fontsize, font = "Verdana");
    }
}
