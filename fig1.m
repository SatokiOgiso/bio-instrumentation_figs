%生体計測レポートFig.1生成用プログラム

clear all
close all

dt = 1e-5; %シミュレーションの時間刻み(s)
signal_length = 0.2; % (s)
uchirp_length = 0.05; %ダウンチャープの掃引時間(s)
dchirp_length = 0.08; % アップチャープの掃引時間(s)
utime = 0:dt:uchirp_length; %
dtime = 0:dt:dchirp_length;
f0 = 1e1; %掃引周波数　(Hz)
f1 = 500e1; %掃引周波数　(Hz)
tstart = 0.025; % チャープ波送信開始時刻 (s)

uchirp = chirp(utime, f0, uchirp_length, f1); %送信波1波を生成
dchirp = chirp(dtime, f1, dchirp_length, f0); %送信波1波を生成

uchirp2 = [uchirp, uchirp];%ドップラー効果計測のため2波にする
dchirp2 = [dchirp, dchirp];%ドップラー効果計測のため2波にする

signal_m = zeros(1,ceil(signal_length/dt));
signal_b = zeros(1,ceil(signal_length/dt));
stime = (1:ceil(signal_length/dt))*dt;

tstart_index = floor(tstart/dt); %送信開始時刻のインデックス
signal_m(tstart_index:tstart_index + length(uchirp2)-1) = uchirp2;
signal_b(tstart_index:tstart_index + length(dchirp2)-1) = dchirp2;

signal_received = signal_b + signal_m; % 簡単のため受信信号はこれらの和と仮定

figure()
subplot(511)
plot(stime,signal_m, 'r');
ylabel( {'transmitted', 'M-mode signal'}, 'FontName','Times','FontSize',16 );
subplot(512)
plot(stime,signal_b);
ylabel( {'transmitted', 'B-mode signal'}, 'FontName','Times','FontSize',16 );
subplot(513)
plot(stime,signal_received );
ylabel( {'simulated', ' received signal'}, 'FontName','Times','FontSize',16 ); 
subplot(514)
compressed_m = xcorr(signal_received , uchirp);
plot(stime,compressed_m(length(signal_m):length(compressed_m)), 'r')%パルス圧縮結果の表示
ylabel( {'Compressed', ' M-mode signal'}, 'FontName','Times','FontSize',16 ); 
subplot(515)
compressed_b = xcorr(signal_received , dchirp);
plot(stime,compressed_b(length(signal_b):length(compressed_b)))%パルス圧縮結果の表示
xlabel( 'Time', 'FontName','Times','FontSize',16 ); 
ylabel( {'Compressed', ' B-mode signal'}, 'FontName','Times','FontSize',16 ); 
