clf;
better_red=[249./255,99./255,111./255];
better_blue=[150./255 239./255 230./255];

subplot(2,2,1);
f1 = @(x,y) x.^2/4 - y + 1;
f2 = @(x,y) x - 0* y;
f3 = @(x,y) 0*x + y;
X = -5:.1:5;
for i = 1:length(X)
    Y1(i) = f1(X(i),0);
    X2(i) = 0;
    Y2(i) = f2(X(i),0)+4;
    Y3(i) = f3(X(i),0);
end
%画曲线
plot(X,Y1);
hold all
plot(X2,Y2,'Color',better_red);
hold all
plot(X,Y3,'Color',better_red);

%画辅助线
plot([0,2],[2,2],'--','Color',better_red);
plot([0,4],[5,5],'--','Color',better_red);
plot([0,0],[2,5],'-','Color',better_blue,'linewidth',3);

%画重点
plot([2],[2],'o','Color',better_red);
plot([4],[5],'o','Color',better_red);


xlabel('x');ylabel('y');
set(gca,'XLim',[-5 5]);
set(gca,'YLim',[-1 7]);
set(gca,'xtick',-5:1:5);
set(gca,'ytick',0:1:7);
grid on;
axis equal;
axis on;
title('$$y = \frac{x^2}{4} + 1$$','Interpreter','latex');

subplot(2,2,2);
f = @(x,y) x/2 - y;
X = -5:.1:5;
for i = 1:length(X)
    Y(i) = f(X(i),0);
end
plot(X,Y);
hold all
plot(X2,Y2,'Color',better_red);
hold all
plot(X,Y3,'Color',better_red);

X_fill=[2,4,4,2];
Y_fill=[0,0,2,1];
fill(X_fill,Y_fill,better_blue);


xlabel('x');ylabel('y');
set(gca,'XLim',[-5 5]);
set(gca,'YLim',[-1 7]);
set(gca,'xtick',-5:1:5);
set(gca,'ytick',-5:1:5);
grid on;
axis equal;
axis on;
title('$$y = \frac{x}{2}$$','Interpreter','latex');

