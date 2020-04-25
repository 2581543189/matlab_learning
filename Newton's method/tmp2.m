Speed = 4; %数字越大越快

better_blue=[150./255 239./255 230./255];
better_red=[249./255,99./255,111./255];
better_yellow=[206./255,183./255,115./255];
better_pink=[238./255,120./255,100./255];
better_green=[28./255,203./255,174./255];

% 求交点

% 定义函数 f(x,y) = 8 * x * x - y
% f1 = @(x,y) 8 * x * x - y;
% 
% %定义函数 f(x,y) = 64 * x * log2(x) - y
% f2 = @(x,y)  64 * x * log2(x) - y;
% 
% X = 0:1:100;
% 
% for i = 1:length(X)
%     Y1(i) = f1(i,0);
%     Y2(i) = f2(i,0);
% end
% 
% 
% plot(X,Y1);
% 
% hold all
% 
% plot(X,Y2);
% 
% hold all
% 
% syms m n;
% f3=@(x)8 * x * x - 64 * x * log2(x);
% X3=fzero(f3,32);
% Y3 = [double(f1(x3,0))];
% 
% plot(X3,Y3,'mo');  %以红紫色圆圈标出交点
% legend('y=8x^2','y=64xlog2(x)', '交点',2)%添加图例
% str=sprintf('(%.2f , %.2f)',X3(1),Y3(1))
% text(X3(1)+5,Y3(1),str);
% 

%=============牛顿法===============

%定义函数 y = 8*x^2 - 64x * log2(x)

f1 = @(x,y) 8.*x^2 - 64.*x .* log2(x);
syms m;
f2 = 8 .* m^2 - 64.*m .* log2(m);

X = 30:1:70;

for i = 1:length(X)
    Y1(i) = f1(X(i),0);
end
plot(X,Y1);

legend('y=8*x^2 - 64x * log2(x)');
hold on
%画x轴
plot([0,100],[0,0],'-','Color','k');
x0=64;
%设置坐标轴
xlabel('x');ylabel('y');
set(gca,'XLim',[30 70]);
set(gca,'YLim',[-1000 9000]);
grid on; 
axis square;
for j = 1:1:100
    hold on
    %更新x0
    y0 = f1(x0,0);
    %画竖直的虚线

    handler1 = plot([x0,x0],[0,y0],'--','Color',better_red);
    handler2 = plot([x0],[y0],'o','Color',better_red);
    pause(2/Speed);
    %求斜率
    df1=diff(f2,m);
    df1_x0 = double(subs(df1,x0));
    
    %画斜线
    f3 = @(x)df1_x0 * (x - x0) + y0;
    for i = 1:length(X)
        Y3(i) = f3(X(i));
    end
    handler3 = plot(X,Y3);
    %标记交点
    x4 = fzero(f3,64);
    handler4 = plot([x4],[0],'o','Color',better_red);
    
    %显示交点坐标
	str=sprintf('(x=%.2f)',x4);
	handler5 = text(x4,-500,str);
    pause(2/Speed);
    %更新x0
    if(rem(j,4) ~= 0)
        x0 = x4;
    else
       x0 =64; 
    end
    delete(handler1);
    delete(handler2);
    delete(handler3);
    delete(handler4);
    delete(handler5);
end
