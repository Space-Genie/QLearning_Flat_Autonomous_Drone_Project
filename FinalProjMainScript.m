clc ; clear all ; close all 

% Set length of an episode
t_episode = 100 ;
% Set number of episodes
numEpisodes = 100000 ;

% Maximum state value: [Zpos Zvel Xang Yang Xvel Yvel]
% Total number of Zpos = statemax(1)+1
% all other values are symmetric about zero
statemax = [20,10,10,10,5,5] ;
actionmax = [3, 3, 3] ;

% Run Learning Algorithm
% Learning Parameter alpha
alpha = 0.8 ;

% discount factor
gamma = 0.9 ;

% History1,2,3 are t_episode by n state vars takes at beginnning, middle,
% and end of training
[Q,history1,history2,history3] = sarsa(t_episode,alpha,gamma,numEpisodes,statemax,actionmax) ;

% Write Policy
% note that policy is in action indices not actual action values
% policy = writePolicy(Q) ;

% Execute Policy

%% Post Process
% p = patch; p.FaceAlpha = 0.25;
% h = make_fig([],'Time History of Drone');

figure(1)
t = 1:t_episode ;
subplot(2,1,1)
hold on
plot(t,history3(:,1),'k','LineWidth',2); 
fill([0,100,100,0],[14,14,16,16],'g','FaceAlpha',0.2,'EdgeColor','none');
title('Altitude'); grid on;
xlabel('Time step'); ylabel('Z','Rotation',0);
ylim([0 20]);
hold off;
% subplot(3,1,2)
% plot(t,history3(:,2))
% title('v_z'); grid on;
subplot(2,1,2)
hold on;
plot(t,history3(:,3)*45/10,'r','LineWidth',2)
title('Rotation about X-axis (\theta_x)'); grid on;
fill([0,100,100,0],[4.5,4.5,-4.5,-4.5],'g','FaceAlpha',0.2,'EdgeColor','none');
ylim([-45,45]); ylabel('\theta_{x}','Rotation',0); xlabel('Time Step');
hold off;

% subplot(3,1,3)
% hold on;
% plot(t,history3(:,4)*45/10,'m','Linewidth',2)
% fill([0,100,100,0],[1,1,-1,-1],'g','FaceAlpha',0.2,'EdgeColor','none');
% title('\theta_y'); grid on;
% ylim([-45,45]); ylabel('\theta_{y} [Degrees]');
% hold off;
% subplot(3,1,3)
% plot(t,history3(:,5))
% title('\omega_x'); grid on;
% subplot(3,2,6)
% plot(t,history3(:,6))
% title('\omega_y'); grid on;

% save(
