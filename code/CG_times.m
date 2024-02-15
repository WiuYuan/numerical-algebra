function [res] = CG_times(poi, para)
%CG计算乘法
u = poi.u;
v = poi.v; 
N = length(u);
h = 1 / N;
f = zeros(N);
g = zeros(N);
for i = 1: N
    for j = 1: N
        if i == 1 && j == 1
            f(i,j) = -(u(2,1)-2*u(1,1))/h^2-(u(1,2)-u(1,1))/h^2;
            g(i,j) = -(v(1,2)-2*v(1,1))/h^2-(v(2,1)-v(1,1))/h^2;
        end
        if i == 1 && j == N
            f(i,j) = -(u(2,N)-2*u(1,N))/h^2+(u(1,N)-u(1,N-1))/h^2;
            g(i,j) = 0;
        end
        if i == N && j == 1
            f(i,j) = 0;
            g(i,j) = -(v(N,2)-2*v(N,1))/h^2+(v(N,1)-v(N-1,1))/h^2;
        end
        if i == N && j == N
            f(i,j) = 0;
            g(i,j) = 0;
        end
        if i > 1 && i < N && j == 1
            f(i,j) = -(u(i+1,1)-2*u(i,1)+u(i-1,1))/h^2-(u(i,2)-u(i,1))/h^2;
            g(i,j) = -(v(i,2)-2*v(i,1))/h^2-(v(i+1,1)-2*v(i,1)+v(i-1,1))/h^2;
        end
        if i > 1 && i < N && j == N
            f(i,j) = -(u(i+1,N)-2*u(i,N)+u(i-1,N))/h^2+(u(i,N)-u(i,N-1))/h^2;
            g(i,j) = 0;
        end
        if j > 1 && j < N && i == 1
            f(i,j) = -(u(2,j)-2*u(1,j))/h^2-(u(1,j+1)-2*u(1,j)+u(1,j-1))/h^2;
            g(i,j) = -(v(1,j+1)-2*v(1,j)+v(1,j-1))/h^2-(v(2,j)-v(1,j))/h^2;
        end
        if j > 1 && j < N && i == N
            f(i,j) = 0;
            g(i,j) = -(v(N,j+1)-2*v(N,j)+v(N,j-1))/h^2+(v(N,j)-v(N-1,j))/h^2;
        end
        if i > 1 && i < N && j > 1 && j < N
            f(i,j) = -(u(i+1,j)-2*u(i,j)+u(i-1,j))/h^2-(u(i,j+1)-2*u(i,j)+u(i,j-1))/h^2;
            g(i,j) = -(v(i,j+1)-2*v(i,j)+v(i,j-1))/h^2-(v(i+1,j)-2*v(i,j)+v(i-1,j))/h^2;
        end
    end
end
res.f = f;
res.g = g;
end

