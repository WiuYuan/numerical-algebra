function [para] = get_para(N)
%将测试函数加入参数，并且设置基本参数

%测试函数
para.func_f = @func_f;
para.func_g = @func_g;
para.func_p = @func_p;
para.func_u = @func_u;
para.func_v = @func_v;
para.func_b = @func_b;
para.func_l = @func_l;
para.func_t = @func_t;
para.func_r = @func_r;

para.N = N; %分块大小
para.operator_type = "pdf"; %使用的限制提升算子是pdf上的还是classs上的

%用DGS的Vcycle相关常数
para.DGS_v1 = 10;
para.DGS_v2 = 5;
para.DGS_L = 2;

%用GS的Vcycle相关常数
para.GS_v1 = 5;
para.GS_v2 = 3;
para.GS_L = 2;

%共轭梯度法相关参数
para.CG_eps = 1e-8;
para.CG_max_size = 10000;

%Uzawa中相关参数
para.alpha = 1;
para.tau = 0.01;
end

