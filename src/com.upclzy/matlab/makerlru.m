function [rl,ru] = makerlru(maxnum)
%   ����������������� rl < ru
%   maxnum  input  �����
%   rl      output С�����
%   ru      output �������
r1 =randi(maxnum);
r2 =randi(maxnum);
while r2 ==r1
r2 = randi(maxnum);
end
rl = min([r1,r2]);
ru = max([r1,r2]);
end