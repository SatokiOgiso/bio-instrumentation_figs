
dt = 1e-5;
zero_length = 0.1; % s
chirp_length = 0.1;
time = 0:dt:chirp_length;
f0 = 1e1;
f1 = 5e1;

upchirp = chirp(time, f0, chirp_length, f1);
%{
signal_m = [
%}