function [policy] = writePolicy(Q)
% Write Policy from multi dimensional Q matrix

dim = size(Q) ;
policy = zeros(dim(1:end-1)) ;
for a = 1:dim(1)
    for b = 1:dim(2)
        for c = 1:dim(3)
            for d = 1:dim(4)
                for e = 1:dim(5)
                    for f = 1:dim(6)
                        Qsa = reshape(Q(a,b,c,d,e,f,:),1,dim(7)) ;
                        policy(a,b,c,d,e,f) = find(Qsa==max(Qsa), 1,'first') ;
                    end
                end
            end
        end
    end
end
        

% [m,i] = max(Q,[],2) ;
% policy = i ;

end