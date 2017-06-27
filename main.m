%read txt.file
close all;
clc;
clear;
a=textread('data2.txt','%s')';
long=length(a);
number=floor((long-2)/4);
raw_data=zeros(1,number);
for num=0:number-1
    raw_data_str=[a{1,3+num*4} a{1,4+num*4}];
    raw_data(num+1)=hex2dec(raw_data_str);
end

%....................highpass
% Hd=highpass;        %高通滤波：去除2Hz以下频率
% raw_data=filter(Hd,raw_data);      %l: 经过2Hz高通后的时域信号
%...................low___filter__wavelet
raw_data=wavefilter(raw_data,'db6',8,[1,2,3,4,5,6,7,8],0);


%.......................lowpass

Wn=0.4;
[Bb,Ba]=butter(4,Wn,'low'); % MATLAB butter
[BH,BW]=freqz(Bb,Ba); 
raw_data=filter(Bb,Ba,raw_data); 



fs=2500;
Ndata=number;
N=2^nextpow2(Ndata);
n=0:Ndata-1;
y=fft(raw_data,N);
mag=abs(y);
f=(0:N-1)*fs/N;
subplot(221);
plot(raw_data);
subplot(222);
plot(f(1:N/2),mag(1:N/2)*2/N);


%...........................power_line filter
fg=0;
for a=1:10
    fg=fg+50;
    fg1=fg-0.2;
    fg2=fg+1;
    [raw_data,fre_data]=power_line_filter(fg1,fg2,y,N,f,number);
    y=fre_data;
end

fs=2500;
Ndata=number;
N=2^nextpow2(Ndata);
n=0:Ndata-1;
y=fft(raw_data,N);
mag=abs(y);
f=(0:N-1)*fs/N;
subplot(223);
plot(raw_data);
subplot(224);
plot(f(1:N/2),mag(1:N/2)*2/N);





