v1=ones(366,3);
v2=ones(366,3);
index1=1;
index2=1;
for i=1:366
    if coord(i,4)==1
        v1(index1,1)=coord(i,1);
        v1(index1,2)=coord(i,2);
        v1(index1,3)=coord(i,3);
        index1=index1+1;
    end
    
    if(coord(i,4)==0)
       L=i;
       while coord(L,4)==0
           L=L-1;
       end
       R=i;
       while coord(R,4)==0
            R=R+1;
       end
      k=(coord(R,3)-coord(L,3))/(coord(R,2)-coord(L,2));
      b=(coord(L,2)*coord(R,3)-coord(R,2)*coord(L,3))/(coord(L,2)-coord(R,2));
      temp_x=((coord(R,2)-coord(L,2))/(coord(R,1)-coord(L,1)))*(coord(i,1)-coord(L,1))+coord(L,2);
      temp_y=k*temp_x+b;
      
      v2(index2,1)=coord(i,1);
      v2(index2,2)=temp_x;
      v2(index2,3)=temp_y;
      index2=index2+1;
    end    
end

vx1=ones(1,309);
vy1=ones(1,309);
vx2=ones(1,57);
vy2=ones(1,57);
for i=1:309
vx1(i)=v1(i,2);
vy1(i)=v1(i,3);
end

for i=1:57
vx2(i)=v2(i,2);
vy2(i)=v2(i,3);
end

plot(vx1,vy1,'bo');
set(gca,'FontSize',14);
hold on;
plot(vx2,vy2,'ro');
hold on;
