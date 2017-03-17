function [LRA_SAN]=  LRA(unet,anet,filename,rate)

LRA_SAN=[unet,anet];
LRA_SAN=single(LRA_SAN);
%LRS_SAN=sparse(double(LRS_SAN));

k=floor(rate*rank(LRA_SAN));
[U,S,V]=svds(double(LRA_SAN),k);

LRA_SAN=U*S*V';


