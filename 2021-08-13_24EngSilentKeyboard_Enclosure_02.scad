viewSelection = 4;
thickness = 3;
keypadWidth = 48.4;
keypadLength = 80;
keypadButtonWidth = 45;
keypadButtonLength = 61;
keypadButtonOffset = 2;
keypadBoltHoleWidthOffset = 40.6;
keypadBoltHoleLengthOffset = 72.4;
//cavityDepth = 7.5;
cavityDepth = 0;
keypadBoltHoleDiameter = 3;
ArduinoWidth = keypadWidth+0.5;
ArduinoLength = 18.5;
ArduinoThickness = 8;
USBPortWidth = 11;
PCBSeparation = 5;
boltDiameter = 3;
boltHeadDiameter = 6;
nutMajorDiameter = 6.13;

nutMajorRadius = nutMajorDiameter/2;
keypadBoltHoleRadius = keypadBoltHoleDiameter /2;
boltRadius = boltDiameter/2;
boltHeadRadius = boltHeadDiameter/2;
//$vpr=[55,180,25-360*$t];

if(viewSelection==4){
    bottom();
}

if(viewSelection==3){
    ArduinoCover();
}

if(viewSelection==2){
    accessibleTop();
}

if(viewSelection==1){
    plainLid();
}

if(viewSelection==0){
    color("aqua"){
        accessibleTop();
        translate([0,-(keypadLength/2)-ArduinoLength/2-thickness-PCBSeparation,0]){
            ArduinoCover();
        }
        translate([0,-(keypadLength/2)-thickness/2-PCBSeparation/2,0]){
            joiningTunnel();
        }
    }
    translate([0,0,0]){
        color("lime"){
            bottom();
        }
    }
}

module bottom(){
    KBBottom();
    translate([0,-(keypadLength/2)-ArduinoLength/2-thickness-PCBSeparation,0]){
        ArduinoCover();
    }
    translate([0,-(keypadLength/2)-thickness/2-PCBSeparation/2,0]){
        joiningTunnel();
    }
}

module KBBottom(){
    difference(){
        translate([0,0,(cavityDepth+thickness)/2]){
            cube([keypadWidth+thickness*2, keypadLength+thickness, cavityDepth+thickness], center=true);
            translate([keypadBoltHoleWidthOffset/2, keypadBoltHoleLengthOffset/2, 0]){
                cylinder(thickness*2, nutMajorRadius+thickness, nutMajorRadius+thickness);
            }
            translate([-keypadBoltHoleWidthOffset/2, keypadBoltHoleLengthOffset/2, 0]){
                cylinder(thickness*2, nutMajorRadius+thickness, nutMajorRadius+thickness);
            }
            translate([keypadBoltHoleWidthOffset/2, -keypadBoltHoleLengthOffset/2, 0]){
                cylinder(thickness*2, nutMajorRadius+thickness, nutMajorRadius+thickness);
            }
            translate([-keypadBoltHoleWidthOffset/2, -keypadBoltHoleLengthOffset/2, 0]){
                cylinder(thickness*2, nutMajorRadius+thickness, nutMajorRadius+thickness);
            }
        }
        translate([0,-thickness/2-0.001,(cavityDepth)/2]){
            cube([keypadWidth, keypadLength, cavityDepth+0.01], center=true);
        }
        translate([keypadBoltHoleWidthOffset/2, keypadBoltHoleLengthOffset/2, 0]){
            nutSocket();
        }
        translate([-keypadBoltHoleWidthOffset/2, keypadBoltHoleLengthOffset/2, 0]){
            nutSocket();
        }
        translate([keypadBoltHoleWidthOffset/2, -keypadBoltHoleLengthOffset/2, 0]){
            nutSocket();
        }
        translate([-keypadBoltHoleWidthOffset/2, -keypadBoltHoleLengthOffset/2, 0]){
            nutSocket();
        }
    }
}

module joiningTunnel(){
    difference(){
        translate([0,0,(cavityDepth+thickness)/2]){
            cube([ArduinoWidth+thickness*2, PCBSeparation, cavityDepth+thickness], center=true);
        }
        translate([0,thickness/2+0.001,(cavityDepth)/2]){
            cube([ArduinoWidth/2, ArduinoLength, cavityDepth+0.01], center=true);
        }
    }
}

module ArduinoCover(){
    difference(){
        translate([0,0,(cavityDepth+thickness)/2]){
            cube([ArduinoWidth+thickness*2, ArduinoLength+thickness, cavityDepth+thickness], center=true);
        }
        translate([0,thickness/2+0.001,(cavityDepth)/2]){
            cube([ArduinoWidth, ArduinoLength, cavityDepth+0.01], center=true);
        }
        translate([ArduinoWidth/2+thickness/2,thickness/2,(cavityDepth)/2]){
            cube([thickness*1.01, USBPortWidth, cavityDepth*4], center=true);
        }
    }
}

module plainLid(){
    difference(){
        translate([0,0,(cavityDepth+thickness)/2]){
            cube([keypadWidth+thickness*2, keypadLength+thickness, cavityDepth+thickness], center=true);
        }
        translate([0,-thickness/2-0.001,(cavityDepth)/2]){
            cube([keypadWidth, keypadLength, cavityDepth+0.01], center=true);
        }
        translate([keypadBoltHoleWidthOffset/2, keypadBoltHoleLengthOffset/2, 0]){
            bolt();
        }
        translate([-keypadBoltHoleWidthOffset/2, keypadBoltHoleLengthOffset/2, 0]){
            bolt();
        }
        translate([keypadBoltHoleWidthOffset/2, -keypadBoltHoleLengthOffset/2, 0]){
            bolt();
            }
        translate([-keypadBoltHoleWidthOffset/2, -keypadBoltHoleLengthOffset/2, 0]){
            bolt();
        }
    }
}

module accessibleTop(){
    difference(){
        plainLid();
        translate([0,keypadButtonOffset,0]){
            cube([keypadButtonWidth, keypadButtonLength, cavityDepth*3],center=true);
        }
    }
}

module bolt(){
    cylinder(cavityDepth*5, boltRadius, boltRadius, center=true, $fn = 24);
    translate([0,0,cavityDepth+thickness/2]){
        cylinder(thickness+0.01, boltRadius, boltHeadRadius, center=true, $fn = 24);
    }
}

module nutSocket(){
    cylinder(thickness*5, boltRadius, boltRadius, center=true, $fn = 24);
    translate([0,0,cavityDepth+thickness]){
        cylinder(thickness*3, nutMajorRadius, nutMajorRadius, $fn = 6);
    }
}