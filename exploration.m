function action = exploration(Q_s,current_episode,numEpisodes,strategy)
% selects action based on the exploration strategy specified by input
% "strategy", which should be a string, either "e-greedy" or "softmax"
% other inputs include: 
% 1) Q_s_a, which is the vector Q values associated with the state-action 
% pairs from current state
% 2) t, which is the current time step. 
% 3) total_time, which is the total number of time steps specified in the
% problem
num_actions = size(Q_s); %specifies number of possible actions

if strcmp(strategy,'softmax') %perform softmax exploration
    %lambda_vec = linspace(0,50,total_time); %lambda is a linear function of the 
    % current time step; get increasingly more greedy as time goes on
%     lambda = lambda_vec(t); %select lambda to use based on current t
    if current_episode < numEpisodes/2
        lambda = 1;
    elseif current_episode > numEpisodes/2 && current_episode < numEpisodes-1
        lambda = 10;
    else
        lambda = 100;
    end

    if isempty(find(Q_s))
        Q_norm = Q_s;
    else
        Q_norm = (Q_s+abs(min(Q_s)))/sum(Q_s+abs(min(Q_s)));
    end
    prob_vec = exp(lambda*Q_norm);
    prob_vec_normalized = prob_vec/sum(prob_vec);
    action = find(rand<cumsum(prob_vec_normalized),1,'first');
    
elseif strcmp(strategy,'e-greedy') %perform epsilon greedy exploration
    epsilon = .7; 
    rand_action = rand<epsilon; %decides if we pick a random action or not
    if rand_action
        action = randi(num_actions);
    else
       [~,action] = max(Q_s);
    end
        
else
    error('please input valid exploration strategy, either "softmax" or "e-greedy"')
end
end
