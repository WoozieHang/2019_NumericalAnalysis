%代码用于拟合第一题，且在左上角和右下角使用二次曲线进行拟合，在四边用直线进行拟合
x1=ones(1,66);%1-66
x2=ones(1,17);%67-83
x3=ones(1,132);%84-215
x4=ones(1,53);%216-268
x5=ones(1,27);%269-295
x6=ones(1,87);%296-382
y1=ones(1,66);
y2=ones(1,17);
y3=ones(1,132);
y4=ones(1,53);
y5=ones(1,27);
y6=ones(1,87);

for i=1:76
   x1(i)=path_chan(i);
   y1(i)=path_chan(382+i);
end

for i=1:30
   x2(i)=path_chan(i+66);
   y2(i)=path_chan(382+i+66);
end
for i=1:132
   x3(i)=path_chan(i+83);
   y3(i)=path_chan(382+i+83);
end

for i=1:60
   x4(i)=path_chan(i+215);
   y4(i)=path_chan(382+i+215);
end

for i=1:30
   x5(i)=path_chan(i+268);
   y5(i)=path_chan(382+i+268);
end

for i=1:87
   x6(i)=path_chan(i+295);
   y6(i)=path_chan(382+i+295);
end



fit1=polyfit(y1,x1,1);
fit2=polyfit(x2,y2,2);
fit3=polyfit(x3,y3,1);
fit4=polyfit(y4,x4,1);
fit5=polyfit(x5,y5,2);
fit6=polyfit(x6,y6,1);

yfit1=y1(1):-0.1:y1(end);
xfit1=fit1(1)*yfit1+fit1(2);
plot(x1,y1,'b.',xfit1,yfit1);
% plot(xfit1,yfit1);
set(gca,'FontSize',14);
hold on;

xfit2=[x2(1):0.1:x2(end)];
yfit2=fit2(1)*xfit2.^2+fit2(2)*xfit2+fit2(3);
plot(x2,y2,'b.',xfit2,yfit2);
%plot(xfit2,yfit2);
set(gca,'FontSize',14);
hold on;


xfit3=[x3(1):0.1:x3(end)];
yfit3=fit3(1)*xfit3+fit3(2);
plot(x3,y3,'b.',xfit3,yfit3);
%plot(xfit3,yfit3);
set(gca,'FontSize',14);

hold on;

yfit4=[y4(1):0.1:y4(end)];
xfit4=fit4(1)*yfit4+fit4(2);
plot(x4,y4,'b.',xfit4,yfit4);
%plot(xfit4,yfit4);
set(gca,'FontSize',14);hold on;

xfit5=[x5(1):-0.1:x5(end)];
yfit5=fit5(1)*xfit5.^2+fit5(2)*xfit5+fit5(3);
plot(x5,y5,'b.',xfit5,yfit5);
%plot(xfit5,yfit5);
set(gca,'FontSize',14);
hold on;

xfit6=[x6(87):0.1:x6(1)];
yfit6=fit6(1)*xfit6+fit6(2);
plot(x6,y6,'b.',xfit6,yfit6);
%plot(xfit6,yfit6);
set(gca,'FontSize',14);
hold on;
