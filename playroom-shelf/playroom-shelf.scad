pane_thickness = 18;
pane_width = 300;
pane_length = 920;
total_height = 1100;

leg_thickness = 44;
leg_height = total_height - pane_thickness;

front_width = 920;
back_width = 675;
chimney_width = 245;
/* sides_width = 650; */
sides_width = 600;

chimney_support_length = (chimney_width-(2*leg_thickness));
back_support_length = (back_width-(1*leg_thickness));
front_support_length = (front_width-(2*leg_thickness));


module leg() {
  color("red")
    cube([leg_thickness, leg_thickness, leg_height]);  
}

module legs() {
  // front left leg
  leg();
  // front right leg
  translate([front_width-leg_thickness, 0])
    leg();
  // bottom right leg
  translate([front_width-leg_thickness-chimney_support_length-leg_thickness, sides_width-leg_thickness])
    leg();
  // bottom left leg
  translate([0, sides_width-leg_thickness])
    leg();
  // chimney leg
  translate([front_width-leg_thickness-chimney_support_length-leg_thickness, sides_width-chimney_width])
    leg();
  // chimney side leg
  translate([front_width-leg_thickness, sides_width-chimney_width])
    leg();
}

module front_support() {
  translate([leg_thickness, 0, 0])
    cube([front_support_length, leg_thickness, leg_thickness]);
}

module back_support() {
  translate([leg_thickness,sides_width-leg_thickness])
    cube([back_support_length, leg_thickness, leg_thickness]);
}

module left_side_support() {
  translate([0, leg_thickness, 0])
    cube([leg_thickness, (sides_width-(2*leg_thickness)), leg_thickness]);
}

module right_side_support() {
  translate([front_width-leg_thickness, 0])
    translate([0, leg_thickness, 0])
      cube([leg_thickness, (sides_width-(leg_thickness)-chimney_width), leg_thickness]);
}

module chimney_right_support() {
  translate([front_width-leg_thickness-chimney_support_length-leg_thickness, sides_width-chimney_width+leg_thickness])
    cube([leg_thickness, chimney_support_length, leg_thickness]);
}

module chimney_front_support() {
  translate([front_width-chimney_support_length-leg_thickness, sides_width-chimney_width])
    cube([chimney_support_length, leg_thickness, leg_thickness]);
}

module supports() {
  front_support();
  back_support();
  left_side_support();
  right_side_support();
  chimney_right_support();
  chimney_front_support();
}

module pane() {
  color("orange")
    cube([pane_length, pane_width, pane_thickness]);
}

legs();
// ground support
supports();
// middle support
translate([0, 0, (leg_height-leg_thickness)/2])
  supports();
// top support
translate([0, 0, leg_height-leg_thickness])
  supports();

translate([0, 0, total_height-pane_thickness])
  pane();
translate([0, pane_width, total_height-pane_thickness])
  color("blue")
  difference(){
    pane();
    translate([pane_length-chimney_width+leg_thickness, pane_width-chimney_width+leg_thickness, -pane_thickness/2])
      color("red")
      cube([chimney_width-leg_thickness, chimney_width-leg_thickness, pane_thickness*2]);

  }
