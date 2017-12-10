function R = reward(state, action,statemax)
% returns the reward associated with the state and action pair
% state is a vector organized as such:
% [vertical position, vertical velocity, x-angular position, y-angular position, x-angular velocity, y-angular velocity]
% action chosen based upon exploration strategy, as described
S = state;
a = action;

% hover state:
% CHANGE AS WANTED
hoverstate = 15 ;

s = S ;


% % % EVEN NEWER
% % % sparse reward approach
% % zpos = s(2) + s(1) + a(1) ;
% % xang = s(3) + s(5) + a(2);
% % yang = s(4) + s(6) + a(3);
% % R = 0 ;
% % reward for being within 2 states of over state or within 1 state of angle
% % if abs(zpos-hoverstate) <= 1
% %     Rz = 1000 ;
% %     R = R+Rz ;
% % elseif abs(xang) <= 1 && abs(yang) <= 1
% %     Rx = 10 ;
% %     R = R+Rx ;
% % end
% % 
% % elseif abs(yang) <= 1
% %     Ry = 100 ;
% %     R = R+Ry ;
% %     
% % % Penalties for goinng beyond state maxes
% % elseif zpos > statemax(1)
% %     R = R - 1000 ;
% % elseif abs(xang) > statemax(3)
% %     R = R - 100 ;
% % elseif abs(yang) > statemax(4)
% %     R = R - 100 ;
% % end
% % 
% % % Penalty for moving away from hover state and 

% sparse reward approach
zpos = s(1)  ;
v = s(2) ;
xang = s(3) ;
yang = s(4);
xomega = s(5);
yomega = s(6);
R = 0 ;

% % are we at any maximum states?
% if zpos == statemax(1) || v == statemax(2) || abs(xang) == statemax(3)...
%         || abs(yang) == statemax(4) || abs(xomega) == statemax(5) || abs(yomega) == statemax(6)
%     atmax = 1;
% else
%     atmax = 0;
% end
% reward for being within 1 states of hover state or within 2 state of angle
if abs(zpos-hoverstate) <= 1 %&& ~atmax
    Rz = 10000 ;
    R = R+Rz ;
end
if abs(zpos-hoverstate) <= 1 && abs(xang) <= 1 && abs(yang) <= 1 %&& ~atmax
    Rx = 100000 ;
    R = R+Rx ;
end
if abs(v) <= 1 && abs(zpos-hoverstate) <= 1
    R = R+5000;
end
if abs(xang) <= 2 && abs(yang) <= 2 %&& ~atmax
    Rang = 1000 ;
    R = R + Rang ;
end
    
% Penalties for being at state maxes, along with rewards for moving away
if zpos == statemax(1)
    R = R - 1000 - a(1)*10;
end
if abs(xomega) == statemax(5)
    R = R - 10 - sign(a(2))*sign(s(5))*1;
end
if abs(yomega) == statemax(6)
    R = R - 10 - sign(a(3))*sign(s(6))*1;
end
if abs(xang) == statemax(3)
    R = R - 10 - sign(s(5))*sign(s(3))*10;
end
if abs(yang) == statemax(4)
    R = R - 10 - sign(s(6))*sign(s(4))*10;
end

% Penalty for being at the ground
if s(1) == 0
    R = R - 10000;
end






% %NEW:
% s = S ; 
% 
% if find(a) == 1
%     
%     vel = s(2) + a(find(a)) ;
%     pos = vel + s(1) ;
%     if pos > statemax(1) || pos < 0
%         R = -100 ;
%     else
%         if abs(hoverstate - pos)< abs(hoverstate - s(1))
%         rewardbelow = linspace(0,10,hoverstate+1) ; 
%             rewardabove = linspace(10,0,statemax(1)-hoverstate+1) ;
%             rewardvect = [rewardbelow rewardabove(2:end)] ;
%             R = rewardvect(pos+1) ;
%         
%         elseif abs(hoverstate-pos) >= abs(hoverstate - s(1))
%             rewardbelow = linspace(10,0,hoverstate+1) ; 
%             rewardabove = linspace(0,10,statemax(1)-hoverstate+1) ;
%             rewardvect = [rewardbelow rewardabove(2:end)] ;
%             R = -rewardvect(pos+1) ;
%         end
%     end
% 
%     
% elseif find(a) == 2 
%     
%     vel = s(5) + a(find(a)) ;
%     pos = vel + s(3) ;
%     if abs(pos) > statemax(3)
%         R = -100 ;
%     else
%         if abs(pos) < abs(s(3))
%             rewardbelow = linspace(0,1,statemax(3)+1) ;
%             rewardabove = linspace(1,0,statemax(3)+1) ;
%             rewardvect = [rewardbelow rewardabove(2:end)] ;
%             R = rewardvect(pos+statemax(3)+1) ;
%         elseif abs(pos) >= abs(s(3))
%             rewardbelow = linspace(100,0,statemax(3)+1) ;
%             rewardabove = linspace(0,100,statemax(3)+1) ;
%             rewardvect = [rewardbelow rewardabove(2:end)] ;
%             R = -rewardvect(pos+statemax(3)+1) ;
%         end
%     end
%     
% elseif find(a) == 3
%     
%     
%     vel = s(6) + a(find(a)) ;
%     pos = vel + s(4) ;
%     if abs(pos) > statemax(4)
%         R = -10000 ;
%     else
%         if abs(pos) < abs(s(4))
%             rewardbelow = linspace(1,0,statemax(4)+1) ;
%             rewardabove = linspace(0,1,statemax(4)+1) ;
%             rewardvect = [rewardbelow rewardabove(2:end)] ;
%             R = rewardvect(pos+statemax(4)+1) ;
%         elseif abs(pos) >= abs(s(4))
%             rewardbelow = linspace(1,0,statemax(4)+1) ;
%             rewardabove = linspace(0,1,statemax(4)+1) ;
%             rewardvect = [rewardbelow rewardabove(2:end)] ;
%             R = -rewardvect(pos+statemax(4)+1) ;
%         end
%     end
% 
% elseif isempty(find(a))
%     zpos = s(2) + s(1) ;
%     xang = s(3) + s(5) ;
%     yang = s(4) + s(6) ;
%     if abs(zpos-hoverstate) < 2 && abs(xang) < 1 && abs(yang) < 1
%         R = 5 ;
%     else
%         R = 0 ;
%     end
%     
% end 




% % ORIGINAL:
% num_alt_states = statemax(1)+1; %number of defined altitude states
% hover_state = 15; %goal hover altitude
% 
% penalty_ang_factor = -20; %factor multiplying the penalty given to angular positions and velocities
% % reward_vel_factor = 1; %factor multiplying the reward matrix given to vertical velocity state
% penalty_accel_factor = -5; %factor multiplying the action integer to generate penalty
% Alt = S(1)+1;
% 
% R = 0; %initialize reward to 0
% 
% %% angular position penalty function
% Ang_x = abs(S(3));
% Ang_y = abs(S(4));
% R = R + penalty_ang_factor*Ang_x;
% R = R + penalty_ang_factor*Ang_y;
% %% altitude reward function
% if Ang_x <= 1 && Ang_y <= 1
%     reward_alt_states = 1:hover_state; %ground is state 1
%     penalty_alt_states = 1:(num_alt_states - hover_state); 
% 
%     reward_alt_vector = 1e-4*exp(reward_alt_states); %define exponential curve for reward, increasing up to optimal hover state
%     penalty_alt_vector = -exp(penalty_alt_states);
% 
%     R_alt_vector = [reward_alt_vector penalty_alt_vector];
%     alt_state = S(1)+1; %current altitude state
% 
%     R = R + R_alt_vector(alt_state);
% end
% % 
% % if Ang_x <= 1 && Ang_x <= 1 && abs(Alt - hover_state) <= 1
% %     R = R+1000;
% % end
% 
% 
% 
% %% vertical velocity reward function
% % reward_matrix = zeros(num_vertvel_states/2,num_alt_states);
% % divisor = num_alt_states/(num_vertvel_states/2-1);
% % for i = 1:num_vertvel_states
% %     reward_matrix(i,:) = linspace(((i-1)*divisor),(num_alt_states - (i-1)*divisor),num_alt_states);
% % end
% % reward_matrix = reward_vel_factor*reward_matrix;
% % reward_matrix = [flipud(reward_matrix); reward_matrix];
% % Vel_vert = S(2);
% % 
% % R = R + reward_matrix(Vel_vert, alt_state);
% 
% 
% %% action penalty function
% if a(1) < 1
%     a(1) = 0;
% end
% R = R + sum(abs(a)*penalty_accel_factor);
% 
% %% Penalty for moving into ground
% if (S(1) + S(2)) < 0
%     R = R - 100;
% end
R;


end