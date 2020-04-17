pane_thickness = 18;
pane_width = 300;
pane_length = 920;
total_height = 1100;

leg_thickness = 44;
support_thickness = 27;
leg_height = total_height - pane_thickness;

front_width = 920;
back_width = 675;
chimney_width = 245;
/* sides_width = 650; */
sides_width = 600;

chimney_support_length = (chimney_width-(2*leg_thickness));
back_support_length = (back_width-(1*leg_thickness));
front_support_length = (front_width-(2*leg_thickness));

middle_panes = 2; // number of panes between the first and the last


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
    cube([front_support_length, support_thickness, support_thickness]);
}

module back_support() {
  translate([leg_thickness,sides_width-support_thickness])
    cube([back_support_length, support_thickness, support_thickness]);
}

module left_side_support() {
  translate([0, leg_thickness, 0])
    cube([support_thickness, (sides_width-(2*leg_thickness)), support_thickness]);
}

module right_side_support() {
color("orange")
  translate([front_width-support_thickness, 0])
    translate([0, leg_thickness, 0])
      cube([support_thickness, (sides_width-(leg_thickness)-chimney_width), support_thickness]);
}

module chimney_right_support() {
  translate([front_width-leg_thickness-chimney_support_length-support_thickness, sides_width-chimney_width+leg_thickness])
    cube([support_thickness, chimney_support_length, support_thickness]);
}

module chimney_front_support() {
  translate([front_width-chimney_support_length-leg_thickness, sides_width-chimney_width+(leg_thickness-support_thickness)])
    cube([chimney_support_length, support_thickness, support_thickness]);
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

module top_pane() {
  pane();
  translate([0, pane_width, 0])
    difference(){
      color("blue")
      pane();
      translate([pane_length-chimney_width+leg_thickness, pane_width-chimney_width+leg_thickness, -pane_thickness/2])
        // overcut by 50 to avoid rendering issue
        cube([chimney_width-leg_thickness+50, chimney_width-leg_thickness+50, pane_thickness*2]);
    }
}

module leg_cut() {
  // overcut by 50 to avoid rendering issue
  cube([leg_thickness, leg_thickness, pane_thickness*2]);
}

module pane_leg_cuts() {
  color("black")
    leg_cut();
  translate([front_width-leg_thickness, 0])
    leg_cut();
  // bottom right leg
  translate([front_width-leg_thickness-chimney_support_length-leg_thickness, sides_width-leg_thickness])
    leg_cut();
  // bottom left leg
  translate([0, sides_width-leg_thickness])
    leg_cut();
  // chimney leg
  translate([front_width-leg_thickness-chimney_support_length-leg_thickness, sides_width-chimney_width])
    leg_cut();
  // chimney side leg
  translate([front_width-leg_thickness, sides_width-chimney_width])
    leg_cut();
}

legs();
// ground support
supports();
// middle support
translate([0, 0, leg_height*1/(middle_panes+1)-pane_thickness])
  supports();
// middle support
translate([0, 0, leg_height*2/(middle_panes+1)-pane_thickness])
  supports();
// top support
translate([0, 0, leg_height-support_thickness])
  supports();

// ground pane
translate([0, 0, support_thickness])
  difference(){
    top_pane();
    pane_leg_cuts();
  }

// middle pane
translate([0, 0, (leg_height*1/(middle_panes+1))+(support_thickness*1/(middle_panes+1))])
  difference(){
    top_pane();
    pane_leg_cuts();
  }
// middle pane
translate([0, 0, (leg_height*2/(middle_panes+1))+(support_thickness*1/(middle_panes+1))])
  difference(){
    top_pane();
    pane_leg_cuts();
  }
// top pane
translate([0, 0, total_height-pane_thickness])
  top_pane();

