
function [data,adata,unet,anet,fnum,anum,m]=GETSAN(dir,filename,n)
%'D:\\snakdd12\\predict-new-links\\AUG4.txt'
data = dlmread(strcat(dir,filename));
m=size(data);
m=m(1);

%�û���ΪM,������ΪN
%unet�Ǵ�ͳ�罻�����ڽӾ���M*M
%anet�����������ڽӾ���  M*N
%userne�� anet�ϲ��ͳ�ΪSAN���罻������
unet=logical(zeros(m)); 
anet=logical(zeros(m,n)); 
%id���û�ID,fnum ��id��������Ŀ��anum��id��������Ŀ
%�������һ�����ݣ�3��ID,3��1�����ѣ�3��4������
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

%fnum[i]���û�i-1�������� 
%anum[i]������i���û���
fnum=unet(1,:);%��һ��
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


%�洢�������͵���������
% save (strcat(filename,'data.mat'),'data')
% save(strcat(filename,'unet.mat'), 'unet');
% save(strcat(filename,'anet.mat'), 'anet'); 

