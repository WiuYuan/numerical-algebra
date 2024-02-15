function [poi] = DGS(poi, res, para)
%做一次DGS迭代
u = poi.u;
v = poi.v;
p = poi.p;
f = res.f;
g = res.g;
d = res.d;
N = length(u);
h = 1 / N;
for i = 1: N
    for j = 1: N
        if i == 1 && j == 1
            u(i,j) = (f(i,j)*h^2+u(i+1,1)+u(i,2)-(p(i+1,1)-p(i,1))*h)/3;
            v(i,j) = (g(i,j)*h^2+v(1,j+1)+v(2,j)-(p(1,j+1)-p(1,j))*h)/3;
        end
        if i == 1 && j == N
            u(i,j) = (f(i,j)*h^2+u(i+1,N)+u(i,N-1)-(p(i+1,N)-p(i,N))*h)/3;
            v(i,j) = 0;
        end
        if i == N && j == 1
            u(i,j) = 0;
            v(i,j) = (g(i,j)*h^2+v(N,j+1)+v(N-1,j)-(p(N,j+1)-p(N,j))*h)/3;
        end
        if i == N && j == N
            u(i,j) = 0;
            v(i,j) = 0;
        end
        if i > 1 && i < N && j == 1
            u(i,j) = (f(i,j)*h^2+u(i+1,1)+u(i-1,1)+u(i,2)-(p(i+1,1)-p(i,1))*h)/3;
            v(i,j) = (g(i,j)*h^2+v(i,j+1)+v(i+1,j)+v(i-1,j)-(p(i,j+1)-p(i,j))*h)/4;
        end
        if i > 1 && i < N && j == N
            u(i,j) = (f(i,j)*h^2+u(i+1,N)+u(i-1,N)+u(i,N-1)-(p(i+1,N)-p(i,N))*h)/3;
            v(i,j) = 0;
        end
        if j > 1 && j < N && i == 1
            u(i,j) = (f(i,j)*h^2+u(i+1,j)+u(i,j+1)+u(i,j-1)-(p(i+1,j)-p(i,j))*h)/4;
            v(i,j) = (g(i,j)*h^2+v(1,j+1)+v(1,j-1)+v(2,j)-(p(1,j+1)-p(1,j))*h)/3;
        end
        if j > 1 && j < N && i == N
            u(i,j) = 0;
            v(i,j) = (g(i,j)*h^2+v(N,j+1)+v(N,j-1)+v(N-1,j)-(p(N,j+1)-p(N,j))*h)/3;
        end
        if i > 1 && i < N && j > 1 && j < N
            u(i,j) = (f(i,j)*h^2+u(i+1,j)+u(i-1,j)+u(i,j+1)+u(i,j-1)-(p(i+1,j)-p(i,j))*h)/4;
            v(i,j) = (g(i,j)*h^2+v(i,j+1)+v(i,j-1)+v(i+1,j)+v(i-1,j)-(p(i,j+1)-p(i,j))*h)/4;
        end
    end
end
for i = 1: N
    for j = 1: N
        % 残量计算
        if i == 1 && j == 1
            r = -u(i, j) / h - v(i, j) / h - d(i, j);
        end
        if i == 1 && j > 1
            r = -u(i, j) / h - (v(i, j) - v(i, j-1)) / h - d(i, j);
        end
        if i > 1 && j == 1
            r = -(u(i, j) - u(i-1, j)) / h - v(i, j) / h - d(i, j);
        end
        if i > 1 && j > 1
            r = -(u(i, j) - u(i-1, j)) / h -(v(i, j) - v(i, j-1)) / h - d(i, j);
        end

        % 更新单元格速度和压力
        if i == 1 && j == 1
            delta = r * h / 2;
            u(i, j) = u(i, j) + delta;
            v(i, j) = v(i, j) + delta;

            p(i, j) = p(i, j) + r;
            p(i+1, j) = p(i+1, j) - r / 2;
            p(i, j+1) = p(i, j+1) - r / 2;
        end
        if i == 1 && j == N
            delta = r * h / 2;
            u(i, j) = u(i, j) + delta;
            v(i, j-1) = v(i, j-1) + delta;

            p(i, j) = p(i, j) + r;
            p(i+1, j) = p(i+1, j) - r / 2;
            p(i, j-1) = p(i, j-1) - r / 2;
        end
        if i == N && j == 1
            delta = r * h / 2;
            u(i-1, j) = u(i-1, j) + delta;
            v(i, j) = v(i, j) + delta;

            p(i, j) = p(i, j) + r;
            p(i-1, j) = p(i-1, j) - r / 2;
            p(i, j+1) = p(i, j+1) - r / 2;
        end
        if i == N && j == N
            delta = r * h / 2;
            u(i-1, j) = u(i-1, j) + delta;
            v(i, j-1) = v(i, j-1) + delta;

            p(i, j) = p(i, j) + r;
            p(i-1, j) = p(i-1, j) - r / 2;
            p(i, j-1) = p(i, j-1) - r / 2;
        end
        if i > 1 && i < N && j == 1
            delta = r * h / 3;
            u(i-1, j) = u(i-1, j) - delta;
            u(i, j) = u(i, j) + delta;
            v(i, j) = v(i, j) - delta;

            p(i, j) = p(i, j) + r;
            p(i+1, j) = p(i+1, j) - r / 3;
            p(i-1, j) = p(i-1, j) - r / 3;
            p(i, j+1) = p(i, j+1) - r / 3;
        end
        if i > 1 && i < N && j == N
            delta = r * h / 3;
            u(i-1, j) = u(i-1, j) - delta;
            u(i, j) = u(i, j) + delta;
            v(i, j-1) = v(i, j-1) - delta;

            p(i, j) = p(i, j) + r;
            p(i+1, j) = p(i+1, j) - r / 3;
            p(i-1, j) = p(i-1, j) - r / 3;
            p(i, j-1) = p(i, j-1) - r / 3;
        end
        if j > 1 && j < N && i == 1
            delta = r * h / 3;
            u(i, j) = u(i, j) - delta;
            v(i, j-1) = v(i, j-1) - delta;
            v(i, j) = v(i, j) + delta;

            p(i, j) = p(i, j) + r;
            p(i+1, j) = p(i+1, j) - r / 3;
            p(i, j+1) = p(i, j+1) - r / 3;
            p(i, j-1) = p(i, j-1) - r / 3;
        end
        if j > 1 && j < N && i == N
            delta = r * h / 3;
            u(i-1, j) = u(i-1, j) - delta;
            v(i, j-1) = v(i, j-1) - delta;
            v(i, j) = v(i, j) + delta;

            p(i, j) = p(i, j) + r;
            p(i-1, j) = p(i-1, j) - r / 3;
            p(i, j+1) = p(i, j+1) - r / 3;
            p(i, j-1) = p(i, j-1) - r / 3;
        end
        if i > 1 && i < N && j > 1 && j < N
            delta = r * h / 4;
            u(i-1, j) = u(i-1, j) - delta;
            u(i, j) = u(i, j) + delta;
            v(i, j-1) = v(i, j-1) - delta;
            v(i, j) = v(i, j) + delta;

            p(i, j) = p(i, j) + r;
            p(i+1, j) = p(i+1, j) - r / 4;
            p(i-1, j) = p(i-1, j) - r / 4;
            p(i, j+1) = p(i, j+1) - r / 4;
            p(i, j-1) = p(i, j-1) - r / 4;
        end
    end
end
poi.u = u;
poi.v = v;
poi.p = p;
end

