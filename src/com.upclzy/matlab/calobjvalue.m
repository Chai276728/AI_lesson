function [objvalue, ptr, per] = calobjvalue(pop, piecetime,equsize)
% ����Ŀ�꺯��ֵ
% pop          input  ��Ⱥ
% piecetime    input  �����ӹ�ʱ��
% equsize      input  ÿ�������豸����
% objvalue     output Ŀ�꺯��ֵ���ӹ�ʱ�䣩
% ptr          output �����ӹ�ʱ���¼��cell
% per          output �����ӹ��豸��¼��cell
[popsize, piecesize] = size(pop);
prosize = size(equsize, 2);
objvalue = zeros(popsize, 1);
ptr = cell(1, popsize);
per = cell(1, popsize);
for i = 1:popsize
    pieceweight =pop(i, :);
    % �豸״̬����
    % [����1�豸1����1�豸2 ����2�豸1 ����2�豸2 ����]
    % ��¼��ǰ�豸ʹ�ý���ʱ�䣬Ĭ��Ϊ0��ʾδ��ʼ
    equstu = zeros(1,sum(equsize));
    % ���豸״̬���еĹ���ָ���
    % ���ڵ��ڵ�ǰ�豸��Сֵ�������ǵ�ǰ�豸�����Ĺ���
    % [2 35] ����1��2̨�豸����2��1̨�豸 ����3��2̨�豸
    prosep =cumsum(equsize);
    % ����ʱ���¼����¼ÿ������ÿ������Ŀ�ʼʱ��ͽ���ʱ��
    % �б�ʾ�������������б�ʾ��ʼ�ӹ�ʱ���ֹͣ�ӹ�ʱ��
    % [1 2 2 3; 4 5 67]
    % ��ʾ����1��1����ӹ�ʱ��Ϊ1-2����2����ӹ�ʱ��Ϊ2-3
    % ����2��1����ӹ�ʱ��Ϊ4-5����2����ӹ�ʱ��Ϊ6-7
    piecetimerecord =zeros(piecesize, prosize*2);
    % �����豸��¼����¼ÿ�������ڹ����еļӹ��豸
    % ������ʾ�������б�ʾ�������ÿ������ӹ��豸
    % [1 2; 2 1]
    % ��ʾ����1�ڵ�1����ӹ��豸Ϊ1����2����ӹ��豸Ϊ2
    % ����2�ڵ�1����ӹ��豸Ϊ2����2����ӹ��豸Ϊ1
    pieceequrecord =zeros(piecesize, prosize);
    % ��ÿһ������
    % ����ǵ�1�����򣬶Թ��������ȼ�����
    % ���๤������һ�������깤ʱ��Թ�������
    % ��������ÿһ������
    % �Ըù����п��û�����ʹ�ý���ʱ������
    % ʹ��ʹ�ý���ʱ����С�Ļ���
    % �ӹ���ʼʱ��Ϊmax{�豸ʹ�ý���ʱ��,�����һ�����깤ʱ��}
    % �ӹ�����ʱ��=�ӹ���ʼʱ��+�ӹ�ʱ��
    % ���¸���״̬�ͼ�¼����
    for pro =1:prosize
        if(pro == 1)
            [~,piecelist] = sort(pieceweight);
        else
           tempendtime = piecetimerecord(:, (pro-1)*2);
           tempendtime = tempendtime';
            [~,piecelist] = sort(tempendtime);
        end
        for pieceindex= 1:length(piecelist)
            piece =piecelist(pieceindex);
            equtimelist = equstu(prosep(pro)-equsize(pro)+1:prosep(pro));
            [equtime,equlist] = sort(equtimelist);
            equ =equlist(1);
            if pro ==1
               piecestarttime = 0;
            else
               piecestarttime = piecetimerecord(piece, pro*2-2);
            end
            starttime= max(equtime(1), piecestarttime) + 1;
            endtime =starttime + piecetime(piece, pro) - 1;
            equstuindex = prosep(pro)-equsize(pro)+equ;
            equstu(equstuindex) = endtime;
            piecetimerecord(piece, pro*2-1) = starttime;
            piecetimerecord(piece, pro*2) = endtime;
            pieceequrecord(piece, pro) = equ;
        end
    end
    objvalue(i, 1) =max(max(piecetimerecord));
    ptr{1, i} =piecetimerecord;
    per{1, i} =pieceequrecord;
end
end