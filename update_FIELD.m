%-------------------------------------------------------------------------
% FIELD: the matrix, which represents the game field
% FIELD_size: the size of the game field
% n: cycle counter of the game
% who_starts: 0 if the player starts, 1 if the computer starts
% B,A: coordinates of the last stone in the
%-------------------------------------------------------------------------
% FIELD: the updated FIELD
%-------------------------------------------------------------------------
function [FIELD]=update_FIELD(FIELD,FIELD_size,n,who_starts,B,A)

if (mod(FIELD_size^2-n+who_starts,2)==0)

    % Case X --> 2
    FIELD(B,A)=2;

else

    % Case O --> 1
    FIELD(B,A)=1;

end
