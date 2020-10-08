clc,clear,close all

% �豸�ӹ�ʱ��
piecetime = [2 4 6; 4 9 2; 4 2 8; 9 5 6; 5 2 7; 9 4 3];
equsize = [2 2 2];                  % ÿ�������豸��Ŀ
piecesize = size(piecetime, 1);     % ������Ŀ
prosize = size(piecetime, 2);       % ������Ŀ
popsize = 200;      % ��Ⱥ��ģ
cr = 0.6;          % �������
mr = 0.05;         % �������
maxgen = 100;      % ��������

bestobjvalue = zeros(1, maxgen);
bestpop = zeros(maxgen, piecesize);
avgobjvalue = zeros(1, maxgen);
bestptr = cell(1, maxgen);
bestper = cell(1, maxgen);
pop = initpop(popsize, piecesize);

for gen = 1:maxgen
    [objvalue, ptr,per] = calobjvalue(pop, piecetime, equsize);
    [bobjvalue,bindex] = min(objvalue);
    bestobjvalue(1,gen) = bobjvalue;
    bestpop(gen, :) =pop(bindex, :);
    avgobjvalue(1,gen) = sum(objvalue) / popsize;
    bestptr{1, gen} =ptr{1, bindex};
    bestper{1, gen} =per{1, bindex};
    fitness= calfitness(objvalue);     % ������Ӧ��ֵ
    pop =selection(pop, fitness);      % ѡ��
    pop =crossover(pop, cr);           % ����
    pop =mutation(pop, mr);            % ����
end

[~, finalindex] = min(bestobjvalue);
finalptr = bestptr{1, finalindex};
finalper = bestper{1, finalindex};

Time=['��ǰ���ʱ�䣺',num2str(max(max(finalptr)))];
disp(Time);
Order=['��ǰ���˳��',num2str(bestpop(finalindex, :))];
disp(Order);

% disp(bestpop(finalindex, :));
% gantt = makegantt(finalptr, finalper, equsize);
% figure(1);
% imagesc(gantt);
% colorbar;
% title("�ӹ�����ͼ");
% figure(2);
% plot(1:maxgen, bestobjvalue);
% title("����ʱ��仯ͼ");
% xlabel("����"); ylabel("����ʱ��");
% figure(3);
% plot(1:maxgen, avgobjvalue);
% title("ƽ��ʱ��仯ͼ");
% xlabel("����"); ylabel("ƽ��ʱ��");