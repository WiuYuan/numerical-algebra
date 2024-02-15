function [poi] = CG_Vcycle(poi, res, IUIM_eps, para)
%使用Vcycle作为预条件的共轭梯度法
Ax = CG_times(poi, para);
res.f = res.f - Ax.f;
res.g = res.g - Ax.g;
N = para.N;
for k = 1: 1000
    if sqrt(sum(sum(res.f.^2))+sum(sum(res.g.^2))) <= IUIM_eps
        break
    end
    z = Vcycle_CG(res, IUIM_eps, para);
    if k == 1
        p = z;
        rho = sum(sum(res.f.*z.u))+sum(sum(res.g.*z.v));
    else
        rho_hat = rho;
        rho = sum(sum(res.f.*z.u))+sum(sum(res.g.*z.v));
        beta = rho / rho_hat;
        p.u = z.u + beta * p.u;
        p.v = z.v + beta * p.v;
    end
    w = CG_times(p, para);
    ptw = sum(sum(p.u.*w.f+p.v.*w.g));
    alpha = rho / ptw;
    poi.u = poi.u + alpha * p.u;
    poi.v = poi.v + alpha * p.v;
    res.f = res.f - alpha * w.f;
    res.g = res.g - alpha * w.g;
end
end

