function spop = selection(pop, fitness)
% ���̶�ѡ��
% pop      input  ��Ⱥ
% fitness  input  ��Ӧ��ֵ
% spop     output ѡ������ɵ���Ⱥ
[popsize, piecesize] = size(pop);
spop = zeros(popsize, piecesize);
sumfit = sum(fitness);
fitness = fitness ./ sumfit;
fitness = cumsum(fitness);
r = rand(1, popsize);
r = sort(r);
j = 1;
for i = 1:popsize
    while fitness(j)< r(i)
        j = j + 1;
    end
    spop(i, :) =pop(j, :);
end
% �����������̶ķ��������ԣ�һ������������λ�ö���ظ������������
rr = randperm(popsize);
spop(:, :) = spop(rr, :);
end