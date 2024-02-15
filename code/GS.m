function [poi] = GS(poi, res, para)
%做一次GS迭代
u = poi.u;
v = poi.v;
f = res.f;
g = res.g;
N = length(u);
h = 1 / N;
for i = 1: N
    for j = 1: N
        if i == 1 && j == 1
            u(i,j) = (f(i,j)*h^2+u(i+1,1)+u(i,2))/3;
            v(i,j) = (g(i,j)*h^2+v(1,j+1)+v(2,j))/3;
        end
        if i == 1 && j == N
            u(i,j) = (f(i,j)*h^2+u(i+1,N)+u(i,N-1))/3;
            v(i,j) = 0;
        end
        if i == N && j == 1
            u(i,j) = 0;
            v(i,j) = (g(i,j)*h^2+v(N,j+1)+v(N-1,j))/3;
        end
        if i == N && j == N
            u(i,j) = 0;
            v(i,j) = 0;
        end
        if i > 1 && i < N && j == 1
            u(i,j) = (f(i,j)*h^2+u(i+1,1)+u(i-1,1)+u(i,2))/3;
            v(i,j) = (g(i,j)*h^2+v(i,j+1)+v(i+1,j)+v(i-1,j))/4;
        end
        if i > 1 && i < N && j == N
            u(i,j) = (f(i,j)*h^2+u(i+1,N)+u(i-1,N)+u(i,N-1))/3;
            v(i,j) = 0;
        end
        if j > 1 && j < N && i == 1
            u(i,j) = (f(i,j)*h^2+u(i+1,j)+u(i,j+1)+u(i,j-1))/4;
            v(i,j) = (g(i,j)*h^2+v(1,j+1)+v(1,j-1)+v(2,j))/3;
        end
        if j > 1 && j < N && i == N
            u(i,j) = 0;
            v(i,j) = (g(i,j)*h^2+v(N,j+1)+v(N,j-1)+v(N-1,j))/3;
        end
        if i > 1 && i < N && j > 1 && j < N
            u(i,j) = (f(i,j)*h^2+u(i+1,j)+u(i-1,j)+u(i,j+1)+u(i,j-1))/4;
            v(i,j) = (g(i,j)*h^2+v(i,j+1)+v(i,j-1)+v(i+1,j)+v(i-1,j))/4;
        end
    end
end

poi.u = u;
poi.v = v;
end

