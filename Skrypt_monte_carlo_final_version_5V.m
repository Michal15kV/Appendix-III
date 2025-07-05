clear all
clc

run("Parametry_Monte_Carlo_SJTC_Un_5V.m"); % importowanie pliku z parametrami

% Liczba iteracji
M = 1e6;        

% częstotliwości dla których obliczane są wyniki
freq = [10e3, 20e3, 50e3, 70e3, 100e3, 200e3, 500e3, 700e3, 1e6, 2e6, 5e6, 7e6, 10e6, 20e6, 50e6, 70e6, 100e6];
Nfreq = length(freq);

% prealokacja macierzy z wynikami
wyniki = zeros(M, Nfreq);

% prealokacje wektorów z parametrami
epsylonTeflon_set = transpose(zeros(1, M));
conNtube_set = transpose(zeros(1, M));
conNinternal_set = transpose(zeros(1, M));
conDisk_set = transpose(zeros(1, M));
conTube_set = transpose(zeros(1, M));
conCu1p_set = transpose(zeros(1, M));
conConWires_set = transpose(zeros(1, M));
conRangeRes_set = transpose(zeros(1, M));
conSJTCHeater_set = transpose(zeros(1, M));
thickTubeSectionAir_set = transpose(zeros(1, M));
thickTubeSectionTeflon_set = transpose(zeros(1, M));
thickDisk_set = transpose(zeros(1, M));
thickTube_set = transpose(zeros(1, M));
lenSectionAir_set = transpose(zeros(1, M));
lenSectionTefM_set = transpose(zeros(1, M));
lenSectionTefF_set = transpose(zeros(1, M));
lenCu1_set = transpose(zeros(1, M));
lenCu1p_set = transpose(zeros(1, M));
lenRangeRes_set = transpose(zeros(1, M));
lenCu2_set = transpose(zeros(1, M));
lenSjtcL_set = transpose(zeros(1, M));
lenSjtcH_set = transpose(zeros(1, M));
lenCu3_set = transpose(zeros(1, M));
radiusNtubeOuter_set = transpose(zeros(1, M));
radiusNpin_set = transpose(zeros(1, M));
radiusNtubeAir_set = transpose(zeros(1, M));
radiusNtubeTef_set = transpose(zeros(1, M));
radiusTube_set = transpose(zeros(1, M));
radiusCu_set = transpose(zeros(1, M));
radiusRangeRes_set = transpose(zeros(1, M));
radiusCu1p_set = transpose(zeros(1, M));
radiusSjtcL_set = transpose(zeros(1, M));
radiusCu3Pin_set = transpose(zeros(1, M));
zLoad_set = transpose(zeros(1, M));

% parpool('local', 8);  % przygotuj pulę 8 workerów
tic
parfor n = 1:M
    % Losowanie wartości parametrów w zadanych przedziałach
epsylonTeflon_set(n) = epsylonTeflon - epsylonTeflon_delta + 2*rand()*epsylonTeflon_delta;
conNtube_set(n) = conNtube - conNtube_delta + 2*rand()*conNtube_delta;
conNinternal_set(n) = conNinternal - conNinternal_delta + 2*rand()*conNinternal_delta;
conDisk_set(n) = conDisk - conDisk_delta + 2*rand()*conDisk_delta;
conTube_set(n) = conTube - conTube_delta + 2*rand()*conTube_delta;
conCu1p_set(n) = conCu1p - conCu1p_delta + 2*rand()*conCu1p_delta;
conConWires_set(n) = conConWires - conConWires_delta + 2*rand()*conConWires_delta;
conRangeRes_set(n) = conRangeRes - conRangeRes_delta + 2*rand()*conRangeRes_delta;
conSJTCHeater_set(n) = conSJTCHeater - conSJTCHeater_delta + 2*rand()*conSJTCHeater_delta;
thickTubeSectionAir_set(n) = thickTubeSectionAir - thickTubeSectionAir_delta + 2*rand()*thickTubeSectionAir_delta;
thickTubeSectionTeflon_set(n) = thickTubeSectionTeflon - thickTubeSectionTeflon_delta + 2*randn()*thickTubeSectionTeflon_delta;
thickDisk_set(n) = thickDisk - thickDisk_delta + 2*rand()*thickDisk_delta;
thickTube_set(n) = thickTube - thickTube_delta + 2*rand()*thickTube_delta;
lenSectionAir_set(n) = lenSectionAir - lenSectionAir_delta + 2*rand()*lenSectionAir_delta;
lenSectionTefM_set(n) = lenSectionTefM - lenSectionTefM_delta + 2*rand()*lenSectionTefM_delta;
lenSectionTefF_set(n) = lenSectionTefF - lenSectionTefF_delta + 2*rand()*lenSectionTefF_delta;
lenCu1_set(n) = lenCu1 - lenCu1_delta + 2*rand()*lenCu1_delta;
lenCu1p_set(n) = lenCu1p - lenCu1p_delta + 2*rand()*lenCu1p_delta;
lenRangeRes_set(n) = lenRangeRes - lenRangeRes_delta + 2*rand()*lenRangeRes_delta;
lenCu2_set(n) = lenCu2 - lenCu2_delta + 2*rand()*lenCu2_delta;
lenSjtcL_set(n) = lenSjtcL - lenSjtcL_delta + 2*rand()*lenSjtcL_delta;
lenSjtcH_set(n) = lenSjtcH - lenSjtcH_delta + 2*rand()*lenSjtcH_delta;
lenCu3_set(n) = lenCu3 - lenCu3_delta + 2*rand()*lenCu3_delta;
radiusNtubeOuter_set(n) = radiusNtubeOuter - radiusNtubeOuter_delta + 2*rand()*radiusNtubeOuter_delta;
radiusNpin_set(n) = radiusNpin - radiusNpin_delta + 2*rand()*radiusNpin_delta;
radiusNtubeAir_set(n) = radiusNtubeAir - radiusNtubeAir_delta + 2*rand()*radiusNtubeAir_delta;
radiusNtubeTef_set(n) = radiusNtubeTef - radiusNtubeTef_delta + 2*randn()*radiusNtubeTef_delta;
radiusTube_set(n) = radiusTube - radiusTube_delta + 2*rand()*radiusTube_delta;
radiusCu_set(n) = radiusCu - radiusCu_delta + 2*rand()*radiusCu_delta;
radiusCu1p_set(n) = radiusCu1p - radiusCu1p_delta + 2*rand()*radiusCu1p_delta;
radiusRangeRes_set(n) = radiusRangeRes - radiusRangeRes_delta + 2*rand()*radiusRangeRes_delta;
radiusSjtcL_set(n) = radiusSjtcL - radiusSjtcL_delta + 2*rand()*radiusSjtcL_delta;
radiusCu3Pin_set(n) = radiusCu3Pin - radiusCu3Pin_delta + 2*rand()*radiusCu3Pin_delta;
zLoad_set(n) = zLoad - zLoad_delta + 2*rand()*zLoad_delta;

parametry = {conConWires_set(n),conCu1p_set(n),conDisk_set(n),conTube_set(n),conSJTCHeater_set(n),radiusCu_set(n),radiusCu3Pin_set(n),radiusNpin_set(n),radiusNtubeTef_set(n),radiusNtubeAir_set(n),radiusRangeRes_set(n),radiusTube_set(n),radiusSjtcL_set(n),thickDisk_set(n),thickTube_set(n),thickTubeSectionTeflon_set(n),thickTubeSectionAir_set(n),lenCu1_set(n),lenCu1p_set(n),lenCu2_set(n),lenCu3_set(n),lenSjtcL_set(n),lenSjtcH_set(n),lenSectionTefM_set(n),lenSectionTefF_set(n),lenSectionAir_set(n),lenRangeRes_set(n),conNinternal_set(n),conNtube_set(n),conRangeRes_set(n),epsylonTeflon_set(n),epsylonAir,miCopper,miDisk,miHeater,miTube,miTeflon,miAir,miRangeRes,zLoad_set(n),miNinternal,miNtube,radiusCu1p_set(n)};

    % Liczenie wyników dla każdej częstotliwości
    for k = 1:Nfreq
        omega = 2 * pi * freq(k);
        wyniki(n, k) = TransferDiffWSGliwice(parametry{:}, omega, freq(k));
    end
end
toc

wynik_10kHz_av = mean(wyniki(:,1));
wynik_10kHz_std = std(wyniki(:,1));
disp(['δu_10kHz = ','(', num2str(wynik_10kHz_av), ' +/- ', num2str(wynik_10kHz_std),')',' μV/V'])

wynik_20kHz_av = mean(wyniki(:,2));
wynik_20kHz_std = std(wyniki(:,2));
disp(['δu_20kHz = ','(', num2str(wynik_20kHz_av), ' +/- ', num2str(wynik_20kHz_std),')',' μV/V'])

wynik_50kHz_av = mean(wyniki(:,3));
wynik_50kHz_std = std(wyniki(:,3));
disp(['δu_50kHz = ','(', num2str(wynik_50kHz_av), ' +/- ', num2str(wynik_50kHz_std),')',' μV/V'])

wynik_70kHz_av = mean(wyniki(:,4));
wynik_70kHz_std = std(wyniki(:,4));
disp(['δu_70kHz = ','(', num2str(wynik_70kHz_av), ' +/- ', num2str(wynik_70kHz_std),')',' μV/V'])

wynik_100kHz_av = mean(wyniki(:,5));
wynik_100kHz_std = std(wyniki(:,5));
disp(['δu_100kHz = ','(', num2str(wynik_100kHz_av), ' +/- ', num2str(wynik_100kHz_std),')',' μV/V'])

wynik_200kHz_av = mean(wyniki(:,6));
wynik_200kHz_std = std(wyniki(:,6));
disp(['δu_200kHz = ','(', num2str(wynik_200kHz_av), ' +/- ', num2str(wynik_200kHz_std),')',' μV/V'])

wynik_500kHz_av = mean(wyniki(:,7));
wynik_500kHz_std = std(wyniki(:,7));
disp(['δu_500kHz = ','(', num2str(wynik_500kHz_av), ' +/- ', num2str(wynik_500kHz_std),')',' μV/V'])

wynik_700kHz_av = mean(wyniki(:,8));
wynik_700kHz_std = std(wyniki(:,8));
disp(['δu_700kHz = ','(', num2str(wynik_700kHz_av), ' +/- ', num2str(wynik_700kHz_std),')',' μV/V'])

wynik_1MHz_av = mean(wyniki(:,9));
wynik_1MHz_std = std(wyniki(:,9));
disp(['δu_1MHz = ','(', num2str(wynik_1MHz_av), ' +/- ', num2str(wynik_1MHz_std),')',' μV/V'])

wynik_2MHz_av = mean(wyniki(:,10));
wynik_2MHz_std = std(wyniki(:,10));
disp(['δu_2MHz = ','(', num2str(wynik_2MHz_av), ' +/- ', num2str(wynik_2MHz_std),')',' μV/V'])

wynik_5MHz_av = mean(wyniki(:,11));
wynik_5MHz_std = std(wyniki(:,11));
disp(['δu_5MHz = ','(', num2str(wynik_5MHz_av), ' +/- ', num2str(wynik_5MHz_std),')',' μV/V'])

wynik_7MHz_av = mean(wyniki(:,12));
wynik_7MHz_std = std(wyniki(:,12));
disp(['δu_7MHz = ','(', num2str(wynik_7MHz_av), ' +/- ', num2str(wynik_7MHz_std),')',' μV/V'])

wynik_10MHz_av = mean(wyniki(:,13));
wynik_10MHz_std = std(wyniki(:,13));
disp(['δu_10MHz = ','(', num2str(wynik_10MHz_av), ' +/- ', num2str(wynik_10MHz_std),')',' μV/V'])

wynik_20MHz_av = mean(wyniki(:,14));
wynik_20MHz_std = std(wyniki(:,14));
disp(['δu_20MHz = ','(', num2str(wynik_20MHz_av), ' +/- ', num2str(wynik_20MHz_std),')',' μV/V'])

wynik_50MHz_av = mean(wyniki(:,15));
wynik_50MHz_std = std(wyniki(:,15));
disp(['δu_50MHz = ','(', num2str(wynik_50MHz_av), ' +/- ', num2str(wynik_50MHz_std),')',' μV/V'])

wynik_70MHz_av = mean(wyniki(:,16));
wynik_70MHz_std = std(wyniki(:,16));
disp(['δu_70MHz = ','(', num2str(wynik_70MHz_av), ' +/- ', num2str(wynik_70MHz_std),')',' μV/V'])

wynik_100MHz_av = mean(wyniki(:,17));
wynik_100MHz_std = std(wyniki(:,17));
disp(['δu_100MHz = ','(', num2str(wynik_100MHz_av), ' +/- ', num2str(wynik_100MHz_std),')',' μV/V'])

etykiety = {"wynik_10kHz", "wynik_20kHz", "wynik_50kHz","wynik_70kHz","wynik_100kHz","wynik_200kHz","wynik_500kHz","wynik_700kHz","wynik_1MHz","wynik_2MHz","wynik_5MHz","wynik_7MHz","wynik_10MHz","wynik_20MHz","wynik_50MHz","wynik_70MHz","wynik_100MHz"};
wyniki = [wyniki(:,1),wyniki(:,2),wyniki(:,3),wyniki(:,4),wyniki(:,5),wyniki(:,6),wyniki(:,7),wyniki(:,8),wyniki(:,9),wyniki(:,10),wyniki(:,11),wyniki(:,12),wyniki(:,13),wyniki(:,14),wyniki(:,15),wyniki(:,16),wyniki(:,17)];
writecell(etykiety,'C:\Users\wrona\Desktop\Skrypt_26_czerwca\Dane_5V.xlsx','Sheet','Arkusz1','Range','B1');
writematrix(wyniki,'C:\Users\wrona\Desktop\Skrypt_26_czerwca\Dane_5V.xlsx','Sheet','Arkusz1','Range','B2');


errorbar(freq, transpose(mean(wyniki(:,:))),transpose(std(wyniki(:,:))),'o');
set(gca, 'XScale', 'log')
xlabel('Czas [s]')
ylabel('Temperatura [°C]')
title('Pomiar z belkami błędów')
grid on

clf;
errorbar(freq(1:9), transpose(mean(wyniki(:,1:9))),2*transpose(std(wyniki(:,1:9))));
set(gca, 'XScale', 'log')
xlabel('f (kHz)')
ylabel('δu (μV/V)')
title('SJTC Un = 5V')
grid on

hold on % dodanie wyników pomiarów do wykresu
y1 = [ 0.85; 0.01; 0.23; 1.4; 1.6; 2.6; 2.4; 3; 2.6];
err1 = [ 0.68; 0.7; 0.7; 2.2; 2.2; 2.7; 4.7; 4.7; 4.7];
errorbar(freq(1:9), y1, err1);
legend('Wyniki z poprawionego modelu','Wyniki pomiarów')

