function [res] = Residual_init(para)
%计算初始的F=(f,g)
func_f = para.func_f;
func_g = para.func_g;
func_b = para.func_b;
func_l = para.func_l;
func_t = para.func_t;
func_r = para.func_r;
N = para.N;
f = zeros(N);
g = zeros(N);
h = 1 / N;
for i = 1: N
    for j = 1: N
        xi = i * h;
        xi2 = i * h - h / 2;
        yj = j * h;
        yj2 = j * h - h / 2;
        if i == 1 && j == 1
            f(i,j) = func_f(xi, yj2) + func_b(xi) / h;
            g(i,j) = func_g(xi2, yj) + func_l(yj) / h;
        end
        if i == 1 && j == N
            f(i,j) = func_f(xi, yj2) + func_t(xi) / h;
            g(i,j) = 0;
        end
        if i == N && j == 1
            f(i,j) = 0;
            g(i,j) = func_g(xi2, yj) + func_r(yj) / h;
        end
        if i == N && j == N
            f(i,j) = 0;
            g(i,j) = 0;
        end
        if i > 1 && i < N && j == 1
            f(i,j) = func_f(xi, yj2) + func_b(xi) / h;
            g(i,j) = func_g(xi2, yj);
        end
        if i > 1 && i < N && j == N
            f(i,j) = func_f(xi, yj2) + func_t(xi) / h;
            g(i,j) = 0;
        end
        if j > 1 && j < N && i == 1
            f(i,j) = func_f(xi, yj2);
            g(i,j) = func_g(xi2, yj) + func_l(yj) / h;
        end
        if j > 1 && j < N && i == N
            f(i,j) = 0;
            g(i,j) = func_g(xi2, yj) + func_r(yj) / h;
        end
        if i > 1 && i < N && j > 1 && j < N
            f(i,j) = func_f(xi, yj2);
            g(i,j) = func_g(xi2, yj);
        end
    end
end
res.f = f;
res.g = g;
res.d = zeros(N);
end

