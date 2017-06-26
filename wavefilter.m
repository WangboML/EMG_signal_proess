%/////////////////////////////////////////////////
%
%   ����С���˲���������ȥ���ض���details���ؽ��źţ�
%   ���룺data 1*N ,wavename,n(����)��save��Ҫ�����Ľף�,flag(�Ƿ���ײ��ca����)
%   �����output
%
%/////////////////////////////////////////////////

function [output] = wavefilter(data,wavename,n,save,flag)
    [C,L]=wavedec(data,n,wavename);
    %��ȡ�߶�ϵ��
    ca=appcoef(C,L,wavename,n);
    if flag==0
        ca=zeros(1,length(ca));
    end
    
    %��ȡϸ��ϵ��
    for i=1:n
        cd=detcoef(C,L,n+1-i);
        if(ismember(n+1-i,save)==0)
            %��details����
            cd = zeros(1,length(cd));
        end
        ca=[ca cd];
    end
    %�ؽ��ź�
    output=waverec(ca,L,wavename);
end