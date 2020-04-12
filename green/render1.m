function c=render1(target_x)

subplot(2,2,1)
% 画二元函数 f(x,y) = x^2/10 + y^2/10
better_blue=[150./255 239./255 230./255];
better_red=[249./255,99./255,111./255];
better_yellow=[206./255,183./255,115./255];
better_pink=[238./255,120./255,100./255];
better_green=[28./255,203./255,174./255];
f = @(x,y,z) x.^2/10 + y.^2/10 -z ;
X = 0:1:15;
Y = 0:1:15;
Z = 0:1:15;
[x,y,z] = meshgrid(X,Y,Z);
f1 = f(x,y,z);
h = patch(isosurface(x,y,z,f1,0)); 
isonormals(x,y,z,f1,h) 
set(h,'FaceColor',better_blue,'EdgeColor','none');

%画底面的圆
hold all
aplha=0:pi/40:pi;
r=4;
x_cycle=r*cos(aplha)+5;
y_cycle=r*sin(aplha)+5;
plot(x_cycle,y_cycle,'-','Color','b');

%画柱面在曲面下方的部分
X_cylinder=meshgrid(x_cycle);
Y_cylinder=meshgrid(y_cycle);
for j1 = 1:length(aplha)
    X_cylinder_cross1(j1)=x_cycle(j1);
    Y_cylinder_cross1(j1)=y_cycle(j1);
    Z_cylinder_cross1(j1)=f(x_cycle(j1),y_cycle(j1),0);
    for j11 = 1:length(aplha)
        jz =pi/10 * j11;
        f_jz=f(X_cylinder(j11,j1),Y_cylinder(j11,j1),0);
        if(jz > f_jz)
            Z_cylinder(j11,j1)=0;
        else
            Z_cylinder(j11,j1)=jz;
        end
    end
end

cylinder = surf(X_cylinder,Y_cylinder,Z_cylinder);
set(cylinder,'FaceColor','b','EdgeColor','none');

%画 曲面与柱面的交线
plot3(X_cylinder_cross1,Y_cylinder_cross1,Z_cylinder_cross1,'linewidth',2,'Color','b');

aplha2=pi:pi/40:2*pi;
x_cycle2=r*cos(aplha2)+5;
y_cycle2=r*sin(aplha2)+5;
X_cylinder2=meshgrid(x_cycle2);
Y_cylinder2=meshgrid(y_cycle2);
for j2 = 1:length(aplha2)
    X_cylinder_cross2(j2)=x_cycle2(j2);
    Y_cylinder_cross2(j2)=y_cycle2(j2);
    Z_cylinder_cross2(j2)=f(x_cycle2(j2),y_cycle2(j2),0);
    for j22 = 1:length(aplha2)
        jz2 =pi/10 * j22;
        f_jz2=f(X_cylinder2(j22,j2),Y_cylinder2(j22,j2),0);
        if(jz2 > f_jz2)
            Z_cylinder2(j22,j2)=0;
        else
            Z_cylinder2(j22,j2)=jz2;
        end
    end
end
cylinder2 = surf(X_cylinder2,Y_cylinder2,Z_cylinder2);
set(cylinder2,'FaceColor',better_yellow,'EdgeColor','none');
plot3(X_cylinder_cross2,Y_cylinder_cross2,Z_cylinder_cross2,'linewidth',2,'Color',better_yellow);


% 与 x=target_x 平面交线
syms m n
%计算圆的范围
s=solve((m-5).^2+(n-5).^2==16,n==target_x,m,n);
M=double(s.m);

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


%设置坐标轴
xlabel('x');ylabel('y');zlabel('z'); 
set(gca,'xtick',0:2:15);
set(gca,'ytick',0:2:15);
set(gca,'ztick',0:2:15);
alpha(0.6) 
grid on; 
view(-32,23);
axis equal;
title('$$F(x,y) = \frac{x^2}{10} + \frac{y^2}{10}$$','Interpreter','latex');