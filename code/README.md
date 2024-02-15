# 代码解释

## 函数变量

设置的函数变量基本以结构体表示

poi: u, v, p 代表速度和压力
res: f, g, d 代表stokes数值形式的方程常系数，特别的d代表数值散度
para: 相关常数均在get_para()中有注释
注: 有些时候结构体的项不一定都存在，比如poi中只有p，没有u,v

## 辅助函数

test_func: 存储测试函数
up_down_operator: 存储限制和提升算子，包含两种
Btimes(poi): 计算$BP$，为了计算特征值
Btimes(poi): 计算$B^TP$，为了计算特征值
CG_res(poi, res, para): 得到$F-BP_k$
CG_times(poi, para): 做一次$AU$乘法
CG_Vcycle(poi, res, IUIM_eps, para): 使用不精确的共轭梯度法求解$A\hat{U}_{k+1}=F-BP_k$，用Vcycle作为预条件算子，其中IUIM_eps表示允许的精度
CG(poi, res, para): 精确的共轭梯度法求解$A\hat{U}_{k+1}=F-BP_k$
DGS(poi, res, para): 做一次DGS迭代
err_std(poi, para): 计算题目要求的标准误差$e_N$
find_eig(para): 找到最大特征值，经过计算基本是1.0000
find_poi_exact(para): 根据函数精确解得到数值形式的精确解
get_para(N): 得到全局常数
GS(poi, res, para): 做一次$A\hat{U}_{k+1}=F-BP_k$的Gauss迭代, poi是初始点，res是$F-BP_k$
Residual_init(para): 计算最初的数值stokes方程常数
Residual(poi, res, para): 计算现在得到解poi的数值stokes方程误差
table2latex(T, file): 将table转化为latex代码
Vcycle_CG(res, IUIM_eps, para): 作为共轭梯度法中的Vcycle预条件算子, 单次迭代取GS

## 主要函数

Vcycle_DGS(para): 实现使用DGS磨光子的Vcycle算法
UIM(para): 使用Uzawa Iteration Method方法叠加共轭梯度法求解
IUIM(para): 使用Inexact Uzawa Iteration Method方法叠加以Vcycle作为预条件算子的共轭梯度法求解
test.mlx: 测试算法性能
