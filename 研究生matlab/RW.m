function [ORW,RWL,RWA]=RW(filename,step,data,adata,a,m,n)
%ORW�ڴ�ͳ�����ϵ��������
%RWL��SAN�ϵ��������,����link
%RWA��SAN�ϵ��������,����attribute
%a����������
%step �����߲���
%ORW�ڴ�ͳ�����ϵ��������
ORW=zeros(m);
str='*****************ORW***************' 
for i=[1:m]%i is p*
    %i
   ORW(i,i)=1;
    x=0;
    p=i;
    if data(p,2)==0
        continue
    end
    p=data(p,floor( 4+(data(p,2))*rand()))+1;
    
    for j=[2:step]       
        %p
        for k=[data(p,4:3+data(p,2))+1]%p������
            x=x+ORW(i,k);
        end
        ORW(i,p)=(1-a)*x;
        if p==i
            ORW(i,p)=ORW(i,p)+a;
        end
        
        back=rand();       
        if back<a
            %str='back'
            p=i;
        else
            p=data(p,floor( 4+(data(p,2))*rand()))+1;
        end
            
    end
end
            
str='*****************SAN***************'        
%RWL��SAN�ϵ��������,����link
%RWA��SAN�ϵ��������,����attribute
RWL=zeros(m);
RWA=zeros(m,n);
for i=[1:m]%i is p*
    %ORW(i,i)=1;
    %i
    p=i;
    RWL(p,p)=1;
    x=0;
    for j=[1:step]    
        
        back=rand();       
         if back<a %������
            %str='back'
            p=i;
        else
            %walk ���ھ���               
            if p>0 %˵����person node
                if (data(p,2)+data(p,3))==0
                    break
                end
                  p=data(p,floor( 4+(data(p,2)+data(p,3))*rand()));            
                 if p>=0 
                     p=p+1;
                 end
            else %����node
              
                if adata(-p,2)==0
                    break
                end
                p=adata(-p,floor( 3+(adata(-p,2) )*rand()));
            end
         end
         
        %p
        x=0;
        if p>0%���� r p
            %str='p������'
            for k=[data(p,4:3+data(p,2))+1]%p������               
                %k
                x=x+RWL(i,k);
            end
               %str='p������'
            for k=[-data(p,4+data(p,2):3+data(p,2)+data(p,3))]%p������              
                %k
                x=x+RWA(i,k);
            end
           
            RWL(i,p)=(1-a)*x;
            if p==i
                     RWL(i,p)=RWL(i,p)+a;
            end
         else %����r a
        
            for k=[adata(-p,3:2+adata(-p,2))]%p������
                %str='a������'
                %k
                x=x+RWL(i,k);
            end
            RWA(i,-p)=(1-a)*x;
        end
        
       
    end
end

    ORW=(ORW+ORW')/2;
    RWL=(RWL+RWL')/2;