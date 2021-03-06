hy=ezplot3('0','cos(t)','sin(t)',[0,2*pi]);
set(hy,'Color','b');
hold on
hx=ezplot3('cos(t)','0','sin(t)',[0,2*pi]);
set(hx,'Color','k');
ht=ezplot3('0.7071*cos(t)','0.7071*cos(t)','sin(t)',[0,2*pi]);
set(ht,'Color','r');
hb=ezplot3('0.5*cos(t)','0.5*sin(t)','-sqrt(3/4)',[0,2*pi]);
%plot3([0.5,0],[0,0.5],[-sqrt(3)/2,-sqrt(3)/2]);
plot3([0.5,0,-0.5,0,0.5],[0,0.5,0,-0.5,0],[-sqrt(3)/2,-sqrt(3)/2,-sqrt(3)/2,-sqrt(3)/2,-sqrt(3)/2],'g')
plot3([-0.5,0.5],[0,0],[-sqrt(3)/2,-sqrt(3)/2],'k')
plot3([0,0],[-0.5,0.5],[-sqrt(3)/2,-sqrt(3)/2],'b')
plot3([-1,1],[0,0],[0,0],'k')
plot3([0,0],[-1,1],[0,0],'b')

x1=[sqrt(3/4),0,-0.5];
x2=[0,0,-1];
y1=[0,sqrt(3/4),-0.5];
y2=[0,0,-1];
plot3([0.7,0.2,-0.2678476498,0.2321523502,0.7],[0.2,0.7,0.2321523502,-0.2678476498,0.2],[-0.6856,-0.6856,-.9350737526,-.9350737526,-0.6856],'r--')
plot3([-0.2678476498,0.7],[0.2321523502,0.2],[-.9350737526,-0.6856],'k--')
plot3([0.2321523502,0.2],[-0.2678476498,0.7],[-.9350737526,-0.6856],'b--')

plot3(sqrt(3/4),0,-0.5,'g*')
plot3(0,sqrt(3/4),-0.5,'g*')
plot3(0,0,-1,'g*')
hold off