function [Q,history1,history2,history3] = sarsa(t_episode,alpha,gamma,numEpisodes,statemax,actionmax)
% Conduct SARSA RL algorithm

% Initialize Q:
% Q is multidimensial arrary  that 7D, 6 for state vars and 1 for actions
Q = zeros([statemax(1)+1,statemax(2:end)*2+1 ,sum(actionmax(1:end)*2+1)]) ;

% initializes history matrices
history1 = zeros(t_episode,6 ) ;
history2 = history1 ;
history3 = history2 ;

% Loop thru a number of iterations
for k = 1:numEpisodes,k
    % Initial State on ground at rest
    s = [0,0,0,0,0,0] ;
    % Loops thru an episode 
    for t = 1:t_episode
        % converts states to state indices for Qmatrix
        s_inds = state2ind(s,statemax) ;
        
        % for the first time step this will pick an action index
        if t == 1
            at_ind = exploration(reshape(Q(s_inds(1),s_inds(2),s_inds(3),s_inds(4),s_inds(5),s_inds(6),:),1,sum(actionmax(1:end)*2+1)),k,numEpisodes,'softmax') ;
        end
        % converts action index to action value
        at = action_ind2val(at_ind,actionmax) ;
        % Finds next state given transition probabilites
        sp = transition(s,at,statemax,actionmax) ;
        % Gives correspondining state indices for state values
        sp_inds = state2ind(sp,statemax) ;
        % Conducts exploraton step and returns next action index
        ap_ind = exploration(reshape(Q(sp_inds(1),sp_inds(2),sp_inds(3),sp_inds(4),sp_inds(5),sp_inds(6),:),1,sum(actionmax(1:end)*2+1)),k,numEpisodes,'softmax') ;
        % Gives the reward for current state value, action value [NOT state index but actual values]
        rt = reward(s,at,statemax) ;
        % Performs sarsa update EQ. 5.25
        Q(s_inds(1),s_inds(2),s_inds(3),s_inds(4),s_inds(5),s_inds(6),at_ind) = ...
            Q(s_inds(1),s_inds(2),s_inds(3),s_inds(4),s_inds(5),s_inds(6),at_ind) + ...
            alpha*( rt + gamma*Q(sp_inds(1),sp_inds(2),sp_inds(3),sp_inds(4),sp_inds(5),sp_inds(6),ap_ind) - ...
            Q(s_inds(1),s_inds(2),s_inds(3),s_inds(4),s_inds(5),s_inds(6),at_ind) ) ;
        
        % Poplulates time histories for fifth, halfway, and final episode
        if k == 5
            history1(t,:) = s ;
        elseif k == round(numEpisodes/2)
            history2(t,:) = s ;
        elseif k == numEpisodes
            history3(t,:) = s ;
        end
        % assigns next state values as the current state
        s = sp ;
        % assigns next action index as current action index [NOT ACTION VALUE]
        at_ind = ap_ind ;

            
     end
end

end