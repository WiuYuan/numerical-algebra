function [poi] = find_poi_exact(para)
%找到测试函数对应的方程精确解
func_u = para.func_u;
func_v = para.func_v;
N = para.N;
u = zeros(N);
v = zeros(N);
p = zeros(N);
h = 1 / N;
for i = 1: N
    for j = 1: N
        xi = i * h;
        xi2 = i * h - h / 2;
        yj = j * h;
        yj2 = j * h - h / 2;
        u(i,j) = func_u(xi, yj2);
        v(i,j) = func_v(xi2, yj);
        p(i,j) = func_p(xi2, yj2);
    end
end
poi.u = u;
poi.v = v;
poi.p = p;
end

