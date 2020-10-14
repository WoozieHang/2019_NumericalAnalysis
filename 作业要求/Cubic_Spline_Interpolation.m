v1=ones(366,3);
index1=1;
for i=1:366
    if coord(i,4)==1
        v1(index1,1)=coord(i,1);
        v1(index1,2)=coord(i,2);
        v1(index1,3)=coord(i,3);
        index1=index1+1;
    end
end

M=zeros(308*4,308*4);
Y=zeros(308*4,1);

%308个区间，308*4个参数，三次样条插值法
%其中309个已知点满足插值条件
%307个内部已知点满足，函数值、导数值、二阶导数值连续
%再补上两端自然边界条件，写入M矩阵作为系数矩阵

%插值条件
for i=1:308
   M(i,4*i-3)=v1(i,2)^3;
   M(i,4*i-2)=v1(i,2)^2;
   M(i,4*i-1)=v1(i,2);
   M(i,4*i)=1;
   Y(i)=v1(i,3);
end

M(309,4*308-3)=v1(309,2)^3;
M(309,4*308-2)=v1(309,2)^2;
M(309,4*308-1)=v1(309,2);
M(309,4*308)=1;
Y(309)=v1(309,3);


for i=1:307
    %内点连续
M(309+i,4*i-3)=v1(1+i,2)^3;
M(309+i,4*i-2)=v1(1+i,2)^2;
M(309+i,4*i-1)=v1(1+i,2);
M(309+i,4*i)=1;
M(309+i,4*i+1)=(-1)*v1(1+i,2)^3;
M(309+i,4*i+2)=(-1)*v1(1+i,2)^2;
M(309+i,4*i+3)=(-1)*v1(1+i,2);
M(309+i,4*i+4)=-1;
    %导数连续
M(616+i,4*i-3)=3*v1(1+i,2)^2;
M(616+i,4*i-2)=2*v1(1+i,2);
M(616+i,4*i-1)=1;
M(616+i,4*i+1)=(-3)*v1(1+i,2)^2;
M(616+i,4*i+2)=(-2)*v1(1+i,2);
M(616+i,4*i+3)=-1;
    %二阶导数连续
M(923+i,4*i-3)=6*v1(1+i,2);
M(923+i,4*i-2)=2;
M(923+i,4*i+1)=(-6)*v1(1+i,2);
M(923+i,4*i+2)=-2;
end

%自然边界条件，x0和x309处导数为0

M(1231,1)=3*v1(1,2)^2;
M(1231,2)=2*v1(1,2);
M(1231,3)=1;

M(1232,1+4*307)=3*v1(309,2)^2;
M(1232,2+4*307)=2*v1(309,2);
M(1232,3+4*307)=1;


X=M\Y;

vx1=ones(1,309);
vy1=ones(1,309);
for i=1:309
vx1(i)=v1(i,2);
vy1(i)=v1(i,3);
end
plot(vx1,vy1,'bo');
set(gca,'FontSize',14);
hold on;


%显示插值函数的效果
for i=1:308
    tmpx=v1(i,2):(v1(i+1,2)-v1(i,2))/100:v1(i+1,2);
tmpy=X(4*i-3).*tmpx.^3+X(4*i-2).*tmpx.^2+X(4*i-1).*tmpx+X(4*i);
plot(tmpx,tmpy,'k');
set(gca,'FontSize',14);
hold on;
end

%然后计算缺失时刻的横坐标，利用曲线积分
%求解积分用二分法逼近合适的定积分位置
%例如a，b区间上曲线积分是A
%a到缺失位置曲线积分应该是D=A*（t-ta）/（tb-ta）
%则对a到x区间积分，并和D比较，x利用二分法选择

vx2=zeros(1,366);
vy2=zeros(1,366);
index2=1;

pos=0;%当前所在哪个区间范围内

for i=1:366
    if coord(i,4)==1
    pos=pos+1;
    end
    
    if coord(i,4)==0
        %确定第index2个缺失的坐标
        a=i-1;
        b=i+1;
        while coord(a,4)==0
        a=a-1;
        end
        while coord(b,4)==0
        b=b+1;
        end
        k=(coord(i,1)-coord(a,1))/(coord(b,1)-coord(a,1));
      
       
       vx2(index2)=coord(a,2)+k*(coord(b,2)-coord(a,2));
       vy2(index2)=X(4*pos-3)*vx2(index2)^3+X(4*pos-2)*vx2(index2)^2+X(4*pos-1)*vx2(index2)+X(4*pos);
       index2=index2+1;
    end
    
end
plot(vx2,vy2,'ro');
set(gca,'FontSize',14);
hold on;








