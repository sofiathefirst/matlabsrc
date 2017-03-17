function [ORW,RWL,RWA]=RW(filename,step,data,adata,a,m,n)
%ORW在传统网络上的随机游走
%RWL在SAN上的随机游走,用于link
%RWA在SAN上的随机游走,用于attribute
%a是重启概率
%step 是游走步数
%ORW在传统网络上的随机游走
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
        for k=[data(p,4:3+data(p,2))+1]%p的朋友
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
%RWL在SAN上的随机游走,用于link
%RWA在SAN上的随机游走,用于attribute
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
         if back<a %重启动
            %str='back'
            p=i;
        else
            %walk 到邻居上               
            if p>0 %说明是person node
                if (data(p,2)+data(p,3))==0
                    break
                end
                  p=data(p,floor( 4+(data(p,2)+data(p,3))*rand()));            
                 if p>=0 
                     p=p+1;
                 end
            else %属性node
              
                if adata(-p,2)==0
                    break
                end
                p=adata(-p,floor( 3+(adata(-p,2) )*rand()));
            end
         end
         
        %p
        x=0;
        if p>0%计算 r p
            %str='p的朋友'
            for k=[data(p,4:3+data(p,2))+1]%p的朋友               
                %k
                x=x+RWL(i,k);
            end
               %str='p的属性'
            for k=[-data(p,4+data(p,2):3+data(p,2)+data(p,3))]%p的属性              
                %k
                x=x+RWA(i,k);
            end
           
            RWL(i,p)=(1-a)*x;
            if p==i
                     RWL(i,p)=RWL(i,p)+a;
            end
         else %计算r a
        
            for k=[adata(-p,3:2+adata(-p,2))]%p的朋友
                %str='a的朋友'
                %k
                x=x+RWL(i,k);
            end
            RWA(i,-p)=(1-a)*x;
        end
        
       
    end
end

    ORW=(ORW+ORW')/2;
    RWL=(RWL+RWL')/2;