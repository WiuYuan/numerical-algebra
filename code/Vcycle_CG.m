function [poi] = Vcycle_CG(res, IUIM_eps, para)
%作为共轭梯度法中的Vcycle预条件算子, 单次迭代取GS
N = para.N;
poi.u = zeros(N);
poi.v = zeros(N);
v1 = para.GS_v1;
v2 = para.GS_v2;
L = para.GS_L;
M = floor(log(N)/log(2)-L+1); %要限制和提升几次
poi_cycle = cell(M);
res_cycle = cell(M+1);
res_cycle{1} = res;
poi_cycle{1} = poi;
nF = sqrt(norm(res.f,'fro')^2+norm(res.g,'fro')^2);
for T = 1: 1000
    for cycle = 1: M %每层网络
        res = res_cycle{cycle};
        [n, ~] = size(res.f);
        if cycle == 1
            poi = poi_cycle{1};
        else
            poi.u = zeros(n);
            poi.v = zeros(n);
        end
        for i = 1: v1 %v1次GS迭代
            poi = GS(poi, res, para);
        end
        Ax = CG_times(poi, para);
        res.f = res.f - Ax.f;
        res.g = res.g - Ax.g;
        if n == N %误差判断
            nr = sqrt(norm(res.f,'fro')^2+norm(res.g,'fro')^2);
            % nr,nF,IUIM_eps
            if nr / nF <= max(IUIM_eps,1e-4) || nr <= 1e-8
                return
            end
        end
        poi_cycle{cycle} = poi;
        if para.operator_type == "class"
            res_cycle{cycle+1} = operator_down_class(res, para, "IUIM");
        else
            res_cycle{cycle+1} = operator_down_pdf(res, para, "IUIM");
        end
    end
    for cycle = M-1: -1: 1 %回溯模拟
        poi_down = poi_cycle{cycle+1};
        poi = poi_cycle{cycle};
        res = res_cycle{cycle};
        if para.operator_type == "class"
            poi_up = operator_up_class(poi_down, para, "IUIM");
        else
            poi_up = operator_up_pdf(poi_down, para, "IUIM");
        end
        poi.u = poi.u + poi_up.u; %粗网格到细网格的更新
        poi.v = poi.v + poi_up.v;
        for t = 1: v2 %v2次GS迭代
            poi = GS(poi, res, para);
        end
        poi_cycle{cycle} = poi;
    end
end
end