function pop= initpop(popsize, piecesize)
%   ��ʼ����Ⱥ
%   popsize     input ��Ⱥ��ģ
%   piecesize   input ��������
%   pop         output ��Ⱥ
pop =zeros(popsize, piecesize);
for i =1:popsize
    pop(i, :) = randperm(piecesize);
end
end