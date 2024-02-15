function [poi1] = Bttimes(poi)
u = poi.u;
v = poi.v;
N = length(u);
p = zeros(N);
h = 1 / N;
for i = 1: N
    for j = 1: N
        if i == 1 && j == 1
            p(i,j) = -u(i,j)/h-v(i,j)/h;
        end
        if i == 1 && j > 1
            p(i,j) = -u(i,j)/h-(v(i,j)-v(i,j-1))/h;
        end
        if i > 1 && j == 1
            p(i,j) = -(u(i,j)-u(i-1,j))/h-v(i,j)/h;
        end
        if i > 1 && j > 1
            p(i,j) = -(u(i,j)-u(i-1,j))/h-(v(i,j)-v(i,j-1))/h;
        end
    end
end
poi1.p = p;
end

