function [poi] = operator_up_class(poi, para)
%提升算子
u = poi.u;
v = poi.v;
p = poi.p;
N = length(u);
uu = zeros(2*N);
vv = zeros(2*N);
pp = zeros(2*N);
for i = 1: N
    for j = 1: N
        if i == 1 && j == 1
            uu(2*i-1, 2*j-1) = 0.5 * u(i, j);
            uu(2*i-1, 2*j) = 0.5 * u(i, j);
            uu(2*i, 2*j-1) = 0.5 * u(i, j);
            uu(2*i, 2*j) = 0.75 * u(i, j) + 0.25 * u(i, j+1);

            vv(2*i-1, 2*j-1) = 0.5 * v(i, j);
            vv(2*i, 2*j-1) = 0.5 * v(i, j);
            vv(2*i-1, 2*j) = 0.5 * v(i, j);
            vv(2*i, 2*j) = 0.75 * v(i, j) + 0.25 * v(i+1, j);
        end
        if i == 1 && j == N
            uu(2*i-1, 2*j-1) = 0.5 * u(i, j);
            uu(2*i-1, 2*j) = 0.5 * u(i, j);
            uu(2*i, 2*j-1) = 0.75 * u(i, j) + 0.25 * u(i, j-1);
            uu(2*i, 2*j) = 0.5 * u(i, j);

            vv(2*i-1, 2*j-1) = 0.5 * v(i, j) + 0.5 * v(i, j-1);
            vv(2*i, 2*j-1) = 0.5 * v(i, j) + 0.5 * v(i, j-1);
            vv(2*i-1, 2*j) = 0.5 * v(i, j);
            vv(2*i, 2*j) = 0.75 * v(i, j) + 0.25 * v(i+1, j);
        end
        if i == N && j == 1
            uu(2*i-1, 2*j-1) = 0.5 * u(i, j) + 0.5 * u(i-1, j);
            uu(2*i-1, 2*j) = 0.5 * u(i, j) + 0.5 * u(i-1, j);
            uu(2*i, 2*j-1) = 0.5 * u(i, j);
            uu(2*i, 2*j) = 0.75 * u(i, j) + 0.25 * u(i, j+1);

            vv(2*i-1, 2*j-1) = 0.5 * v(i, j);
            vv(2*i, 2*j-1) = 0.5 * v(i, j);
            vv(2*i-1, 2*j) = 0.75 * v(i, j) + 0.25 * v(i-1, j);
            vv(2*i, 2*j) = 0.5 * v(i, j);
        end
        if i == N && j == N
            uu(2*i-1, 2*j-1) = 0.5 * u(i, j) + 0.5 * u(i-1, j);
            uu(2*i-1, 2*j) = 0.5 * u(i, j) + 0.5 * u(i-1, j);
            uu(2*i, 2*j-1) = 0.75 * u(i, j) + 0.25 * u(i, j-1);
            uu(2*i, 2*j) = 0.5 * u(i, j);

            vv(2*i-1, 2*j-1) = 0.5 * v(i, j) + 0.5 * v(i, j-1);
            vv(2*i, 2*j-1) = 0.5 * v(i, j) + 0.5 * v(i, j-1);
            vv(2*i-1, 2*j) = 0.75 * v(i, j) + 0.25 * v(i-1, j);
            vv(2*i, 2*j) = 0.5 * v(i, j);
        end
        if i > 1 && i < N && j == 1
            uu(2*i-1, 2*j-1) = 0.5 * u(i, j) + 0.5 * u(i-1, j);
            uu(2*i-1, 2*j) = 0.5 * u(i, j) + 0.5 * u(i-1, j);
            uu(2*i, 2*j-1) = 0.5 * u(i, j);
            uu(2*i, 2*j) = 0.75 * u(i, j) + 0.25 * u(i, j+1);

            vv(2*i-1, 2*j-1) = 0.5 * v(i, j);
            vv(2*i, 2*j-1) = 0.5 * v(i, j);
            vv(2*i-1, 2*j) = 0.75 * v(i, j) + 0.25 * v(i-1, j);
            vv(2*i, 2*j) = 0.75 * v(i, j) + 0.25 * v(i+1, j);
        end
        if i > 1 && i < N && j == N
            uu(2*i-1, 2*j-1) = 0.5 * u(i, j) + 0.5 * u(i-1, j);
            uu(2*i-1, 2*j) = 0.5 * u(i, j) + 0.5 * u(i-1, j);
            uu(2*i, 2*j-1) = 0.75 * u(i, j) + 0.25 * u(i, j-1);
            uu(2*i, 2*j) = 0.5 * u(i, j);

            vv(2*i-1, 2*j-1) = 0.5 * v(i, j) + 0.5 * v(i, j-1);
            vv(2*i, 2*j-1) = 0.5 * v(i, j) + 0.5 * v(i, j-1);
            vv(2*i-1, 2*j) = 0.75 * v(i, j) + 0.25 * v(i-1, j);
            vv(2*i, 2*j) = 0.75 * v(i, j) + 0.25 * v(i+1, j);
        end
        if j > 1 && j < N && i == 1
            uu(2*i-1, 2*j-1) = 0.5 * u(i, j);
            uu(2*i-1, 2*j) = 0.5 * u(i, j);
            uu(2*i, 2*j-1) = 0.75 * u(i, j) + 0.25 * u(i, j-1);
            uu(2*i, 2*j) = 0.75 * u(i, j) + 0.25 * u(i, j+1);

            vv(2*i-1, 2*j-1) = 0.5 * v(i, j) + 0.5 * v(i, j-1);
            vv(2*i, 2*j-1) = 0.5 * v(i, j) + 0.5 * v(i, j-1);
            vv(2*i-1, 2*j) = 0.5 * v(i, j);
            vv(2*i, 2*j) = 0.75 * v(i, j) + 0.25 * v(i+1, j);
        end
        if j > 1 && j < N && i == N
            uu(2*i-1, 2*j-1) = 0.5 * u(i, j) + 0.5 * u(i-1, j);
            uu(2*i-1, 2*j) = 0.5 * u(i, j) + 0.5 * u(i-1, j);
            uu(2*i, 2*j-1) = 0.75 * u(i, j) + 0.25 * u(i, j-1);
            uu(2*i, 2*j) = 0.75 * u(i, j) + 0.25 * u(i, j+1);

            vv(2*i-1, 2*j-1) = 0.5 * v(i, j) + 0.5 * v(i, j-1);
            vv(2*i, 2*j-1) = 0.5 * v(i, j) + 0.5 * v(i, j-1);
            vv(2*i-1, 2*j) = 0.75 * v(i, j) + 0.25 * v(i-1, j);
            vv(2*i, 2*j) = 0.5 * v(i, j);
        end
        if i > 1 && i < N && j > 1 && j < N
            uu(2*i-1, 2*j-1) = 0.5 * u(i, j) + 0.5 * u(i-1, j);
            uu(2*i-1, 2*j) = 0.5 * u(i, j) + 0.5 * u(i-1, j);
            uu(2*i, 2*j-1) = 0.75 * u(i, j) + 0.25 * u(i, j-1);
            uu(2*i, 2*j) = 0.75 * u(i, j) + 0.25 * u(i, j+1);

            vv(2*i-1, 2*j-1) = 0.5 * v(i, j) + 0.5 * v(i, j-1);
            vv(2*i, 2*j-1) = 0.5 * v(i, j) + 0.5 * v(i, j-1);
            vv(2*i-1, 2*j) = 0.75 * v(i, j) + 0.25 * v(i-1, j);
            vv(2*i, 2*j) = 0.75 * v(i, j) + 0.25 * v(i+1, j);
        end
        pp(2*i-1, 2*j-1) = p(i,j);
        pp(2*i, 2*j-1) = p(i,j);
        pp(2*i-1, 2*j) = p(i,j);
        pp(2*i, 2*j) = p(i,j);
    end
end
poi.u = uu;
poi.v = vv;
poi.p = pp;
end

