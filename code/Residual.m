function [res] = Residual(poi, res, para)
%计算残量
u = poi.u;
v = poi.v; 
p = poi.p;
N = length(u);
h = 1 / N;
f = zeros(N);
g = zeros(N);
d = zeros(N);
for i = 1: N
    for j = 1: N
        if i == 1 && j == 1
            f(i,j) = -(u(2,1)-2*u(1,1))/h^2-(u(1,2)-u(1,1))/h^2+(p(2,1)-p(1,1))/h;
            g(i,j) = -(v(1,2)-2*v(1,1))/h^2-(v(2,1)-v(1,1))/h^2+(p(1,2)-p(1,1))/h;
        end
        if i == 1 && j == N
            f(i,j) = -(u(2,N)-2*u(1,N))/h^2+(u(1,N)-u(1,N-1))/h^2+(p(2,N)-p(1,N))/h;
            g(i,j) = 0;
        end
        if i == N && j == 1
            f(i,j) = 0;
            g(i,j) = -(v(N,2)-2*v(N,1))/h^2+(v(N,1)-v(N-1,1))/h^2+(p(N,2)-p(N,1))/h;
        end
        if i == N && j == N
            f(i,j) = 0;
            g(i,j) = 0;
        end
        if i > 1 && i < N && j == 1
            f(i,j) = -(u(i+1,1)-2*u(i,1)+u(i-1,1))/h^2-(u(i,2)-u(i,1))/h^2+(p(i+1,1)-p(i,1))/h;
            g(i,j) = -(v(i,2)-2*v(i,1))/h^2-(v(i+1,1)-2*v(i,1)+v(i-1,1))/h^2+(p(i,2)-p(i,1))/h;
        end
        if i > 1 && i < N && j == N
            f(i,j) = -(u(i+1,N)-2*u(i,N)+u(i-1,N))/h^2+(u(i,N)-u(i,N-1))/h^2+(p(i+1,N)-p(i,N))/h;
            g(i,j) = 0;
        end
        if j > 1 && j < N && i == 1
            f(i,j) = -(u(2,j)-2*u(1,j))/h^2-(u(1,j+1)-2*u(1,j)+u(1,j-1))/h^2+(p(2,j)-p(1,j))/h;
            g(i,j) = -(v(1,j+1)-2*v(1,j)+v(1,j-1))/h^2-(v(2,j)-v(1,j))/h^2+(p(1,j+1)-p(1,j))/h;
        end
        if j > 1 && j < N && i == N
            f(i,j) = 0;
            g(i,j) = -(v(N,j+1)-2*v(N,j)+v(N,j-1))/h^2+(v(N,j)-v(N-1,j))/h^2+(p(N,j+1)-p(N,j))/h;
        end
        if i > 1 && i < N && j > 1 && j < N
            f(i,j) = -(u(i+1,j)-2*u(i,j)+u(i-1,j))/h^2-(u(i,j+1)-2*u(i,j)+u(i,j-1))/h^2+(p(i+1,j)-p(i,j))/h;
            g(i,j) = -(v(i,j+1)-2*v(i,j)+v(i,j-1))/h^2-(v(i+1,j)-2*v(i,j)+v(i-1,j))/h^2+(p(i,j+1)-p(i,j))/h;
        end
        if i == 1 && j == 1
            d(i,j) = -u(i,j)/h-v(i,j)/h;
        end
        if i == 1 && j > 1
            d(i,j) = -u(i,j)/h-(v(i,j)-v(i,j-1))/h;
        end
        if i > 1 && j == 1
            d(i,j) = -(u(i,j)-u(i-1,j))/h-v(i,j)/h;
        end
        if i > 1 && j > 1
            d(i,j) = -(u(i,j)-u(i-1,j))/h-(v(i,j)-v(i,j-1))/h;
        end
        f(i,j) = res.f(i,j) - f(i,j);
        g(i,j) = res.g(i,j) - g(i,j);
        d(i,j) = res.d(i,j) - d(i,j);
    end
end
res.f = f;
res.g = g;
res.d = d;
end

