tree_h = 57;
tree_w = 43;

module tree_model() {
    import("Vorlagen/arvorepequenalarga4.stl");
}
module tree() {
    tree_model();
    // fill the tree
    hull() {
        scale(0.9) {
            tree_model();
        }
    }
}

module tree_part(part) {
    off = part == 1 ? 0 : 1;
    h = tree_h * 2;
    intersection() {
        tree();
        translate([-h/2,-h*off,0]) cube([h, h, h]);
    }
}

base_depth = 0.2*4;
border = 7;
cup_scale = 1.5;
offset_2 = tree_w*0.9;

module positive() {
    translate([tree_w*1.5, tree_h,0]) {
        translate([-offset_2,-tree_h,0]) rotate([-90,180,0]) tree_part(1);
        rotate([90,180,0]) tree_part(2);
    }
}




module base() {
    translate([border, border]) positive();
}

module cup(part) {
    hull() { 
        scale([cup_scale, 10, cup_scale]) tree_part(part);
    }
}
module cups() {
    w = tree_w*cup_scale;
    translate([w/2,0,0]) rotate([-90, 180, 0]) cup(1);
    translate([70, tree_h+2*border, 0]) rotate([90, 180, 0]) cup(2);
}

module box() {
    w = tree_w*2+border*2;
    h = tree_h+border*2;
    d = tree_w/2*cup_scale;
    b = 1000;
    c = 0.6;
    difference() {
        scale(2) cups();
        cups();
        translate([0,0,d+5]) cube([w,h,10]);
        translate([-b,0,0]) cube([b,h,d]);
        translate([w,0,0]) cube([b,h,d]);
        translate([-b,-b,0]) cube([w+b*2,b,d]);
        translate([-b,h,0]) cube([w+b*2,b,d]);
        translate([-b,-b,d]) cube([w+b*2,h+b*2,1000]);
    }
    difference() {
        translate([-c,-c,-c]) cube([w+2*c,h+2*c,d+2*c]);
        cube([w,h,d*2]);
    }
    translate([0,0,-base_depth]) cube([tree_w*2+border*2, tree_h+border*2, base_depth]);
}

module box2_form() {
    w = tree_w*2+border*2;
    h = tree_h+border*2;
    polygon([[0,0], [w*0.7,0], [w,h*0.8], [w,h], [w*0.2,h], [0,h*0.05], [0,h], [0,0]]);
}

module box2() {
    border = 1;
    d = tree_w/2 + 10;
    difference() {
        linear_extrude(d) offset(r=border) box2_form();
        linear_extrude(d+10) box2_form();
    }
    translate([0,0,-base_depth]) linear_extrude(base_depth) offset(r=border) box2_form();
}


base();
box2();


