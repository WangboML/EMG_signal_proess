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

% original signal frequency spectrum
fs=2500;
Ndata=number;
N=2^nextpow2(Ndata);
n=0:Ndata-1;
y=fft(raw_data,N);
mag=abs(y);
f=(0:N-1)*fs/N;
subplot(221);
plot(raw_data);
subplot(222)
plot(f(1:N/2),mag(1:N/2)*2/N);
%----------------------highpass filter
raw_data=wavefilter(raw_data,'db6',8,[1,2,3,4,5,6,7,8],0);

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
%.............................power-line interference filter








