function c=render2(target_x)

subplot(2,2,2)
% 画二元函数 f'(x,y) = y/50
better_blue=[150./255 239./255 230./255];
better_red=[249./255,99./255,111./255];
better_yellow=[206./255,183./255,115./255];
better_pink=[238./255,120./255,100./255];
better_green=[28./255,203./255,174./255];
f = @(x,y,z)x*0+ y/5 -z*1 ;
X = 0:1:9;
Y = 0:1:9;
Z = 0:1:5;
[x,y,z] = meshgrid(X,Y,Z);
f1 = f(x,y,z);
h = patch(isosurface(x,y,z,f1,0)); 
isonormals(x,y,z,f1,h) 
set(h,'FaceColor',better_blue,'EdgeColor','none');

%画底面的圆
hold all
aplha=0:pi/40:2*pi;
r=4;
x_cycle=r*cos(aplha)+5;
y_cycle=r*sin(aplha)+5;
plot(x_cycle,y_cycle,'-','Color','b');

%画柱面在曲面下方的部分
X_cylinder=meshgrid(x_cycle);
Y_cylinder=meshgrid(y_cycle);
for j1 = 1:length(aplha)
    X_cylinder2(j1)=X_cylinder(j1,j1);
    Y_cylinder2(j1)=Y_cylinder(j1,j1);
    Z_cylinder2(j1)=f(X_cylinder(j1,j1),Y_cylinder(j1,j1),0);
    for j2 = 1:length(aplha)
        j3 =pi/20 * j2;
        f_j3=f(X_cylinder(j2,j1),Y_cylinder(j2,j1),0);
        
        if(j3 > f_j3)
            Z_cylinder(j2,j1)=0;
        else
            Z_cylinder(j2,j1)=j3;
        end
    end
end

cylinder = surf(X_cylinder,Y_cylinder,Z_cylinder);
set(cylinder,'FaceColor',better_yellow,'EdgeColor','none');

%画 曲面与柱面的交线
cylinder2 = plot3(X_cylinder2,Y_cylinder2,Z_cylinder2,'linewidth',2,'Color',better_green);



% 与 y=target_x 平面交线
syms m n
%计算圆的范围
s=solve((m-5).^2+(n-5).^2==16,n==target_x,m,n);
M=double(s.m);
N=double(s.n);
X2 = 0:1:10;
Y = M(2):(M(1)-M(2))/10:M(1);
[x2,y2,z2] = meshgrid(X2,Y,Z);
% 画竖直面
g = @(x,y,z)x;
g1 = g(x2,y2,z2);
h1 = patch(isosurface(x2,y2,z2,g1,target_x));
isonormals(x2,y2,z2,g1,h1);
set(h1,'FaceColor',better_pink,'EdgeColor','none');

% 画交线
X3 = Y*0 + target_x;
Z3 = Y*0;

for ii = 1:length(Y)
    Z3(ii) = fzero(@(z)f(target_x,Y(ii),z), mean(Z));
end
hold all
h(2) = plot3(X3, Y, Z3,'linewidth',2,'Color',better_red);

% 填充割面

X_fill=[N(1),N(2),N(2),N(1)];
Y_fill=[M(1),M(2),M(2),M(1)];
Z_fill=[0,0,f(N(2),M(2),0),f(N(1),M(1),0)];
fill3(X_fill,Y_fill,Z_fill,'k');

%设置坐标轴
xlabel('x');ylabel('y');zlabel('z'); 
set(gca,'xtick',0:2:15);
set(gca,'ytick',0:2:15);
set(gca,'ztick',0:2:15);
alpha(0.6) 
grid on; 
view(-32,23);
axis equal;
title('$$\frac{\partial F}{\partial y} = \frac{y}{5}$$','Interpreter','latex');