%���̌v�����|�[�gFig.1�����p�v���O����

clear all
close all

dt = 1e-5; %�V�~�����[�V�����̎��ԍ���(s)
signal_length = 0.2; % (s)
uchirp_length = 0.05; %�_�E���`���[�v�̑|������(s)
dchirp_length = 0.08; % �A�b�v�`���[�v�̑|������(s)
utime = 0:dt:uchirp_length; %
dtime = 0:dt:dchirp_length;
f0 = 1e1; %�|�����g���@(Hz)
f1 = 500e1; %�|�����g���@(Hz)
tstart = 0.025; % �`���[�v�g���M�J�n���� (s)

uchirp = chirp(utime, f0, uchirp_length, f1); %���M�g1�g�𐶐�
dchirp = chirp(dtime, f1, dchirp_length, f0); %���M�g1�g�𐶐�

uchirp2 = [uchirp, uchirp];%�h�b�v���[���ʌv���̂���2�g�ɂ���
dchirp2 = [dchirp, dchirp];%�h�b�v���[���ʌv���̂���2�g�ɂ���

signal_m = zeros(1,ceil(signal_length/dt));
signal_b = zeros(1,ceil(signal_length/dt));
stime = (1:ceil(signal_length/dt))*dt;

tstart_index = floor(tstart/dt); %���M�J�n�����̃C���f�b�N�X
signal_m(tstart_index:tstart_index + length(uchirp2)-1) = uchirp2;
signal_b(tstart_index:tstart_index + length(dchirp2)-1) = dchirp2;

figure()
subplot(511)
plot(stime,signal_m, 'r');
ylabel( {'transmitted', 'M-mode signal'}, 'FontName','Times','FontSize',16 );
subplot(512)
plot(stime,signal_b);
ylabel( {'transmitted', 'B-mode signal'}, 'FontName','Times','FontSize',16 );
subplot(513)
plot(stime,signal_b + signal_m);
ylabel( {'simulated', ' received signal'}, 'FontName','Times','FontSize',16 ); 
subplot(514)
compressed_m = xcorr(signal_m+signal_b, uchirp);
plot(stime,compressed_m(length(signal_m):length(compressed_m)), 'r')%�p���X���k���ʂ̕\��
ylabel( {'Compressed', ' M-mode signal'}, 'FontName','Times','FontSize',16 ); 
subplot(515)
compressed_b = xcorr(signal_m+signal_b, dchirp);
plot(stime,compressed_b(length(signal_b):length(compressed_b)))%�p���X���k���ʂ̕\��
xlabel( 'Time', 'FontName','Times','FontSize',16 ); 
ylabel( {'Compressed', ' B-mode signal'}, 'FontName','Times','FontSize',16 ); 
