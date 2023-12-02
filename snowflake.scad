model_d = 3;
model_s = 80;

flake_s = 80;
flake_d = 9;

height = 18;
base_depth = 0.2*4;

module flake() {
    import("Vorlagen/ShadowFlake.stl");
    // translate([-flake_s/2, -flake_s/2, 0]) cube([flake_s, flake_s, flake_d]);
}

module positive() {
    scale([flake_s/model_s,flake_s/model_s,flake_d/model_d]) 
        flake();
}

module box_base() {
    x = flake_s+18;
    f = 0.33333;
    translate([-x/2,-x/2,0])
        polygon([
            [f*x,0],[(1-f)*x,0],
            [x,f*x],[x,(1-f)*x],
            [(1-f)*x,x],[f*x,x],
            [0,(1-f)*x],[0,f*x],
            [f*x,0]]);
}

module box() {
    strength = 0.8;
    translate([0,0,-base_depth]) linear_extrude(base_depth) offset(r=strength) box_base();
    difference() {
        linear_extrude(height) offset(strength) box_base();
        linear_extrude(height+1) box_base();
    }
}

box();
positive();
