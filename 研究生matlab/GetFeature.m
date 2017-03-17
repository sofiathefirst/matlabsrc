%function [ORW,RWL,RWA,fCN,aCN,CN_SAN,fAA,aAA,AA_SAN,OLRA,LRA_CN,LRA_AA]= GetFeature(dir,filename,n,a,b,step)
function GetFeature(dir,filename,n,a,b,step)
%TEST
% dir='D:\\snakdd12\\';
% filename='t1.txt';
% dir='D:\\snakdd12\\predict-new-links\\';
% filename='AUG4.txt';
% n=6;
% a=0.4;
% b=1;
% step=30;
%b是属性信息比结构信息的值，b=1属性信息 结构信息各占1份
%a是重启概率
%step 是游走步数

%data原始数据文件,adata,unet,anet,fnum,anum,m
[data,adata,unet,anet,fnum,anum,m]=GETSAN(dir,filename,n);
 strr='----计算 RW ----'
% [ORW,RWL,RWA]=RW(filename,step,data,adata,a,m,n);

clear adata
%  [fCN,aCN,CN_SAN]=CN(unet,anet,filename);
%  save (strcat(filename,'cnfeature.mat'),'fCN','aCN','CN_SAN');
 
  [fAA,aAA,AA_SAN]=AA(data,unet,anet,filename,fnum,anum);
  save (strcat(filename,'aafeature.mat'),'fAA','aAA','AA_SAN');
% clear data
% clear fnum
% clear anum
%  strr='----计算 OLRA ----'
% 
%  [OLRA]= LRA(unet,anet,filename,0.9);
% clear unet anet;
%   strr='----计算 LRA_CN ----'
%  [LRA_CN]=LRA(fCN+b*aCN,CN_SAN,filename,0.9);
%    strr='----计算 LRA_AA ----'
%  [LRA_AA]=LRA(fAA+b*aAA,AA_SAN,filename,0.9);
