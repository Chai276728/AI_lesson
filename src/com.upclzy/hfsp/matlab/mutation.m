function mpop = mutation(pop, mr)

% ���죬���������漴λ�õĻ���

% pop      input  ��Ⱥ

% mr       input  �������

% mpop     output �������Ⱥ

[popsize, piecesize] = size(pop);

mpop = pop;

for i = 1:popsize

    if rand > mr

        continue;

    end

    r1 = randi(piecesize);

    r2 = randi(piecesize);

    temp  = mpop(i, r1);

    mpop(i, r1) = mpop(i, r2);

    mpop(i, r2) = temp;

end

end