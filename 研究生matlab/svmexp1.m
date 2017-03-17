%TEST
dir='D:\\snakdd12\\';
filename='t1.txt';
% dir='D:\\snakdd12\\predict-new-links\\';
% filename='AUG4.txt';
[data,adata,unet,anet,fnum,anum]=GETSAN(dir,filename);
[m,n]=size(anet);
 [fCN,aCN,aCN_SAN]=CN(unet,anet,filename);
 [fAA,aAA,AA_SAN]=AA(data,unet,anet,filename,fnum,anum);


[OLRA]= lrao(unet,filename,0.9);
[LRA_CN]=lrao(fCN ,filename,0.9);
[LRA_AA]=lrao(fAA,filename,0.9);
 
[LRAsan]=LRA(unet,anet,filename,0.9);
[LRA_CNsan]=LRA(fCN+aCN,aCN_SAN,filename,0.9);
[LRA_AAsan]=LRA(fAA+aAA,AA_SAN,filename,0.9);
 [ORW,RWL,RWA]=RW(filename,30,data,adata,0.4,m,n)
 
 %ÏÂÈý½Ç
belowtri=logical(tril(ones(m),-1));
all=nnz(belowtri);
DATA=zeros(all,6);

LRA_CNsanl=LRA_CNsan(1:m,1:m);
LRA_CNsanr=LRA_CNsan(1:m,m+1:end);
LRA_AAsanl=LRA_AAsan(1:m,1:m);
LRA_AAsanr=LRA_AAsan(1:m,m+1:end);
LRAsanl=LRAsan(1:m,1:m);
LRAsanr=LRAsan(1:m,m+1:end);

DATA(:,1)=fCNsan(belowtri);
DATA(:,2)=fAAsan(belowtri);
DATA(:,3)=LRAsanl(belowtri);
DATA(:,4)=LRA_CNsanl(belowtri);
DATA(:,5)=LRA_AAsanl(belowtri);
DATA(:,6)=RWL(belowtri);

svmStruct = svmtrain(TRAIN,unet(trainlogi));

test(:,1)=fCNsan(zerosnodes);
test(:,2)=fAAsan(zerosnodes);  
test(:,3)=LRAsanl(zerosnodes);
test(:,4)=LRA_CNsanl(zerosnodes);
test(:,5)=LRA_AAsanl(zerosnodes);
test(:,6)=RWL(zerosnodes);

C2 = svmclassify(svmStruct, test,'showplot',true);

%*********************************

test=zeros(prenum,6);
TRAIN=zeros(nnz(trainlogi),6);

% TRAIN(:,1)=fCN(trainlogi);
% TRAIN(:,2)=fAA(trainlogi);
% TRAIN(:,3)=OLRA(trainlogi);
% TRAIN(:,4)=LRA_CN(trainlogi);
% TRAIN(:,5)=LRA_AA(trainlogi);
% TRAIN(:,6)=ORW(trainlogi);

TRAIN(:,1)=fCN(trainlogi);
TRAIN(:,2)=fAA(trainlogi);
TRAIN(:,3)=OLRA(trainlogi);
TRAIN(:,4)=LRA_CN(trainlogi);
TRAIN(:,5)=LRA_AA(trainlogi);
TRAIN(:,6)=ORW(trainlogi);
svmStruct = svmtrain(TRAIN,unet(trainlogi));

test(:,1)=fCN(zerosnodes);
test(:,2)=fAA(zerosnodes);
test(:,3)=OLRA(zerosnodes);
test(:,4)=LRA_CN(zerosnodes);
test(:,5)=LRA_AA(zerosnodes);
test(:,6)=ORW(zerosnodes);

C1 = svmclassify(svmStruct, test,'showplot',true);
          
%TEST
filename='t1_test.txt';
% dir='D:\\snakdd12\\predict-new-links\\';
% filename='AUG4.txt';
[Tdata,Tadata,Tunet,Tanet,Tfnum,Tanum]=GETSAN(dir,filename);
[Tm,Tn]=size(Tunet);
label=Tunet( zerosnodes);
% [TfCN,TaCN,TaCN_SAN]=CN(Tunet,Tanet,filename);
 
 errRate2 = sum(label~= C2)/prenum;
  errRate1 = sum(label~= C1)/prenum;