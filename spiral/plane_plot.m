
% filename: plane_plot.m
% version:  7.6.0.324 (R2008a)
function plane_plot(p,i,j,C)
    p1=p;
    p2=p+i;
    p3=p+i+j;
    p4=p+j;
    X=[p1(1,1),p2(1,1),p3(1,1),p4(1,1)];
    Y=[p1(1,2),p2(1,2),p3(1,2),p4(1,2)];
    Z=[p1(1,3),p2(1,3),p3(1,3),p4(1,3)];
    fill3(X,Y,Z,C);
end