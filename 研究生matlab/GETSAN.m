
function [data,adata,unet,anet,fnum,anum,m]=GETSAN(dir,filename,n)
%'D:\\snakdd12\\predict-new-links\\AUG4.txt'
data = dlmread(strcat(dir,filename));
m=size(data);
m=m(1);

%用户数为M,属性数为N
%unet是传统社交网络邻接矩阵M*M
%anet是属性网络邻接矩阵  M*N
%userne和 anet合并就成为SAN，社交属性网
unet=logical(zeros(m)); 
anet=logical(zeros(m,n)); 
%id是用户ID,fnum 是id的朋友数目，anum是id的属性数目
%下面给出一行数据，3是ID,3有1个朋友，3有4个属性
%3 1 4 2955 -16 -17 -18 -19
for i=[1:m]
    id=data(i,1);
    frnum=data(i,2);
    atnum=data(i,3);
    index=4;
    for j=[1:frnum]
        unet(id+1,data(i,index)+1)=1;
        index=index+1;
    end
    for j=[1:atnum]
        anet(id+1,-data(i,index))=1;
       
        index=index+1;
    end
end

%fnum[i]是用户i-1的朋友数 
%anum[i]是属性i的用户数
fnum=unet(1,:);%第一行
anum=anet(1,:);
for i=[2:m]
    fnum=fnum+unet(i,:);
    anum=anum+anet(i,:);
end

adata=zeros(n,max(anum));
for i=[1:m]
    id=data(i,1);
    frnum=data(i,2);
    atnum=data(i,3);
    index=4+frnum;

    for j=[1:atnum]
        adata(-data(i,index),1)=-data(i,index);
        adata(-data(i,index),adata(-data(i,index),2)+3)=id+1;
        adata(-data(i,index),2)=adata(-data(i,index),2)+1;
        index=index+1;
    end
end
save('sannet','unet','anet');

save('netdata','adata','data');


%存储布尔类型的数据网络
% save (strcat(filename,'data.mat'),'data')
% save(strcat(filename,'unet.mat'), 'unet');
% save(strcat(filename,'anet.mat'), 'anet'); 

