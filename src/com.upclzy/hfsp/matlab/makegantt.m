function gantt = makegantt(ptr, per, equsize)
%   �����ӹ����̾���
%   ptr     input  ����ʱ���¼
%   per     input  �����豸��¼
%   equsize input  �����豸����
%   gantt   output �ӹ����̾���
finaltime =max(max(ptr));
[piecesize,prosize] = size(per);
cumsumequ =cumsum(equsize);
gantt =zeros(sum(equsize), finaltime);
for pro =1:prosize
for i = 1:piecesize
if pro == 1
equ = per(i, pro);
else
equ = cumsumequ(pro - 1) + per(i,pro);
end
starttime = ptr(i, pro*2-1);
endtime = ptr(i, pro*2);
gantt(equ, starttime:endtime) = i;
end
end
end