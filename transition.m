function [sp] = transition(s,a,statemax,actionmax)
% inputs the current state and action and gives the next state
% Input: s as a vector with actual state values
% Input: a is a vector with an integer in the entry of an action taken
            % ie [1 0 0 ] is unit  acceleration in z direction
% CHANGE AS NEEDED 
offaction = 0.05 ;
onaction = 0.1;

if find(a) == 1
    % z elevation update
    s(1) = round(normrnd(s(2)+s(1)+a(find(a)),onaction)) ;
    % z velocity update
    s(2) = round(normrnd(s(2)+a(find(a)),onaction)) ;
    % x angular position update
    s(3) = round(normrnd(s(3)+s(5),offaction)) ;
    % y angular position update
    s(4) = round(normrnd(s(4)+s(6), offaction)) ;
    % x angular rate update
    s(5) = round(normrnd(s(5), offaction)) ;
    % y angular rate update
    s(6) = round(normrnd(s(6), offaction))  ;  
elseif find(a) == 2
    % z elevation update
    s(1) = round(normrnd(s(1)+s(2),offaction)) ;
    % z velocity update
    s(2) = round(normrnd(s(2),offaction)) ;
    % x angular position update
    s(3) = round(normrnd(s(3)+s(5)+a(find(a)),onaction)) ;
    % y angular position update
    s(4) = round(normrnd(s(4)+s(6),offaction)) ;
    % x angular rate update
    s(5) = round(normrnd(s(5)+a(find(a)), onaction)) ;
    % y angular rate update
    s(6) = round(normrnd(s(6), offaction)) ;
elseif find(a) == 3 
    % z elevation update
    s(1) = round(normrnd(s(1)+s(2),offaction)) ;
    % z velocity update
    s(2) = round(normrnd(s(2),offaction)) ;
    % x angular position update
    s(3) = round(normrnd(s(3)+s(5),offaction)) ;
    % y angular position update
    s(4) = round(normrnd(s(4)+s(6)+a(find(a)),onaction)) ;
    % x angular rate update
    s(5) = round(normrnd(s(5), offaction)) ;
    % y angular rate update
    s(6) = round(normrnd(s(6)+a(find(a)), onaction)) ;
elseif isempty(find(a))
    % z elevation update
    s(1) = round(normrnd(s(1)+s(2),offaction)) ;
    % z velocity update
    s(2) = round(normrnd(s(2),offaction)) ;
    % x angular position update
    s(3) = round(normrnd(s(3)+s(5),offaction)) ;
    % y angular position update
    s(4) = round(normrnd(s(4)+s(6),offaction)) ;
    % x angular rate update
    s(5) = round(normrnd(s(5), offaction)) ;
    % y angular rate update
    s(6) = round(normrnd(s(6), offaction)) ;

end

% check for above z position or below ground, if so set the elevation to
% max or zero, also resets velocity
if s(1)>statemax(1)
    s(1) = statemax(1) ;
%     s(2) = 0 ;
    s(2) = -1 ;
elseif s(1)<0
    s(1) = 0 ;
%     s(2) = 0 ;
    s(2) = 1 ;
end

% do the same for x and y angular position, also resets velocity
if abs(s(3)) > statemax(3)
   if s(3) < 0
       s(3) = -statemax(3) ;
%        s(5) = 0 ;
       s(5) = 1 ;
   elseif s(3) > 0
       s(3) = statemax(3) ;
%        s(5) = 0 ;
       s(5) = -1 ;
   end
end

if abs(s(4)) > statemax(4)
   if s(4) < 0
       s(4) = -statemax(4) ;
%        s(6) = 0 ;
       s(6) = 1 ;
   elseif s(4) > 0
       s(4) = statemax(4) ;
%        s(6) = 0 ;
       s(6) = -1 ;
   end
end

% check if velocites are exceeding maxes, if so set to either +/- max
for i = [2,5,6]
if abs(s(i)) > statemax(i)
    if s(i) < 0
        s(i) = -statemax(i) ;
    elseif s(i) > 0
        s(i) =  statemax(i) ;
    end
end

% Define the next state
sp = s ;

end

