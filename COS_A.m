t_max=3;
v_max=5;
k=2;
t1=3;
t2=6;
t3=9;
ts=[0:0.001:t3];
i=0;
v=ts;
a=ts;

T=2*t1;
for t = [0:0.001:t3]
    i=i+1;
    if(t<=t1)
        a(i)=k*0.5*cos((2*pi)/T*(t+t1))+k*0.5;
    elseif(t<=t2)
        a(i)=0;
    elseif(t<=t3)
        a(i)=k*0.5*cos((2*pi)/T*(t+t1-t2))-k*0.5;
    end
end
        
plot(ts,a)
