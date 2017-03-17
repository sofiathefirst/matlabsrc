syms x
t_max=3;
v_max=5;
k=1;
t1=3;
t2=6;
t3=9;
ts=[0.001:0.1:t3];
i=0;
v=ts;
a=ts;
l=ts;
r=ts;
w=ts;
v_max=0;
T=2*t1;
pi=3.1415926;
diff=ts;
for t =[0.001:0.1:t3]
    i=i+1;
    if(t<=t1)
        a(i)=k*0.5*cos((2*pi)/T*(t+t1))+k*0.5;
        %v(i)=int(k*0.5*cos((2*pi)/T*(x+t1))+k*0.5,0,t);
        v(i)=k*0.5*t1/pi*sin(2*pi/T*(t+t1))+k*0.5*t;
        diff(i)=0;
        w(i)=diff(i);
        l(i)=v(i);
        r(i)=v(i);
    elseif(t<=t2)
        a(i)=0;
        v(i)=int(k*0.5*cos((2*pi)/T*(x+t1))+k*0.5,0,t1);
        v_max=v(i);
        diff(i)=  sin((2*pi)/T*(t-t1));
        l(i)=v(i)+diff(i);
        r(i)=v(i)-diff(i);
        w(i)=-diff(i);
    elseif(t<=t3)
        a(i)=k*0.5*cos((2*pi)/T*(t+t1-t2))-k*0.5;
        %v(i)=int(k*0.5*cos((2*pi)/T*(x+t1))+k*0.5,0,t1)+int(   k*0.5*cos((2*pi)/T*(x+t1-t2))-k*0.5,t2,t);
        v(i)=v_max-0.5*k*(t-t2)+k*0.5*t1/pi*sin((2*pi)/T*(t+t1-t2));
        diff(i)=0;
        w(i)=diff(i);
        l(i)=v(i);
        r(i)=v(i);
    end
end

plot(ts,a,'--',ts,v,':',ts,w,'-o',ts,l,'.',ts,r,'x')




