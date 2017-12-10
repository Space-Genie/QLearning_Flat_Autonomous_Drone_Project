function [actionval] = action_ind2val(actionind,actionmax)
%Takes a an action index in Q(s,a) and converts to a representative 1x3
%action vector taken into transition and reward functions 
actionval = zeros(1,3) ;

actionnumbers = 1 ;
for i = 1:length(actionmax)
    if actionind > sum(2*actionmax)+length(actionmax)
        error('Action index exceeds number of actions available')
    end
    if actionind < actionnumbers+(2*actionmax(i)+1)
        actionval(i) = actionind-actionnumbers-(actionmax(i)) ;
        break
    end 
    actionnumbers = actionnumbers+(2*actionmax(i)+1) ;
end 

end

