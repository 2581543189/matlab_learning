function c=render(t1)
    hold on;
    % t 的取值 0 ～ 2pi
    T=[0:2* pi / 100:20*pi];
    % 设置 xyz 的取值范围
    set(gca,'XLim',[-2,2])
    set(gca,'YLim',[-2,2])
    set(gca,'ZLim',[0,10])
    axis equal;
    % 画出z=0 的xy平面
    m=-2:0.2:2;
    n=-2:0.2:2;
    [X,Y]=meshgrid(m,n);
    Z=X*0+Y*0;
    mesh(X,Y,Z);
    %画出曲线 r(t)=sin(t)i+cos(t)j+tk;
    a=cos(T);
    b=sin(T);
    c=T/10;
    plot3(a,b,c,'k')
    
    s1=sqrt(2)*t1;
    a1=cos(t1);
    b1=sin(t1);
    c1=t1/10;
    plot3(a1,b1,c1,'o','MarkerSize',5,'MarkerFaceColor','r')
    %画出单位切向量
    syms s t;
    t=s/sqrt(2);
    dx_ds=diff(cos(t),s);
    dy_ds=diff(sin(t),s);
    dz_ds=diff(t/10,s);
    digits(4);
    T=[vpa(subs(dx_ds,s,s1)),vpa(subs(dy_ds,s,s1)),vpa(subs(dz_ds,s,s1))];
    quiver3(a1,b1,c1,T(1,1),T(1,2),T(1,3),'r','LineWidth',2);
    %画出单位法向量
    dx_ds_ds=diff(cos(t),s,2);
    dy_ds_ds=diff(sin(t),s,2);
    dz_ds_ds=diff(t,s,2);
    N=[vpa(subs(dx_ds_ds,s,s1)),vpa(subs(dy_ds_ds,s,s1)),vpa(subs(dz_ds_ds,s,s1))];
    k=norm(N);
    N=[N(1,1)/k,N(1,2)/k,N(1,3)/k];
    quiver3(a1,b1,c1,N(1,1),N(1,2),N(1,3),'g','LineWidth',2);
    %画出单位次向法量
    B=cross(T,N);
    quiver3(a1,b1,c1,B(1,1),B(1,2),B(1,3),'b','LineWidth',2);
    plane_plot([a1,b1,c1],T,N,[1.0000 1.0000 1.0000 1.0000]);
    plane_plot([a1,b1,c1],B,N,[0.5000 0.5000 0.5000 0.5000]);