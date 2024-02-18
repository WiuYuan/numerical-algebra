function [rho] = find_eig(para)
%找寻计算最优alpha要用的最大特征值
N = para.N;
poi.p = zeros(N);
poi.p(1,1) = 1;
p.u = zeros(N);
p.v = zeros(N);
for k = 1: 100
    poi = Btimes(poi);
    poi = CG(p, poi, para);
    poi = Bttimes(poi);
    rho = norm(poi.p, 'fro');
    poi.p = poi.p / rho;
end
end

