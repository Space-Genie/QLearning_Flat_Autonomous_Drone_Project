function [ind] = state2ind(state,statemax)
%Takes a state ie [00000] and converts to index of multiD array
ind = zeros(1,6) ;
% shift up 1 for vertical position
ind(1) = state(1)+1 ;

% all other states have odd entries and symmetric about 0
for i = 2:length(state)
    ind(i) = state(i)+statemax(i)+1 ;
end
%
end

