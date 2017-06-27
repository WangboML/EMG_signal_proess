function [raw_data,fre_data]=power_line_filter(fg1,fg2,y,N,f,number)
fs=2500;
k1=ceil(fg1*N/2500);  %ceil:朝正无穷方向靠近最近的整数
k2=ceil(fg2*N/2500); 
Hw2=[y(1:k1-1) y(k2+1:N)];      %去掉fg1,2之间的频谱
N2=length(Hw2);         
f1=f(1:N2); 
a=k1*fs/N;
b=k2*fs/N;
fi=linspace(a,b,k2-k1+1);
y1=interp1(f1, Hw2,fi, 'linear');   %插值
Hw3=[Hw2(1:k1-1) y1 Hw2(k1:N2)];    %插值后频谱(0-1000)
Hw4=Hw3;

if mod(N,2)==1              %为了得到实信号频谱实部为偶，虚部为奇
    for j=2:(N+1)/2
      
        
        c=real(Hw4(j));     %X(k)=X(N-k)
        d=imag(Hw4(j));
        Hw4(N-j+2)=c-d*1i;
        
    end
else
    for j=2:N/2
        c=real(Hw4(j));
        d=imag(Hw4(j));
        Hw4(N-j+2)=c-d*1i;
      
    end
end
raw_data=ifft(Hw4);
% len=length(raw_data)/2;
raw_data=raw_data(1:number);                %l1插值后时域波形
fs=2500;
Ndata=number;
N=2^nextpow2(Ndata);
n=0:Ndata-1;
fre_data=fft(raw_data,N);
end