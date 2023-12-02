$fn = 80;

radius = 33;
base_depth = 0.2*4;
gap = 8;
border = 0.8;
height = 18;

module positive() {
    d = 10;
    linear_extrude(d)
        circle(r=radius);
}

module box() {
    translate([0,0,-base_depth]) linear_extrude(base_depth)
        circle(r=radius+gap+border);
    
    difference() {
        linear_extrude(height) circle(r=radius+gap+border);
        linear_extrude(height+1) circle(r=radius+gap);
    }
}

positive();
box();
