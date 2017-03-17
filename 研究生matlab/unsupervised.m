
function [linklable,linkpredictionresult,linkpredictionresulta,attrlable,attrreferenceresult] ...
    =unsupervised(fCN,aCN,CN_SAN,unet,anet,lableunet,lableanet,filename,threshold,b)

str='----  link prediction without attribute-----'


falseunet=~unet;
falseanet=~anet;
%对称图，只取下三角
falseunet=tril(falseunet,-1);
falseanet=tril(falseanet,-1);

linklable=lableunet(falseunet);

truefCN=fCN(unet);
maxtfCN=max(truefCN);
mintfCN=min(truefCN);
threshold=mintfCN+threshold*(maxtfCN-mintfCN);

linkpredictionresult=fCN(falseunet)>threshold;


str='----  link prediction with attribute-----'

faCN=fCN+b*aCN;
truefaCN=faCN(unet);
maxtfaCN=max(truefaCN);
mintfaCN=min(truefaCN);
threshold=mintfaCN+threshold*(maxtfaCN-mintfaCN);

linkpredictionresulta=faCN(falseunet)>threshold;

str='----  attribute reference -----'
attrlable=lableanet(falseanet);


trueCN_SAN=CN_SAN(anet);
maxtCN_SAN=max(trueCN_SAN);
mintCN_SAN=min(trueCN_SAN);
threshold=mintCN_SAN+threshold*(maxtCN_SAN-mintCN_SAN);
attrreferenceresult=CN_SAN(falseanet)>threshold;
