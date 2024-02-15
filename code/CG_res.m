function [res] = CG_res(poi, res, para)
%计算残量
p = poi.p;
N = length(p);
h = 1 / N;
f = zeros(N);
g = zeros(N);
for i = 1: N
    for j = 1: N
        if i < N && j < N
            f(i,j) = 0;
            g(i,j) = 0;
        end
        if i == N && j < N
            f(i,j) = 0;
            g(i,j) = (p(i,j+1)-p(i,j))/h;
        end
        if i < N && j == N
            f(i,j) = (p(i+1,j)-p(i,j))/h;
            g(i,j) = 0;
        end
        if i < N && j < N
            f(i,j) = (p(i+1,j)-p(i,j))/h;
            g(i,j) = (p(i,j+1)-p(i,j))/h;
        end
        f(i,j) = res.f(i,j) - f(i,j);
        g(i,j) = res.g(i,j) - g(i,j);
    end
end
res.f = f;
res.g = g;
end

