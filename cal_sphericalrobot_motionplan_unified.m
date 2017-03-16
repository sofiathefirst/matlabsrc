function curve = cal_sphericalrobot_motionplan_unified(Friction,R,r,m_wheel,m_global,m_platform,l,beta,J_wheel,Ja,Jb)
g= 9.8;
gap =20;
times = 3;
symmetric =0;
T =2;
T1 =T;%total time (s)
T2 =T;
T3 =T;

C1 = (R^2 - R*r)*2*J_wheel/r/r;
C2 = (R - r)^2*2*J_wheel/r/r + 2*m_wheel*(R - r)^2 + Jb + m_platform*l*l;
C3 = Ja + (m_global + 2*m_wheel + m_platform)*R*R + 2*J_wheel*R*R/r/r;
C4 = m_platform*l +  2*m_wheel*(R - r)*sin(beta);
theta_max = asin(-Friction/g/C4);

% find =( (C1 + C2 + C4*R)*pi^2*0.8479/2/T/T - Friction)*r/4/R; %calculate t=0,wheel's torque

theta_gd_cal = 0;

theta_1d_cal = 0;
theta_g_cal = 0;
lost = C4*sin(theta_max)*g + Friction;
 ggg = ((theta_max*pi*pi)*(C2 + C1 + C4*R*cos(theta_max)) - 2*lost*T*T)/(C1 + C3 + C4*R*cos(theta_max))/2/T/T;


for t = 0:gap:times*T*1000
    t = t/1000;

if t >= 0 &&  round(t*1000) <= round(T1*1000)
    lost = C4*sin(theta_max)*g + Friction;
    theta_gdd_cal = ((pi*pi*theta_max)*(C2 + C1 + C4*R*cos(theta_max)) - 2*T1*T1*lost)*(1 + cos(pi*(t+T1)/T1))/4/T1/T1/(C1 + C3 + C4*R*cos(theta_max));
    theta_bdd_cal = theta_max*pi*pi*cos(pi*t/T1)/2/T1/T1;
    theta_bd_cal  = theta_max*theta_max*pi*pi*(sin(pi*t/T1))^2/4/T1/T1;
    % theta_b_cal   = theta_max*(1-cos(pi*t/T1))/2;
    theta_b_cal   = theta_max*(sin(pi*t/2/T1))^2;
theta_gd_cal_plan = ggg*t/2 + ggg*T1*sin(pi*(t+T1)/T1)/2/pi;
    % theta_gdd_cal_copy(round(t*1000+1)) = -theta_gdd_cal;

    theta_1dd_cal = (theta_gdd_cal + theta_bdd_cal)*R/r;
    TOR = ((theta_gdd_cal*(C1 + C3 + C4*R*cos(theta_b_cal)) + theta_bdd_cal*(C2+ C1 + C4*R*cos(theta_b_cal)) + theta_bd_cal*(-C4*R*sin(theta_b_cal)) + C4*g*sin(theta_b_cal)) - Friction)*r/4/R;
    TOR_copy(round(t*1000+1)) = -TOR;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
elseif  round(t*1000) >= round((T1+T2)*1000) &&  round(t*1000) <= round(3*T*1000)
    tt = t -(T1+T2);
    % theta_gdd_cal = theta_gdd_cal_copy(round((3*T - t)*1000+1));
    theta_bdd_cal = -theta_max*pi*pi*cos(pi*tt/T3)/2/T3/T3;
    theta_bd_cal  = -theta_max*theta_max*pi*pi*(sin(pi*tt/T3))^2/4/T3/T3;
    theta_b_cal   = theta_max*(1+cos(pi*tt/T3))/2;
    
    if symmetric
        TOR = TOR_copy(round((3*T - t)*1000+1));
        theta_gdd_cal =( TOR*R*4/r + Friction- theta_bdd_cal*(C2+ C1 + C4*R*cos(theta_b_cal)) - theta_bd_cal*(-C4*R*sin(theta_b_cal)) - C4*g*sin(theta_b_cal))/(C1 + C3 + C4*R*cos(theta_b_cal));
    else
        theta_gdd_cal = ((pi*pi*theta_max)*(C2 + C1 + C4*R*cos(theta_max)) - 2*T3*T3*lost)*(-1 + cos(pi*(tt+T3)/T3))/4/T3/T3/(C1 + C3 + C4*R*cos(theta_max));
        
        TOR = ((theta_gdd_cal*(C1 + C3 + C4*R*cos(theta_b_cal)) + theta_bdd_cal*(C2+ C1 + C4*R*cos(theta_b_cal)) + theta_bd_cal*(-C4*R*sin(theta_b_cal)) + C4*g*sin(theta_b_cal)) - Friction)*r/4/R;
    end
    theta_1dd_cal = (theta_gdd_cal + theta_bdd_cal)*R/r;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
else
    theta_gdd_cal = 0;
    theta_1dd_cal = 0;
    theta_bdd_cal = 0;
    TOR = -Friction*r/2/R;
    a = 0;
end

theta_gd_cal = theta_gd_cal + theta_gdd_cal*gap/1000;
theta_1d_cal = theta_1d_cal + theta_1dd_cal*gap/1000;
theta_g_cal = theta_g_cal + theta_gd_cal*gap/1000;
 if times == 3
    figure(1)
    hold on
    subplot(1,3,1);plot(t,theta_bdd_cal,'k.');title('圆盘角加速度-plan(rad/s^2)');
    hold on
    subplot(1,3,2);plot(t,theta_bd_cal ,'k.');title('圆盘角速度-plan(rad/s)');
    hold on
    subplot(1,3,3);plot(t,theta_b_cal,'k.');title('圆盘角度-plan(rad)');
    figure(2)
    hold on
    subplot(2,2,1);plot(t,theta_gdd_cal,'k.');title('球壳角加速度-dynamic(rad/s^2)');
    hold on
    subplot(2,2,2);plot(t+gap/1000,theta_gd_cal,'k.');title('球壳角速度-dynamic(rad/s^)');

    hold on 
    subplot(2,2,3);plot(t+gap/1000,theta_1d_cal,'k.');title('轮子角速度-dynamic(rad/s^)');
    hold on
    subplot(2,2,4);plot(t,theta_1dd_cal,'k.');title('轮子角加速度-dynamic(rad/s^2)');
    figure(3)
    hold on
    plot(t,TOR,'k.');title('轮子力矩(N.m)');
    figure(4)
    hold on
    plot(t+gap/1000,theta_gd_cal,'k.');title('轮子力矩(N.m)');
 else
hold on
subplot(2,4,1);plot(t,theta_bdd_cal,'k.');title('圆盘角加速度-plan(rad/s^2)');
hold on
subplot(2,4,2);plot(t,theta_bd_cal ,'k.');title('圆盘角速度-plan(rad/s)');
hold on
subplot(2,4,3);plot(t,theta_b_cal,'k.');title('圆盘角度-plan(rad)');
hold on
subplot(2,4,4);plot(t,theta_gd_cal_plan,'k.');title('轮子力矩(N.m)');
hold on
subplot(2,4,5);plot(t,theta_gdd_cal,'k.');title('球壳角加速度-dynamic(rad/s^2)');
hold on
subplot(2,4,6);plot(t+gap/1000,theta_gd_cal,'k.');title('球壳角速度-dynamic(rad/s^)');

hold on 
subplot(2,4,8);plot(t+gap/1000,theta_1d_cal,'k.');title('轮子角速度-dynamic(rad/s^)');
hold on
subplot(2,4,7);plot(t,theta_1dd_cal,'k.');title('轮子角加速度-dynamic(rad/s^2)');
 end
% hold on
% subplot(2,3,1);plot(t,TOR,'k.');title('轮子力矩(N.m)');
% hold on
% subplot(2,3,2);plot(t,theta_gdd_cal,'k.');title('球壳角加速度-dynamic(rad/s^2)');
% 
%     hold on
%     subplot(2,3,3);plot(t+gap/1000,theta_gd_cal/1000,'k.');title('球壳角速度-dynamic(rad/s^)');
% hold on
% subplot(2,3,4);plot(t,theta_b_cal,'k.');title('圆盘角度-plan(rad)');
% hold on
% subplot(2,3,5);plot(t,theta_bd_cal,'k.');title('圆盘角速度-plan(rad/s)');
% hold on
% subplot(2,3,6);plot(t,theta_bdd_cal,'k.');title('圆盘角加速度-plan(rad/s^2)');
end

end

% lost = C4*sin(theta_max)*g + Friction;

% ggg = C3;
% bbg = 2*J_wheel*(R-r)^2/r/r + Jb + m_platform*l*l + 2*m_wheel*(R-r)^2;
% bg  = -m_wheel*g*(R-r)*cos(theta_max + beta) + m_wheel*g*(R-r)*cos(-theta_max + beta) + m_platform*g*l*sin(theta_max);
% ggb = (R^2 - R*r)*2*J_wheel/r/r + m_wheel*R*(R-r)*sin(theta_max + beta) + m_wheel*R*(R-r)*sin(-theta_max + beta)+m_platform*R*l*cos(theta_max);
% gb = m_platform*R*(R-r)*cos(theta_max + beta) - m_platform*R*(R-r)*cos(-theta_max + beta) - m_platform*R*l*sin(theta_max);
% bbb = ggb;
% ansss = (-Friction + 2.9057*(ggb + bbg)-bg)/(ggg + bbb);