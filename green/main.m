Speed = 20; %����Խ��Խ��
figure();
total_count=4;
for j=1:100
for index=1:total_count
    clf;
    target = 2+6/total_count*index;
    render1(target);
    render2(target);
    render3(target);
    render4(target);
    pause(2/Speed);
end
end
