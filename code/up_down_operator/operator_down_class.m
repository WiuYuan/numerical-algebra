function [poi] = operator_down_class(poi, para)
%限制算子
u = poi.f;
v = poi.g;
p = poi.d;
N = length(u);
uu = zeros(N/2);
vv = zeros(N/2);
pp = zeros(N/2);
for i = 1: N/2
    for j = 1: N/2
        if i == N/2 && j == N/2
            uu(i, j) = 0;

            vv(i, j) = 0;
        end
        if i < N/2 && j == N/2
            uu(i, j) = 0.25 * (u(2*i, 2*j-1)+u(2*i, 2*j)) + ...
                0.125 * (u(2*i-1, 2*j-1)+u(2*i-1, 2*j) + ...
                u(2*i+1, 2*j-1)+u(2*i+1, 2*j));

            vv(i, j) = 0;
        end
        if j < N/2 && i == N/2
            uu(i, j) = 0;

            vv(i, j) = 0.25 * (v(2*i-1, 2*j)+v(2*i, 2*j)) + ...
                0.125 * (v(2*i-1, 2*j-1)+v(2*i, 2*j-1) + ...
                v(2*i-1, 2*j+1)+v(2*i, 2*j+1));
        end
        if i < N/2 && j < N/2
            uu(i, j) = 0.25 * (u(2*i, 2*j-1)+u(2*i, 2*j)) + ...
                0.125 * (u(2*i-1, 2*j-1)+u(2*i-1, 2*j) + ...
                u(2*i+1, 2*j-1)+u(2*i+1, 2*j));

            vv(i, j) = 0.25 * (v(2*i-1, 2*j)+v(2*i, 2*j)) + ...
                0.125 * (v(2*i-1, 2*j-1)+v(2*i, 2*j-1) + ...
                v(2*i-1, 2*j+1)+v(2*i, 2*j+1));
        end
        pp(i,j) = (p(2*i-1, 2*j-1)+p(2*i, 2*j-1)+p(2*i-1, 2*j)+p(2*i, 2*j))/4;
    end
end
poi.f = uu;
poi.g = vv;
poi.d = pp;
end

