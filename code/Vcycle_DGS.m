function [poi, T] = Vcycle_DGS(para)
%使用DGS单次迭代的Vcycle算法
N = para.N;
v1 = para.DGS_v1;
v2 = para.DGS_v2;
L = para.DGS_L;
poi.u = zeros(N);
poi.v = zeros(N);
poi.p = zeros(N);
M = floor(log(N)/log(2)-L+1); %要限制和提升几次
poi_cycle = cell(M);
res_cycle = cell(M+1);
res_cycle{1} = Residual_init(para);
poi_cycle{1} = poi;
res = res_cycle{1};
nF = sqrt(norm(res.f,'fro')^2+norm(res.g,'fro')^2+norm(res.d,'fro')^2);
for T = 1: 1000
    for cycle = 1: M %每层网络
        res = res_cycle{cycle};
        [n, ~] = size(res.f);
        if cycle == 1
            poi = poi_cycle{1};
        else
            poi.u = zeros(n);
            poi.v = zeros(n);
            poi.p = zeros(n);
        end
        for i = 1: v1 %v1次DGS迭代
            poi = DGS(poi, res, para);
        end
        res = Residual(poi, res, para);
        if n == N %误差判断
            nr = sqrt(norm(res.f,'fro')^2+norm(res.g,'fro')^2+norm(res.d,'fro')^2);
            if nr / nF <= 1e-8 
                return
            end
        end
        poi_cycle{cycle} = poi;
        if para.operator_type == "class"
            res_cycle{cycle+1} = operator_down_class(res, para, "DGS");
        else
            res_cycle{cycle+1} = operator_down_pdf(res, para, "DGS");
        end
    end
    for cycle = M-1: -1: 1 %回溯模拟
        poi_down = poi_cycle{cycle+1};
        poi = poi_cycle{cycle};
        res = res_cycle{cycle};
        if para.operator_type == "class"
            poi_up = operator_up_class(poi_down, para, "DGS");
        else
            poi_up = operator_up_pdf(poi_down, para, "DGS");
        end
        poi.u = poi.u + poi_up.u; %粗网格到细网格的更新
        poi.v = poi.v + poi_up.v;
        poi.p = poi.p + poi_up.p;
        for t = 1: v2 %v2次GS迭代
            poi = DGS(poi, res, para);
        end
        poi_cycle{cycle} = poi;
    end
end
end