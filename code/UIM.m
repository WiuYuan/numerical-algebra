function [poi] = UIM(para)
N = para.N;
p = zeros(N);
res_init = Residual_init(para);
res = res_init;
nF = sqrt(norm(res.f,'fro')^2+norm(res.g,'fro')^2+norm(res.d,'fro')^2);
poi.u = zeros(N);
poi.v = zeros(N);
poi.p = zeros(N);
h = 1 / N;
for T = 1: 1000
    alpha = para.alpha / (max(T, 50)-49);
    res = CG_res(poi, res_init, para);
    poi = CG(poi, res, para);
    % 压力更新
    for i = 1: N
        for j = 1: N
            if i == 1 && j == 1
                p(i,j) = p(i,j)-alpha*(poi.u(i,j)/h+poi.v(i,j)/h);
            end
            if i == 1 && j > 1
                p(i,j) = p(i,j)-alpha*(poi.u(i,j)/h+(poi.v(i,j)-poi.v(i,j-1))/h);
            end
            if i > 1 && j == 1
                p(i,j) = p(i,j)-alpha*((poi.u(i,j)-poi.u(i-1,j))/h+poi.v(i,j)/h);
            end
            if i > 1 && j > 1
                p(i,j) = p(i,j)-alpha*((poi.u(i,j)-poi.u(i-1,j))/h+ ...
                    (poi.v(i,j)-poi.v(i,j-1))/h);
            end
        end
    end
    poi.p = p;
    res = Residual(poi, res_init, para);
    nr = sqrt(norm(res.f,'fro')^2+norm(res.g,'fro')^2+norm(res.d,'fro')^2);
    if nr / nF <= 1e-8 
        break
    end
end
end