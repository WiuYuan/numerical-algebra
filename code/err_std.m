function [s] = err_std(poi, para)
%计算标准误差e_N
N = para.N;
poi_exact = find_poi_exact(para);
poi.u = poi.u - poi_exact.u;
poi.v = poi.v - poi_exact.v;
s = sqrt(sum(sum(poi.u.^2)+sum(sum(poi.v.^2))))/N;
end

