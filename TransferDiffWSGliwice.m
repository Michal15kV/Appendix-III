% TransferDiffWSGliwice - funkcja obliczająca różnicę transferową wzorca*)
%{
run("Parametry_Monte_Carlo_SJTC_Un_3V.m"); % importowanie pliku z parametrami
 freq = 1e6;
 omegaF = 2*pi*freq;

wynik = TransferDiffWSGliwice(conConWires,conCu1p,conDisk,conTube,conSJTCHeater,radiusCu,radiusCu3Pin,radiusNpin,radiusNtubeTef,radiusNtubeAir,radiusRangeRes,radiusTube,radiusSjtcL,thickDisk,thickTube,thickTubeSectionTeflon,thickTubeSectionAir,lenCu1,lenCu1p,lenCu2,lenCu3,lenSjtcL,lenSjtcH,lenSectionTefM,lenSectionTefF,lenSectionAir,lenRangeRes,conNinternal,conNtube,conRangeRes,epsylonTeflon,epsylonAir,miCopper,miDisk,miHeater,miTube,miTeflon,miAir,miRangeRes,zLoad,miNinternal,miNtube,radiusCu1p,omegaF,freq)
%}
function wynik = TransferDiffWSGliwice(conConWires_,conCu1p_,conDisk_,conTube_,conSJTCHeater_,radiusCu_,radiusCu3Pin_,radiusNpin_,radiusNtubeTef_,radiusNtubeAir_,radiusRangeRes_,radiusTube_,radiusSjtcL_,thickDisk_,thickTube_,thickTubeSectionTeflon_,thickTubeSectionAir_,lenCu1_,lenCu1p_,lenCu2_,lenCu3_,lenSjtcL_,lenSjtcH_,lenSectionTefM_,lenSectionTefF_,lenSectionAir_,lenRangeRes_,conNinternal_,conNtube_,conRangeRes_,epsylonTeflon_,epsylonAir_,miCopper_,miDisk_,miHeater_,miTube_,miTeflon_,miAir_,miRangeRes_,zLoad_,miNinternal_,miNtube_,radiusCu1p_,omegaF_,freq_)
mi_0 = 4*pi*1e-7;
conConWires = conConWires_;
conCu1p = conCu1p_;
conDisk = conDisk_;
conTube = conTube_;
conSJTCHeater = conSJTCHeater_;
radiusCu = radiusCu_;
radiusCu1p = radiusCu1p_;
radiusCu3Pin = radiusCu3Pin_;
radiusNpin = radiusNpin_;
radiusNtubeTef = radiusNtubeTef_;
radiusNtubeAir = radiusNtubeAir_;
radiusRangeRes = radiusRangeRes_;
radiusTube = radiusTube_;
radiusSjtcL = radiusSjtcL_;
thickDisk = thickDisk_;
thickTube = thickTube_;
thickTubeSectionTeflon = thickTubeSectionTeflon_;
thickTubeSectionAir = thickTubeSectionAir_;
lenCu1 = lenCu1_;
lenCu1p = lenCu1p_;
lenCu2 = lenCu2_;
lenCu3 = lenCu3_;
lenSjtcL = lenSjtcL_;
lenSjtcH = lenSjtcH_;
lenSectionTefM = lenSectionTefM_;
lenSectionTefF = lenSectionTefF_;
lenSectionAir = lenSectionAir_;
lenRangeRes = lenRangeRes_;
conNinternal = conNinternal_;
conNtube = conNtube_;
conRangeRes = conRangeRes_;
epsylonTeflon = epsylonTeflon_;
epsylonAir = epsylonAir_;
miCopper = miCopper_;
miDisk = miDisk_;
miHeater = miHeater_;
miTube = miTube_;
miTeflon = miTeflon_;
miAir = miAir_;
miRangeRes = miRangeRes_;
zLoad = zLoad_;
miNinternal = miNinternal_;
miNtube = miNtube_;
omegaF = omegaF_;
At = NConnectorsWithTee(radiusNpin,radiusNtubeTef,radiusNtubeAir,thickTubeSectionTeflon,thickTubeSectionAir,lenSectionTefM,lenSectionTefF,lenSectionAir,conNinternal,conNtube,epsylonTeflon,epsylonAir,miTube,miTeflon,miAir,miNinternal,miNtube,omegaF);
freq = freq_;

conHeater = conSJTCHeater; 
radiusSjtcH = sqrt(lenSjtcH/(pi*zLoad*conHeater)); % obliczenie promienia grzejnika SJTC *)

% przedni dysk

RdiskFront = RDisk(radiusCu,radiusTube,thickDisk,conDisk);
AacdiskFront = [1,ZacDisk(radiusCu,radiusTube,thickDisk,conDisk,miDisk,freq);0,1];

% Cu1 - miedziany łącznik pomiędzy N a drutem oporowym
RCu1p = WireR(radiusCu1p,lenCu1p,conCu1p,miCopper);
AacCu1p = [1,SegmentDescrACInside(radiusCu1p,lenCu1p,conCu1p,miCopper,omegaF)+1j*omegaF*CoaxLout(radiusCu1p,13e-3/2,lenCu1p,miAir);0,1]*[1,0;1j*omegaF*CoaxC(radiusCu1p,13e-3/2,lenCu1p,epsylonAir),1];
RCu1 = SegmentDescrDC(radiusCu,radiusTube,thickTube,lenCu1,conConWires,conTube,miCopper,miTube);
AacCu1 = SegmentDescrAC(radiusCu,radiusTube,thickTube,lenCu1,conConWires,conTube,epsylonAir,miCopper,miAir,miTube,omegaF);

% drut oporowy
RW = SegmentDescrDC(radiusRangeRes,radiusTube,thickTube,lenRangeRes,conRangeRes,conTube,miRangeRes,miTube);
AacW = SegmentDescrAC(radiusRangeRes,radiusTube,thickTube,lenRangeRes,conRangeRes,conTube,epsylonAir,miRangeRes,miAir,miTube,omegaF);

% Cu2 miedziany łącznik pomiędzy drutem oporowym a TPWS
RCu2 = SegmentDescrDC(radiusCu,radiusTube,thickTube,lenCu2,conConWires,conTube,miCopper,miTube);
AacCu2 = SegmentDescrAC(radiusCu,radiusTube,thickTube,lenCu2,conConWires,conTube,epsylonAir,miCopper,miAir,miTube,omegaF);

% mosiężny łącznik pomiędzy TPWS a obudową
RCu3 = SegmentDescrDC(radiusCu3Pin,radiusTube,thickTube,lenCu3,conDisk,conTube,miDisk,miTube);
AacCu3 = SegmentDescrAC(radiusCu3Pin,radiusTube,thickTube,lenCu3,conDisk,conTube,epsylonAir,miCopper,miAir,miTube,omegaF);

% dysk zamykający obudowę
RdiskBack = RDisk(radiusCu,radiusTube,thickDisk,conDisk);
AacdiskBack = [1,ZacDisk(radiusCu,radiusTube,thickDisk,conDisk,miDisk,freq);0,1];

%%% model SJTC %%%

% wyprowadzenia TPWS
RsjtcLeg = DumetRdc(lenSjtcL)+TubeR(radiusTube,radiusTube+thickTube,lenSjtcL,conTube,miTube);
AacSjtcLeg = SegmentDescrACTransmissionLine(dumetZ(lenSjtcL,freq)+1j*omegaF*CoaxLout(radiusSjtcL,radiusTube,lenSjtcL,miAir)+ZtubeOutApp(radiusTube,thickTube,lenSjtcL,conTube,miTube,omegaF),CoaxC(radiusSjtcL,radiusTube,lenSjtcL,epsylonAir),omegaF);

% grzejnik TPWS
RSjtcHeater = WireR(radiusSjtcH,lenSjtcH/2,conHeater,miCopper);
ZSjtcHeater = SegmentDescrACInside(radiusSjtcH,lenSjtcH/2,conHeater,miHeater,omegaF)+1j*omegaF*CoaxLout(radiusSjtcH,radiusTube,lenSjtcH/2,miAir);
YSjtcHeaterC = 1j*omegaF*CoaxC(radiusSjtcH,radiusTube,lenSjtcH,epsylonAir);
AacSjtcHeater = [1,ZSjtcHeater;0,1]*[1,0;YSjtcHeaterC,1]*[1,ZSjtcHeater;0,1];

% model obudowy nad grzejnikiem TPWS
AacSjtcShield = [1,ZtubeOutApp(radiusTube,thickTube,lenSjtcH,conTube,miTube,omegaF);0,1];
RSjtcShield = TubeR(radiusTube,radiusTube+thickTube,lenSjtcH,conTube,miTube);

% model złącza typu N
RconN = At{1};
AacConN = At{2};

% połączenie modeli poszczególnych obszarów w jedną całość
AacBeforeSjtc = AacConN*AacdiskFront*AacCu1p*AacCu1*AacW*AacCu2*AacSjtcLeg*AacSjtcShield;
AacAfterSjtc = AacSjtcLeg*AacCu3*AacdiskBack;
Aac = AacBeforeSjtc*AacSjtcHeater*AacAfterSjtc;
Rdc = RconN+RCu1p+RCu1+RW+RCu2+RSjtcShield+(RsjtcLeg+RSjtcHeater)*2+RCu3+RdiskBack+RdiskFront;
IpMod = abs((AacBeforeSjtc(1,1)*AacBeforeSjtc(2,2)-AacBeforeSjtc(2,1)*AacBeforeSjtc(1,2))/(AacBeforeSjtc(1,1)*Aac(2,2)/Aac(1,2)-AacBeforeSjtc(2,1)));
Zaf = AacAfterSjtc(1,2)/AacAfterSjtc(2,2);
ZSjtcConstK = (1+1/(abs(1+(ZSjtcHeater+Zaf)*YSjtcHeaterC))^2);

wynik = (sqrt(2*RSjtcHeater/(real(ZSjtcHeater)*ZSjtcConstK))*IpMod/Rdc-1)*1E6;
end


function y = J0(x)
y = besselj(0,x);
end

function y = dJ0(x)
y = -besselj(1,x);
end

function y = H0(x)
y = besselh(0,x);
end

function y = dH0(x)
y = -besselh(1,x);
end


function R = WireR(rWire,lenSegment,conductivityIn,mi)
omegaF = 0.1*2*pi;
R = real(SegmentDescrACInside(rWire,lenSegment,conductivityIn,mi,omegaF));
end


% TubeR - funkcja oblicza rezystancję rury
% Parametry: 
% rTubeOut - promień zewnętrzny,  
% len - długość rury, 
% con - przewodność elektryczna rury

function R = TubeR(rTubeIn,thickTube,len,conOut,miTube)
omegaF = 2*pi*0.1;
R = real(ZtubeOutApp(rTubeIn,thickTube,len,conOut,miTube,omegaF));
end

% CoaxC - funkcja oblicza pojemność przewodu współosiowego 
% Parametry: 
% rWire - promień wewnętrznego przewodu, 
% rTubeIn - promień wewnętrzny zewnętrznej rury, 
% len - długość przewodu, 
% epsylon- przenikalność elektryczna izolatora

function C = CoaxC(rWire,rTubeIn,len,epsylon) 
epsylon_0 = 8.854187e-12;
C = len*2*pi*epsylon_0*epsylon/log(rTubeIn/rWire);
end

% CoaxLout - funkcja oblicza indukcyjność zewnętrzną przewodu współosiowego 
% Parametry: 
% rWire - promień wewnętrznego przewodu, 
% rTubeIn - promień wewnętrzny zewnętrznej rury, 
% len - długość przewodu,
% mi - przenikalność magnetyczna izolatora

function L = CoaxLout(rWire,rTubeIn,len,mi)
mi_0 = 4*pi*1e-7;
L = len*mi_0*mi*log(rTubeIn/rWire)/(2*pi);
end

% trzeba zamienić TubeR

% SegmentDescrDC - funkcja tworzy model obszaru dla napięcia stałego
% (uwzględnia tylko rezystancję) 
% Parametry: 
% rWire - promień wewnętrznego przewodu, 
% rTubeIn - promień wewnętrzny zewnętrznej rury, 
% thickTube – grubość zewnętrznej rury (obudowy),  
% len - długość przewodu, 
% conIn - przewodność elektryczna przewodu, 
% conOut - przewodność elektryczna rury

function R = SegmentDescrDC(rWire,rTubeIn,thickTube,len,conIn,conOut,miWire,miTube)
R = WireR(rWire,len,conIn,miWire) + TubeR(rTubeIn,rTubeIn+thickTube,len,conOut,miTube);
end

% SegmentDescrACInside - funkcja oblicza impedancję dla przewodu (z wykorzystaniem funkcji Besesla
% Parametry:
% rWire - promień wewnętrznego przewodu,
% lenSegment - długość przewodu,
% conductivityIn - przewodność elektryczna przewodu,
% mi - przenikalność magnetyczna przewodu

function Zin = SegmentDescrACInside(rWire,lenSegment,conductivityIn,mi,omegaF)
mi_0 = 4*pi*1e-7;
ConstA1 = sqrt(-1j*omegaF*mi_0*mi*conductivityIn);
E1 = (-ConstA1)*J0(ConstA1*rWire)/(2*pi*rWire*conductivityIn*dJ0(ConstA1*rWire));
Zin = E1*lenSegment;
end
% definicje funkcji potrzebnych do aproksymacji impedancji obudowy

function wynik = Is_0(gamma,r)
c = transpose([1/8,9/128,75/1024,3675/32768,59535/262144,2401245/4194304,57972915/33554432,13043905875/2147483648,418854310875/17179869184,30241281245175/274877906944,1212400457192925/2199023255552,213786613951685775/70368744177664]);
alpha = gamma/(1+1i);
alpha_x_r = alpha*r;
gamma_x_r = gamma*r;

if alpha_x_r <= 25
    % ar<=25
    wynik = besseli(0,gamma_x_r)*exp(-gamma_x_r);
   elseif alpha_x_r < 50
    % Aprox: NA = 12; 25<ar<50
    wynik = (1/(sqrt(2*pi*gamma_x_r)))*(1 + c(1)/(gamma_x_r) + c(2)/(gamma_x_r)^2 + c(3)/(gamma_x_r)^3 + c(4)/(gamma_x_r)^4 + c(5)/(gamma_x_r)^5 + c(6)/(gamma_x_r)^6 + c(7)/(gamma_x_r)^7 + c(8)/(gamma_x_r)^8 + c(9)/(gamma_x_r)^9 + c(10)/(gamma_x_r)^10 + c(11)/(gamma_x_r)^11 + c(12)/(gamma_x_r)^12);
    elseif alpha_x_r < 100
    % Aprox: NA = 9; 50<=ar<100
    wynik = (1/(sqrt(2*pi*gamma_x_r)))*(1 + c(1)/(gamma_x_r) + c(2)/(gamma_x_r)^2 + c(3)/(gamma_x_r)^3 + c(4)/(gamma_x_r)^4 + c(5)/(gamma_x_r)^5 + c(6)/(gamma_x_r)^6 + c(7)/(gamma_x_r)^7 + c(8)/(gamma_x_r)^8 + c(9)/(gamma_x_r)^9);
    elseif alpha_x_r < 300
    % Aprox: NA = 7; 100<=ar<300
    wynik = (1/(sqrt(2*pi*gamma_x_r)))*(1 + c(1)/(gamma_x_r) + c(2)/(gamma_x_r)^2 + c(3)/(gamma_x_r)^3 + c(4)/(gamma_x_r)^4 + c(5)/(gamma_x_r)^5 + c(6)/(gamma_x_r)^6 + c(7)/(gamma_x_r)^7);
    elseif alpha_x_r < 10000
    % Aprox: NA = 5; 300<=ar<10 000
    wynik = (1/(sqrt(2*pi*gamma_x_r)))*(1 + c(1)/(gamma_x_r) + c(2)/(gamma_x_r)^2 + c(3)/(gamma_x_r)^3 + c(4)/(gamma_x_r)^4 + c(5)/(gamma_x_r)^5);
else
    % Aprox: NA = 3; ar>=10 000
    wynik = (1/(sqrt(2*pi*gamma_x_r)))*(1 + c(1)/(gamma_x_r) + c(2)/(gamma_x_r)^2 + c(3)/(gamma_x_r)^3);
end

end

function wynik = Is_1(gamma,r)
d = transpose([3/8,15/128,105/1024,4725/32768,72765/262144,2837835/4194304,66891825/33554432,14783093325/2147483648,468131288625/17179869184,33424574007825/274877906944,1327867167401775/2199023255552,232376754295310625/70368744177664]);
alpha = gamma/(1+1i);
alpha_x_r = alpha*r;
gamma_x_r = gamma*r;

if alpha_x_r <= 25
    % ar<=25
    wynik = besseli(1,gamma_x_r)*exp(-gamma_x_r);
    elseif alpha_x_r < 50
    % Aprox: NA = 12; 25<ar<50
    wynik = (1/(sqrt(2*pi*gamma_x_r)))*(1 - d(1)/(gamma_x_r) - d(2)/(gamma_x_r)^2 - d(3)/(gamma_x_r)^3 - d(4)/(gamma_x_r)^4 - d(5)/(gamma_x_r)^5 - d(6)/(gamma_x_r)^6 - d(7)/(gamma_x_r)^7 - d(8)/(gamma_x_r)^8 - d(9)/(gamma_x_r)^9 - d(10)/(gamma_x_r)^10 - d(11)/(gamma_x_r)^11 - d(12)/(gamma_x_r)^12);
    elseif alpha_x_r < 100
    % Aprox: NA = 9; 50<=ar<100
    wynik = (1/(sqrt(2*pi*gamma_x_r)))*(1 - d(1)/(gamma_x_r) - d(2)/(gamma_x_r)^2 - d(3)/(gamma_x_r)^3 - d(4)/(gamma_x_r)^4 - d(5)/(gamma_x_r)^5 - d(6)/(gamma_x_r)^6 - d(7)/(gamma_x_r)^7 - d(8)/(gamma_x_r)^8 - d(9)/(gamma_x_r)^9);
    elseif alpha_x_r < 300
    % Aprox: NA = 7; 100<=ar<300
    wynik = (1/(sqrt(2*pi*gamma_x_r)))*(1 - d(1)/(gamma_x_r) - d(2)/(gamma_x_r)^2 - d(3)/(gamma_x_r)^3 - d(4)/(gamma_x_r)^4 - d(5)/(gamma_x_r)^5 - d(6)/(gamma_x_r)^6 - d(7)/(gamma_x_r)^7);
    elseif alpha_x_r < 10000
    % Aprox: NA = 5; 300<=ar<10 000
    wynik = (1/(sqrt(2*pi*gamma_x_r)))*(1 - d(1)/(gamma_x_r) - d(2)/(gamma_x_r)^2 - d(3)/(gamma_x_r)^3 - d(4)/(gamma_x_r)^4 - d(5)/(gamma_x_r)^5);
else
   % Aprox: NA = 3; ar>=10 000
   wynik = (1/(sqrt(2*pi*gamma_x_r)))*(1 - d(1)/(gamma_x_r) - d(2)/(gamma_x_r)^2 - d(3)/(gamma_x_r)^3);
end


end

function wynik = Ks_0(gamma,r)
c = transpose([1/8,9/128,75/1024,3675/32768,59535/262144,2401245/4194304,57972915/33554432,13043905875/2147483648,418854310875/17179869184,30241281245175/274877906944,1212400457192925/2199023255552,213786613951685775/70368744177664]);
alpha = gamma/(1+1i);
alpha_x_r = alpha*r;
gamma_x_r = gamma*r;

if alpha_x_r <= 25
    % ar<=25
    wynik = besselk(0,gamma_x_r)*exp(gamma_x_r);
    elseif alpha_x_r < 50
    % Aprox: NA = 12; 25<ar<50
    wynik = (sqrt(pi/(2*gamma_x_r)))*(1 - c(1)/(gamma_x_r) + c(2)/(gamma_x_r)^2 - c(3)/(gamma_x_r)^3 + c(4)/(gamma_x_r)^4 - c(5)/(gamma_x_r)^5 + c(6)/(gamma_x_r)^6 - c(7)/(gamma_x_r)^7 + c(8)/(gamma_x_r)^8 - c(9)/(gamma_x_r)^9 + c(10)/(gamma_x_r)^10 - c(11)/(gamma_x_r)^11 + c(12)/(gamma_x_r)^12);
    elseif alpha_x_r < 100
    % Aprox: NA = 9; 50<=ar<100
    wynik = (sqrt(pi/(2*gamma_x_r)))*(1 - c(1)/(gamma_x_r) + c(2)/(gamma_x_r)^2 - c(3)/(gamma_x_r)^3 + c(4)/(gamma_x_r)^4 - c(5)/(gamma_x_r)^5 + c(6)/(gamma_x_r)^6 - c(7)/(gamma_x_r)^7 + c(8)/(gamma_x_r)^8 - c(9)/(gamma_x_r)^9);
    elseif alpha_x_r < 300
    % Aprox: NA = 7; 100<=ar<300
    wynik = (sqrt(pi/(2*gamma_x_r)))*(1 - c(1)/(gamma_x_r) + c(2)/(gamma_x_r)^2 - c(3)/(gamma_x_r)^3 + c(4)/(gamma_x_r)^4 - c(5)/(gamma_x_r)^5 + c(6)/(gamma_x_r)^6 - c(7)/(gamma_x_r)^7);
    elseif alpha_x_r < 10000
    % Aprox: NA = 5; 300<=ar<10 000
    wynik = (sqrt(pi/(2*gamma_x_r)))*(1 - c(1)/(gamma_x_r) + c(2)/(gamma_x_r)^2 - c(3)/(gamma_x_r)^3 + c(4)/(gamma_x_r)^4 - c(5)/(gamma_x_r)^5);
else
    % Aprox: NA = 3; ar>=10 000
    wynik = (sqrt(pi/(2*gamma_x_r)))*(1 - c(1)/(gamma_x_r) + c(2)/(gamma_x_r)^2 - c(3)/(gamma_x_r)^3);
end

end

function wynik = Ks_1(gamma,r)
d = transpose([3/8,15/128,105/1024,4725/32768,72765/262144,2837835/4194304,66891825/33554432,14783093325/2147483648,468131288625/17179869184,33424574007825/274877906944,1327867167401775/2199023255552,232376754295310625/70368744177664]);
alpha = gamma/(1+1i);
alpha_x_r = alpha*r;
gamma_x_r = gamma*r;

if alpha_x_r <= 25
    % Aprox: integral; ar<=25
    wynik = besselk(1,gamma_x_r)*exp(gamma_x_r);
    elseif alpha_x_r < 50
    % Aprox: NA = 12; 25<ar<50
    wynik = (sqrt(pi/(2*gamma_x_r)))*(1 + d(1)/(gamma_x_r) - d(2)/(gamma_x_r)^2 + d(3)/(gamma_x_r)^3 - d(4)/(gamma_x_r)^4 + d(5)/(gamma_x_r)^5 - d(6)/(gamma_x_r)^6 + d(7)/(gamma_x_r)^7 - d(8)/(gamma_x_r)^8 + d(9)/(gamma_x_r)^9 - d(10)/(gamma_x_r)^10 + d(11)/(gamma_x_r)^11 - d(12)/(gamma_x_r)^12);
    elseif alpha_x_r < 100
    % Aprox: NA = 9; 50<=ar<100
    wynik = (sqrt(pi/(2*gamma_x_r)))*(1 + d(1)/(gamma_x_r) - d(2)/(gamma_x_r)^2 + d(3)/(gamma_x_r)^3 - d(4)/(gamma_x_r)^4 + d(5)/(gamma_x_r)^5 - d(6)/(gamma_x_r)^6 + d(7)/(gamma_x_r)^7 - d(8)/(gamma_x_r)^8 + d(9)/(gamma_x_r)^9);
    elseif alpha_x_r < 300
    % Aprox: NA = 7; 100<=ar<300
    wynik = (sqrt(pi/(2*gamma_x_r)))*(1 + d(1)/(gamma_x_r) - d(2)/(gamma_x_r)^2 + d(3)/(gamma_x_r)^3 - d(4)/(gamma_x_r)^4 + d(5)/(gamma_x_r)^5 - d(6)/(gamma_x_r)^6 + d(7)/(gamma_x_r)^7);
    elseif alpha_x_r < 10000
    % Aprox: NA = 5; 300<=ar<10 000
    wynik = (sqrt(pi/(2*gamma_x_r)))*(1 + d(1)/(gamma_x_r) - d(2)/(gamma_x_r)^2 + d(3)/(gamma_x_r)^3 - d(4)/(gamma_x_r)^4 + d(5)/(gamma_x_r)^5);
else
    % Aprox: NA = 3; ar>=10 000
    wynik = (sqrt(pi/(2*gamma_x_r)))*(1 + d(1)/(gamma_x_r) - d(2)/(gamma_x_r)^2 + d(3)/(gamma_x_r)^3);
end

end

% ZtubeOutApp - funkcja oblicza impedancję przewodu powrotnego (ekranu). 
% Obliczenia są przeprowadzane z wykorzystaniem modelu przybliżonego. 
% Parametry: 
% rTubeIn - promień wewnętrzny zewnętrznej rury, 
% thickTube – grubość zewnętrznej rury (obudowy),  
% lenSegment - długość przewodu, 
% conductivityOut - przewodność elektryczna rury,
% mi - przenikalność magnetyczna rury

function Zout = ZtubeOutApp(rTubeIn,thickTube,lenSegment,conductivityOut,mi,omegaF)
mi_0 = 4*pi*1e-7;
gamma = sqrt(1i*omegaF*mi*mi_0*conductivityOut);
r1 = rTubeIn;
r2 = rTubeIn + thickTube;

Zout = (-gamma/(2*pi*conductivityOut*r1)*((Is_0(gamma,r1)*Ks_1(gamma,r2)*exp(gamma*(r1 - r2)) + Is_1(gamma,r2)*Ks_0(gamma,r1)*exp(gamma*(r2 - r1)))/(Is_1(gamma,r1)*Ks_1(gamma,r2)*exp(gamma*(r1 - r2)) - Is_1(gamma,r2)*Ks_1(gamma,r1)*exp(gamma*(r2 - r1)))))*lenSegment;

end

% SegmentDescrACTransmissionLine - funkcja wyznacza macierz Ai opisującą czwórnik, 
% z wykorzystaniem teorii linii długiej 
% Parametry: 
% lineZ – impedancja obszaru, 
% lineC – pojemność pomiędzy przewodem środkowym a obudową 

function Ai = SegmentDescrACTransmissionLine(lineZ,lineC,omegaF)
lineGamma = sqrt((lineZ)*(1j*omegaF*lineC));
lineZ0 = sqrt((lineZ)/(1j*omegaF*lineC));
Ai = [cosh(lineGamma), lineZ0*sinh(lineGamma); sinh(lineGamma)/lineZ0, cosh(lineGamma)];
end

% SegmentDescrAC - funkcja oblicza impedancje AC obszaru (przewód środkowy + obudowa). 
% Parametry: 
% rWire - promień wewnętrznego przewodu, 
% rTubeIn - promień wewnętrzny zewnętrznej rury, 
% thickTube – grubość zewnętrznej rury (obudowy),  
% lenSegment - długość przewodu, 
% conductivityIn - przewodność elektryczna przewodu, 
% conductivityOut - przewodność elektryczna rury 
% miIn - przenikalność magnetyczna przewodu, 
% miCenter - przenikalność magnetyczna ośrodka pomiędzy
% przewodem środkowym a ekranem, 
% miOut - przenikalność magnetyczna rury (obudowy)

function Z = SegmentDescrAC( rWire, rTubeIn, thickTube, lenSegment, conductivityIn, conductivityOut, epsylonCenter, miIn, miCenter, miOut, omegaF)
lineZInside = SegmentDescrACInside(rWire,lenSegment,conductivityIn,miIn,omegaF);
lineZOutsize = ZtubeOutApp(rTubeIn,thickTube,lenSegment,conductivityOut,miOut,omegaF);
lineZ = lineZInside + lineZOutsize + 1j*omegaF*CoaxLout(rWire,rTubeIn,lenSegment,miCenter);  
lineC = CoaxC(rWire,rTubeIn,lenSegment,epsylonCenter);
Z = SegmentDescrACTransmissionLine(lineZ,lineC,omegaF);
end

% ponieważ impedancja RacDisk nie jest zbieżna z rezystancją, 
% rezystancję dysku wyznaczamy z pomocą funkcji ZacDisk dla 
% częstotliwości 1 Hz 
% Parametry: 
% rIn – średnica wewnętrzna dysku, 
% rOut - średnica zewnętrzna dysku, 
% thick – grubość dysku, 
% con – przewodność elektryczna dysku

function R = RDisk(rIn,rOut,thick,con)
mi_0 = 4*pi*1e-7;
R = real((1 + 1j)/(2*pi)*sqrt(pi*mi_0/con)*log(rOut/rIn)*coth((1+1j)*thick*sqrt(pi*mi_0*con)));
end

% impedancja dysku zakończającego obudowę 
% Parametry: 
% rIn – średnica wewnętrzna dysku, 
% rOut - średnica zewnętrzna dysku, 
% thick – grubość dysku, 
% con – przewodność elektryczna dysku

function Z = ZacDisk(rIn,rOut,thick,con,mi,freq)
mi_0 = 4*pi*1e-7;
skinDeep = 1/sqrt(pi*mi*mi_0*con*freq);
Z = (1+1j)/(2*pi)*sqrt(pi*mi*mi_0*freq/con)*log(rOut/rIn)*coth((1+1j)*thick/skinDeep);
end

% NConnectorsWithTee - funkcja wyznacza macierz opisującą czwórnik który modeluje złącze 
% wejściowe oraz komercyjny trójnik

function At = NConnectorsWithTee(radiusNpin_,radiusNtubeTef_,radiusNtubeAir_,thickTubeSectionTeflon_,thickTubeSectionAir_,lenSectionTefM_,lenSectionTefF_,lenSectionAir_,conNinternal_,conNtube_,epsylonTeflon_,epsylonAir_,miTube_,miTeflon_,miAir_,miNinternal_,miNtube_,omegaF_)

radiusNpin = radiusNpin_;
radiusNtubeTef = radiusNtubeTef_;
radiusNtubeAir = radiusNtubeAir_;
thickTubeSectionTeflon = thickTubeSectionTeflon_;
thickTubeSectionAir = thickTubeSectionAir_;
lenSectionTefM = lenSectionTefM_;
lenSectionTefF = lenSectionTefF_;
lenSectionAir = lenSectionAir_;
conNinternal = conNinternal_;
conNtube = conNtube_;
epsylonTeflon = epsylonTeflon_;
epsylonAir = epsylonAir_;
miTube = miTube_;
miTeflon = miTeflon_;
miAir = miAir_;
miNinternal = miNinternal_;
miNtube = miNtube_;
omegaF = omegaF_;
RconTeeNM = SegmentDescrDC(radiusNpin,radiusNtubeTef,thickTubeSectionTeflon,lenSectionTefM,conNinternal,conNtube,miNinternal,miNtube);
RconN2 = SegmentDescrDC(radiusNpin,radiusNtubeAir,thickTubeSectionAir,lenSectionAir,conNinternal,conNtube,miNinternal,miNtube);
RconNF = SegmentDescrDC(radiusNpin,radiusNtubeTef,thickTubeSectionTeflon,lenSectionTefF,conNinternal,conNtube,miNinternal,miNtube);
AacConTeeNM = SegmentDescrAC(radiusNpin,radiusNtubeTef,thickTubeSectionTeflon,lenSectionTefM,conNinternal,conNtube,epsylonTeflon,miTube,miTeflon,miTube,omegaF);
AacConN2 = SegmentDescrAC(radiusNpin,radiusNtubeAir,thickTubeSectionAir,lenSectionAir,conNinternal,conNtube,epsylonAir,miTube,miAir,miTube,omegaF);
AacConNF = SegmentDescrAC(radiusNpin,radiusNtubeTef,thickTubeSectionTeflon,lenSectionTefF,conNinternal,conNtube,epsylonTeflon,miTube,miTeflon,miTube,omegaF);
At = {RconTeeNM+RconN2+RconNF,AacConTeeNM*AacConN2*AacConNF}; % tablica komórkowa ~ MPe
end

% wczytanie stablicowanych wartości impedancji dumetu
function y = dumetRe(x)
dane = readmatrix("C:\Users\wrona\Desktop\Skrypt_26_czerwca\DumetRe_100MHz.csv");
f = dane(:,1);
R = dane(:,2);
y = interp1(f,R,x,"spline");
end

function y = dumetIm(x)
dane = readmatrix("C:\Users\wrona\Desktop\Skrypt_26_czerwca\DumetIm_100MHz.csv");
f = dane(:,1);
L = dane(:,2);
y = interp1(f,L,x,"spline");
end

% dumetZ - funkcja wyznaczająca impedancję odcinka dumetu 
% Parametry : 
% len – długość przewodu

function Z = dumetZ(len,freq)
Z = len*(dumetRe(freq)*1e-3 + 1j*2*pi*freq*dumetIm(freq)*1e-9);
end

% Funkcja wyznaczająca rezystancję odcinka dumetu 
% Parametry : 
% len – długość przewodu

function R = DumetRdc(len)
R = 0.429215548*len;
end