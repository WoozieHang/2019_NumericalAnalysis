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

M=zeros(462,462);
Y=zeros(462,1);
for i=1:154
M(3*i-2,3*i-2)=v1(2*i-1,2).^2;
M(3*i-2,3*i-1)=v1(2*i-1,2);
M(3*i-2,3*i)=1;
Y(3*i-2)=v1(2*i-1,3);

M(3*i-1,3*i-2)=v1(2*i,2).^2;
M(3*i-1,3*i-1)=v1(2*i,2);
M(3*i-1,3*i)=1;
Y(3*i-1)=v1(2*i,3);

M(3*i,3*i-2)=v1(2*i+1,2).^2;
M(3*i,3*i-1)=v1(2*i+1,2);
M(3*i,3*i)=1;
Y(3*i)=v1(2*i+1,3);

end

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
for i=1:154
    tmpx=v1(2*i-1,2):(v1(2*i+1,2)-v1(2*i-1,2))/100:v1(2*i+1,2);
 
tmpy=X(3*i-2).*tmpx.^2+X(3*i-1).*tmpx+X(3*i);
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
p=0;

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
       if mod(pos,2)==1
        p=(pos+1)/2;
       else
           p=pos/2;
       end
       
       
       vy2(index2)=X(3*p-2).*vx2(index2).^2+X(3*p-1).*vx2(index2)+X(3*p);
       
       index2=index2+1;
    end
end  
plot(vx2,vy2,'ro');
set(gca,'FontSize',14);
hold on;