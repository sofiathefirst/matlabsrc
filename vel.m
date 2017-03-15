t_max=3;
v_max=5;
ts=[0:0.001:10];
i=0;
v=ts;
for t = [0:0.001:10]
    i=i+1;
    if (t<3)
        v(i)=v_max/t_max/t_max*power(t,2);
    
    elseif(t<6)
        v(i)=v_max;
    elseif(t<9)
       v(i)= v_max-2*v_max/t_max*(t-6)+v_max/t_max/t_max*power(t-6,2);   
    else 
        v(i)=0;
     end
    end
        
plot(ts,v)
