function [poi] = operator_up_class(poi, para)
%提升算子
u = poi.u;
v = poi.v;
if typ == "DGS"
    p = poi.p;
end
N = length(u);
uu = zeros(2*N);
vv = zeros(2*N);
if typ == "DGS"
    pp = zeros(2*N);
end
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
        if typ == "DGS"
            pp(2*i-1, 2*j-1) = p(i,j);
            pp(2*i, 2*j-1) = p(i,j);
            pp(2*i-1, 2*j) = p(i,j);
            pp(2*i, 2*j) = p(i,j);
        end
    end
end
poi.u = uu;
poi.v = vv;
if typ == "DGS"
    poi.p = pp;
end
end

