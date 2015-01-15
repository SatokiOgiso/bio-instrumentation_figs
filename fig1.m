%生体計測レポートFig.1生成用プログラム

clear all
close all

dt = 1e-5; %シミュレーションの時間刻み(s)
signal_length = 0.5; % (s)
uchirp_length = 0.1; % アップチャープの掃引時間(s)
dchirp_length = 0.05; %ダウンチャープの掃引時間(s)
utime = 0:dt:uchirp_length; %
dtime = 0:dt:dchirp_length;
f0 = 1e1; %掃引周波数　(Hz)
f1 = 100e1; %掃引周波数　(Hz)
tstart = 0.1; % チャープ波送信開始時刻 (s)

uchirp = chirp(utime, f0, uchirp_length, f1); %送信波1波を生成
dchirp = chirp(dtime, f1, dchirp_length, f0); %送信波1波を生成

uchirp2 = [uchirp, uchirp];%ドップラー効果計測のため2波にする
dchirp2 = [dchirp, dchirp];%ドップラー効果計測のため2波にする

signal_m = zeros(1,ceil(signal_length/dt));
signal_b = zeros(1,ceil(signal_length/dt));

tstart_index = floor(tstart/dt); %送信開始時刻のインデックス
signal_m(tstart_index:tstart_index + length(uchirp2)-1) = uchirp2;
signal_b(tstart_index:tstart_index + length(dchirp2)-1) = dchirp2;

figure()
subplot(511)
plot(signal_m, 'r');
subplot(512)
plot(signal_b);
subplot(513)
plot(signal_b + signal_m);
subplot(514)
compressed_m = xcorr(signal_m+signal_b, uchirp);
plot(compressed_m(length(signal_m):length(compressed_m)), 'r')%パルス圧縮結果の表示
subplot(515)
compressed_b = xcorr(signal_m+signal_b, dchirp);
plot(compressed_b(length(signal_b):length(compressed_b)))%パルス圧縮結果の表示


