function [poi1] = Btimes(poi)
%为了计算特征值的辅助函数
p = poi.p;
N = length(p);
u = zeros(N);
v = zeros(N);
h = 1 / N;
for i = 1: N
    for j = 1: N
        if i < N && j < N
            u(i,j) = 0;
            v(i,j) = 0;
        end
        if i == N && j < N
            u(i,j) = 0;
            v(i,j) = -(p(i,j)-p(i,j+1))/h;
        end
        if i < N && j == N
            u(i,j) = -(p(i,j)-p(i+1,j))/h;
            v(i,j) = 0;
        end
        if i < N && j < N
            u(i,j) = -(p(i,j)-p(i+1,j))/h;
            v(i,j) = -(p(i,j)-p(i,j+1))/h;
        end
    end
end
poi1.f = u;
poi1.g = v;
end

