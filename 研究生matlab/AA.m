function [fAA,aAA,AA_SAN]=AA(data,unet,anet,filename,fnum,anum)
[m,n]=size(anet);
%fnum[i]���û�i-1�������� 
%anum[i]������i���û���
%afnum[i]���û�i��������
%fnum=unet(1,:);%��һ��
%anum=anet(1,:);
afnum=anet(:,1);%��һ��

for i=[2:n]
    afnum=afnum+anet(:,i);
end
unet=single(unet);
anet=single(anet);

%linkAA
fAA=zeros(m);
aAA=zeros(m);
strr='----����fAA----'
for i=[1:m]
    
    for j=[i+1:m]
        for k=[data(i,4:3+data(i,2))+1]%i������
            if unet(i,k)==1 && unet(j,k)==1
                fAA(i,j)= fAA(i,j)+1.0/fnum(k);
            end
        end
            fAA(j,i)=fAA(i,j);
    end
end
strr='----����aAA----'
for i=[1:m]
    
    for j=[i+1:m]
        for k=[-data(i,4+data(i,2):3+data(i,2)+data(i,3))]%i������
            if anet(i,k)==1 && anet(j,k)==1
                aAA(i,j)= aAA(i,j)+1.0/anum(k);
            end
        end
            aAA(j,i)=aAA(i,j);
    end
end


%attrAA
AA_SAN=zeros(m,n);
strr='----����AA_SAN----'
for i=[1:m]
    
    for j=[1:n]
         for k=[data(i,4:3+data(i,2))+1]
            if unet(i,k)==1 && anet(k,j)==1
                AA_SAN(i,j)= AA_SAN(i,j)+1.0/(fnum(k)+afnum(k));
            end
         end
    end
end


