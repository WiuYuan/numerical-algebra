function [poi] = CG(poi, res, para)
%Uzawa方法中求解方程精确解的共轭梯度法
b_norm = sqrt(sum(sum(res.f.^2))+sum(sum(res.g.^2)));
Ax = CG_times(poi, para);
res.f = res.f - Ax.f;
res.g = res.g - Ax.g;
rho = sum(sum(res.f.^2))+sum(sum(res.g.^2));
for k = 1: para.CG_max_size
    if sqrt(rho) / b_norm <= para.CG_eps
        break
    end
    if k == 1
        p = res;
    else
        beta = rho / rho_hat;
        p.f = res.f + beta * p.f;
        p.g = res.g + beta * p.g;
    end
    pp.u = p.f;
    pp.v = p.g;
    w = CG_times(pp, para);
    ptw = sum(sum(p.f.*w.f+p.g.*w.g));
    alpha = rho / ptw;
    poi.u = poi.u + alpha * pp.u;
    poi.v = poi.v + alpha * pp.v;
    res.f = res.f - alpha * w.f;
    res.g = res.g - alpha * w.g;
    rho_hat = rho;
    rho = sum(sum(res.f.*res.f+res.g.*res.g));
end
end

