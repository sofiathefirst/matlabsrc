function [fCN,aCN,aCN_SAN]=CN(usernet,attrinet,filename)
[m,n]=size(attrinet);

susernet=sparse(tril(usernet,-1));
link=nnz(susernet);

%fCN(i,j)表示，用户i与用户j之间共同朋友的数，
usernet = double(usernet);
fCN=usernet*usernet;
        
%aCN(i,j)表示，用户i与用户j之间共同属性的个数，
attrinet= double(attrinet);
aCN=attrinet*attrinet';

CN_SAN=fCN+aCN;

fid=fopen(strcat(filename,'linkcnfew.txt'),'w');
for i=[2:m]
    for j=[1:i-1]
        if fCN(i,j)~=0 || aCN(i,j)~=0 || CN_SAN(i,j)~=0
            fprintf(fid, '<%d,%d>,%d,%d,%d,%d\n',i,j,fCN(i,j),aCN(i,j),CN_SAN(i,j),usernet(i,j));
        end     
    end
end
fclose(fid);

save('CN_SAN.mat', 'CN_SAN');
%aCN_SAN(i , j)表示用户i与属性j之间共同朋友的数，
aCN_SAN=usernet * attrinet;

fid=fopen(strcat(filename,'attrcnfew.txt'),'w');
for i=[1:m]
    for j=[1:n]
        if aCN_SAN(i,j)~=0
            fprintf(fid, '<%d,%d>,%d,%d\n',i,j,aCN_SAN(i,j),attrinet(i,j));
        end
    end     
end
fclose(fid);

%clear all

%***************************************
%***************************************
%***************************************
%Low rank approximation
%{
clear all
load usernet
load attrinet
LRS_SAN=[usernet,attrinet];
LRS_SAN=double(LRS_SAN);
k=floor(rank(LRS_SAN)*0.9);
[U,S,V]=svds(LRS_SAN,k,0);
LRS_SAN=U*S*V';
%}