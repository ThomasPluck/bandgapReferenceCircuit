v {xschem version=2.9.9 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N 160 -190 160 -120 { lab=vg}
N 200 -220 330 -220 { lab=vg}
N 160 -180 220 -180 { lab=vg}
N 220 -220 220 -180 { lab=vg}
N 370 -190 370 -120 { lab=vo}
N 160 -60 160 -50 { lab=vx}
N 160 -50 370 -50 { lab=vx}
N 370 -60 370 -50 { lab=vx}
N 160 -250 370 -250 { lab=VDD}
N 20 -90 120 -90 { lab=va}
N 410 -90 520 -90 { lab=vb}
N 20 10 20 60 { lab=va}
N 520 10 520 60 { lab=vb}
N 520 -90 520 -30 { lab=vb}
N 270 60 370 60 { lab=#net1}
N 520 -30 520 10 { lab=vb}
N 180 60 270 60 { lab=#net1}
N 20 -40 20 10 { lab=va}
N 20 -90 20 -40 { lab=va}
N 360 -90 370 -90 { lab=vx}
N 360 -90 360 -60 { lab=vx}
N 360 -60 370 -60 { lab=vx}
N 160 -90 170 -90 { lab=vx}
N 170 -90 170 -60 { lab=vx}
N 160 -60 170 -60 { lab=vx}
N 710 -260 710 -210 { lab=VDD}
N 770 -210 790 -210 { lab=GND}
N 80 60 120 60 { lab=#net2}
N 430 60 450 60 { lab=#net3}
N 510 60 520 60 { lab=vb}
N 540 -50 580 -50 { lab=#net4}
N 540 -50 540 -20 { lab=#net4}
N 580 -130 580 -50 { lab=#net4}
N 580 -20 580 10 { lab=GND}
N 150 -220 160 -220 { lab=VDD}
N 150 -250 150 -220 { lab=VDD}
N 150 -250 160 -250 { lab=VDD}
N 370 -220 380 -220 { lab=VDD}
N 380 -250 380 -220 { lab=VDD}
N 370 -250 380 -250 { lab=VDD}
N 370 -160 540 -160 { lab=vo}
N 540 -160 540 -150 { lab=vo}
N 540 -150 640 -150 { lab=vo}
N 580 -190 580 -160 { lab=VDD}
N 260 -20 270 -20 { lab=GND}
N 260 -20 260 10 { lab=GND}
N 260 10 270 10 { lab=GND}
N 310 -20 540 -20 { lab=#net4}
N 640 -150 740 -150 { lab=vo}
N 740 -170 740 -150 { lab=vo}
C {devices/gnd.sym} 270 10 0 0 {name=l1 lab=GND}
C {devices/vdd.sym} 270 -250 0 0 {name=l2 lab=VDD}
C {devices/vsource.sym} 20 -240 0 0 {name=V1 value=1.8}
C {devices/vdd.sym} 20 -270 0 0 {name=l3 lab=VDD}
C {devices/gnd.sym} 20 -210 0 0 {name=l4 lab=GND}
C {devices/lab_pin.sym} 370 -160 0 1 {name=l5 lab=vo}
C {devices/lab_pin.sym} 270 -220 1 1 {name=l6 lab=vg}
C {devices/code_shown.sym} -500 -220 0 0 {name=NGSPICE
only_toplevel=true
value="
.option savecurrents
.option warn=1

.control
save all
op
let gm4=@m.xm4.msky130_fd_pr__pfet_01v8_lvt['gm']
let gm2=@m.xm2.msky130_fd_pr__nfet_01v8_lvt['gm']
*let ib=@i0[current]
let irhs=@m.xm2.msky130_fd_pr__nfet_01v8_lvt['id']
let ilhs=@m.xm1.msky130_fd_pr__nfet_01v8_lvt['id']
let vthp=@m.xm3.msky130_fd_pr__pfet_01v8_lvt['vth']
let vthn=@m.xm1.msky130_fd_pr__nfet_01v8_lvt['vth']
print gm2 gm4
print irhs ilhs
let K=10^(-3.89062)
echo 'saturation cond. for M1 & M2 (by symmetry)'
echo 'is'
print vo - vx
echo 'greater than'
print vb - vx - vthn
echo 'saturation cond. for M3 & M4 (by symmetry)'
echo 'is'
print vdd - vo
echo 'greater than'
print vdd - vg - vthp
echo 'saturation cond. check w/ vo'
echo 'is'
print vo
echo 'between'
print vg + vthp
echo 'and'
print vb - vthn
echo 'common mode input sweep'
dc v2 1p 1 0.01
let dcIndx = 49
let irhs=@m.xm2.msky130_fd_pr__nfet_01v8_lvt['id']
let ilhs=@m.xm1.msky130_fd_pr__nfet_01v8_lvt['id']
plot irhs ilhs
plot ilhs/irhs
print net1[dcIndx]
print (ilhs/irhs)[dcIndx]
let vic=(va+vb)/2
plot db(abs(vo / vic)) 
plot vo
echo 'ac analysis'
ac dec 100 1 100e9
let vid=va-vb
let irhs=@m.xm2.msky130_fd_pr__nfet_01v8_lvt['id']
let ilhs=@m.xm1.msky130_fd_pr__nfet_01v8_lvt['id']
plot db(abs(vo/vid))
echo 'dc gain (dB)'
print db(abs(vo/vid))[0]
dc temp -40 120 2
let irhs=@m.xm2.msky130_fd_pr__nfet_01v8_lvt[id]
let ilhs=@m.xm1.msky130_fd_pr__nfet_01v8_lvt[id]
plot irhs ilhs
plot irhs/ilhs
plot vo
let vic = (va+vb)/2
plot db(abs(vo/vic))
let vid = va-vb
plot db(abs(vo/vid))
.endc
" }
C {devices/code.sym} -110 -70 0 0 {name=TT_MODELS
only_toplevel=true
format="tcleval( @value )"
value="
.include \\\\$::SKYWATER_MODELS\\\\/cells/nfet_01v8/sky130_fd_pr__nfet_01v8__tt.corner.spice
.include \\\\$::SKYWATER_MODELS\\\\/cells/nfet_01v8_lvt/sky130_fd_pr__nfet_01v8_lvt__tt.corner.spice
.include \\\\$::SKYWATER_MODELS\\\\/cells/pfet_01v8/sky130_fd_pr__pfet_01v8__tt.corner.spice
.include \\\\$::SKYWATER_MODELS\\\\/cells/nfet_03v3_nvt/sky130_fd_pr__nfet_03v3_nvt__tt.corner.spice
.include \\\\$::SKYWATER_MODELS\\\\/cells/nfet_05v0_nvt/sky130_fd_pr__nfet_05v0_nvt__tt.corner.spice
.include \\\\$::SKYWATER_MODELS\\\\/cells/esd_nfet_01v8/sky130_fd_pr__esd_nfet_01v8__tt.corner.spice
.include \\\\$::SKYWATER_MODELS\\\\/cells/pfet_01v8_lvt/sky130_fd_pr__pfet_01v8_lvt__tt.corner.spice
.include \\\\$::SKYWATER_MODELS\\\\/cells/pfet_01v8_hvt/sky130_fd_pr__pfet_01v8_hvt__tt.corner.spice
.include \\\\$::SKYWATER_MODELS\\\\/cells/esd_pfet_g5v0d10v5/sky130_fd_pr__esd_pfet_g5v0d10v5__tt.corner.spice
.include \\\\$::SKYWATER_MODELS\\\\/cells/pfet_g5v0d10v5/sky130_fd_pr__pfet_g5v0d10v5__tt.corner.spice
.include \\\\$::SKYWATER_MODELS\\\\/cells/pfet_g5v0d16v0/sky130_fd_pr__pfet_g5v0d16v0__tt.corner.spice
.include \\\\$::SKYWATER_MODELS\\\\/cells/nfet_g5v0d10v5/sky130_fd_pr__nfet_g5v0d10v5__tt.corner.spice
.include \\\\$::SKYWATER_MODELS\\\\/cells/nfet_g5v0d16v0/sky130_fd_pr__nfet_g5v0d16v0__tt_discrete.corner.spice
.include \\\\$::SKYWATER_MODELS\\\\/cells/esd_nfet_g5v0d10v5/sky130_fd_pr__esd_nfet_g5v0d10v5__tt.corner.spice
.include \\\\$::SKYWATER_MODELS\\\\/models/corners/tt/nonfet.spice
* Mismatch parameters
.include \\\\$::SKYWATER_MODELS\\\\/cells/nfet_01v8/sky130_fd_pr__nfet_01v8__mismatch.corner.spice
.include \\\\$::SKYWATER_MODELS\\\\/cells/pfet_01v8/sky130_fd_pr__pfet_01v8__mismatch.corner.spice
.include \\\\$::SKYWATER_MODELS\\\\/cells/nfet_01v8_lvt/sky130_fd_pr__nfet_01v8_lvt__mismatch.corner.spice
.include \\\\$::SKYWATER_MODELS\\\\/cells/pfet_01v8_lvt/sky130_fd_pr__pfet_01v8_lvt__mismatch.corner.spice
.include \\\\$::SKYWATER_MODELS\\\\/cells/pfet_01v8_hvt/sky130_fd_pr__pfet_01v8_hvt__mismatch.corner.spice
.include \\\\$::SKYWATER_MODELS\\\\/cells/nfet_g5v0d10v5/sky130_fd_pr__nfet_g5v0d10v5__mismatch.corner.spice
.include \\\\$::SKYWATER_MODELS\\\\/cells/pfet_g5v0d10v5/sky130_fd_pr__pfet_g5v0d10v5__mismatch.corner.spice
.include \\\\$::SKYWATER_MODELS\\\\/cells/nfet_05v0_nvt/sky130_fd_pr__nfet_05v0_nvt__mismatch.corner.spice
.include \\\\$::SKYWATER_MODELS\\\\/cells/nfet_03v3_nvt/sky130_fd_pr__nfet_03v3_nvt__mismatch.corner.spice
* Resistor\\\\$::SKYWATER_MODELS\\\\/Capacitor
.include \\\\$::SKYWATER_MODELS\\\\/models/r+c/res_typical__cap_typical.spice
.include \\\\$::SKYWATER_MODELS\\\\/models/r+c/res_typical__cap_typical__lin.spice
* Special cells
.include \\\\$::SKYWATER_MODELS\\\\/models/corners/tt/specialized_cells.spice
* All models
.include \\\\$::SKYWATER_MODELS\\\\/models/all.spice
.include \\\\$::SKYWATER_MODELS\\\\/cells/pnp_05v5/sky130_fd_pr__pnp_05v5_W3p40L3p40.model.spice
* Corner
.include \\\\$::SKYWATER_MODELS\\\\/models/corners/tt/rf.spice
"}
C {devices/vsource.sym} 270 90 0 0 {name=V2 value="dc 488m ac 0"}
C {devices/lab_pin.sym} 260 -50 3 1 {name=l7 lab=vx}
C {devices/lab_pin.sym} 450 -90 1 1 {name=l8 lab=vb}
C {devices/lab_pin.sym} 90 -90 1 1 {name=l9 lab=va}
C {devices/gnd.sym} 270 120 0 0 {name=l10 lab=GND}
C {devices/ammeter.sym} 50 60 3 1 {name=Vmeas}
C {devices/ammeter.sym} 480 60 1 0 {name=Vmeas1}
C {sky130_fd_pr/pfet3_01v8.sym} 740 -190 3 0 {name=M5
L=0.15
W=1
body=VDD
nf=1
mult="3"
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {devices/vdd.sym} 710 -260 0 0 {name=l11 lab=VDD}
C {devices/gnd.sym} 790 -210 0 0 {name=l12 lab=GND}
C {devices/vsource.sym} 150 60 3 0 {name=V3 value="dc 18m ac 1m"}
C {devices/vsource.sym} 400 60 3 0 {name=V4 value="dc 18m ac 1m"}
C {devices/vdd.sym} 580 -190 0 0 {name=l13 lab=VDD}
C {devices/gnd.sym} 580 10 0 0 {name=l14 lab=GND}
C {sky130_fd_pr/pfet_01v8_lvt.sym} 350 -220 0 0 {name=M4
L=1
W=23.529
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8_lvt.sym} 390 -90 0 1 {name=M2
L=1
W='4.135*2.914825'
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/pfet_01v8_lvt.sym} 560 -160 0 0 {name=M6
L=1
W=19.774
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8_lvt.sym} 140 -90 0 0 {name=M1
L=1
W=4.135
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8_lvt.sym} 560 -20 0 0 {name=M7
L=1
W=4.135
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/pfet_01v8_lvt.sym} 180 -220 0 1 {name=M3
L=1
W=23.529
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8_lvt.sym} 290 -20 0 1 {name=M8
L=1
W=4.135
nf=1
mult=2
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
